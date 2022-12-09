SELECT REZEPT.REZEPTNAME
FROM ernaehrungskategorien
INNER JOIN ERNAEHRUNGKATREZEPT ON ernaehrungskategorien.Ernaehrungskategorie_id = ERNAEHRUNGKATREZEPT.Ernaehrungskategorie_id
INNER JOIN REZEPT ON ERNAEHRUNGKATREZEPT.REZEPTNR = REZEPT.REZEPTNR
WHERE ernaehrungskategorien.Ernaehrungskategoriename = '';