use std::{env, collections::HashMap};

use mysql::{Pool, prelude::Queryable, params};

#[derive(Debug)]
struct Supplier {
    name: String,
    street: String,
    house_number: usize,
    zip_code: String,
    town: String,
    telephone: String,
}

#[derive(Debug)]
struct Ingredient {
    name: String,
    unit: String,
    price: f64,
    count: usize,
    calories: f64,
    carbs: f64,
    protein: f64,
    supplier: String,
}

fn main() {
    // process arguments
    let mut args = env::args();
    args.next();
    let path = args.next().unwrap();
    if args.next() != None {
        panic!("please supply only one argument");
    }
    
    // read csv file
    let mut reader = csv::ReaderBuilder::new()
        .delimiter(b';')
        .quote(b'"')
        .from_path(path)
        .unwrap();
    let vec = reader.records().map(|r| {
        r.unwrap().iter().map(str::trim).map(String::from).collect::<Vec<_>>()
    }).collect::<Vec<_>>();
    
    // process data
    let mut suppliers = HashMap::<String, Supplier>::new();
    let mut ingredients = Vec::<Ingredient>::new();
    for entry in vec {
        let supplier_name = entry.get(2).unwrap().clone();
        if !suppliers.contains_key(&supplier_name) {
            let (street, house_number, zip_code, town, telephone) = parse_contact_information(entry.get(3).unwrap());
            suppliers.insert(supplier_name.clone(), Supplier {
                name: supplier_name.clone(),
                street,
                house_number,
                zip_code,
                town,
                telephone,
            });
        }
        let ingredient = Ingredient {
            name: entry.get(0).unwrap().clone(),
            unit: entry.get(1).unwrap().clone(),
            price: entry.get(8).unwrap().parse::<f64>().unwrap(),
            count: entry.get(4).unwrap().parse::<usize>().unwrap(),
            calories: entry.get(5).unwrap().parse::<f64>().unwrap(),
            carbs: entry.get(6).unwrap().parse::<f64>().unwrap(),
            protein: entry.get(7).unwrap().parse::<f64>().unwrap(),
            supplier: supplier_name,
        };
        ingredients.push(ingredient);
    }
    let pool = Pool::new("mysql://root:root@127.0.0.1:3306/krautundrueben").unwrap();
    let mut conn = pool.get_conn().unwrap();
    let mut count = 0;
    for (_, v) in suppliers.iter() {
        conn.exec_drop(r"
            INSERT INTO LIEFERANT (LIEFERANTENNR, LIEFERANTENNAME, STRASSE, HAUSNR, PLZ, ORT, TELEFON)
            VALUES (:nr, :name_, :str, :hnr, :plz, :ort, :tel)
            ", params! {
                "nr" => format!("{}", count),
                "name_" => &v.name,
                "str" => &v.street,
                "hnr" => format!("{}", v.house_number),
                "plz" => &v.zip_code,
                "ort" => &v.town,
                "tel" => &v.telephone,
            }
        ).unwrap();
        count += 1;
    }
    let mut count = 0;
    for i in ingredients {
        conn.exec_drop(r"
            INSERT INTO ZUTAT (ZUTATENNR, BEZEICHNUNG, EINHEIT, BESTAND, KALORIEN, KOHLENHYDRATE, PROTEIN, NETTOPREIS, LIEFERANT)
            VALUES (:nr, :bz, :ein, :bes, :kal, :koh, :pro, :npr, (
                SELECT LIEFERANT.LIEFERANTENNR
                FROM LIEFERANT
                WHERE LIEFERANT.LIEFERANTENNAME = :lname
            ))
            ", params! {
                "nr" => format!("{}", count),
                "bz" => &i.name,
                "ein" => &i.unit,
                "bes" => format!("{}", i.count),
                "kal" => format!("{}", i.calories),
                "koh" => format!("{}", i.carbs),
                "pro" => format!("{}", i.protein),
                "npr" => format!("{}", i.price),
                "lname" => &i.supplier,
            }
        ).unwrap();
        count += 1;
    }
}

fn parse_contact_information(input: &String) -> (String, usize, String, String, String) {
    let input_split = input.split(",").map(str::trim).map(String::from).collect::<Vec<_>>();
    let s_and_hn = input_split.get(0).unwrap().split(" ").map(String::from).collect::<Vec<_>>();
    let s = s_and_hn.get(0).unwrap().clone();
    let hn = s_and_hn.get(1).unwrap().parse::<usize>().unwrap();
    let (z, t) = if input_split.len() == 3 {
        let z_and_t = input_split.get(1).unwrap().split(" ").map(String::from).collect::<Vec<_>>();
        (z_and_t.get(0).unwrap().clone(), z_and_t.get(1).unwrap().clone())
    } else {
        (input_split.get(1).unwrap().clone(), input_split.get(2).unwrap().clone())
    };
    let mut tel = input_split.last().unwrap().clone();
    if tel.starts_with("Tel. ") {
        tel = String::from(&tel.as_str()[5..]);
    }
    if tel.starts_with("T.:") {
        tel = String::from(&tel.as_str()[3..]);
    }
    return (s, hn, z, t, tel)
}