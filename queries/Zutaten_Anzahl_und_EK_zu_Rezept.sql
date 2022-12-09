SELECT rezept.REZEPTNAME
FROM rezept
WHERE 5 > (
	SELECT COUNT(rezeptzutat.ZUTATENNR)
	FROM rezeptzutat
	WHERE rezeptzutat.REZEPTNR = rezept.REZEPTNR
) AND rezept.REZEPTNR IN (
	SELECT rezept.REZEPTNR
	FROM ernaehrungskategorien
	INNER JOIN ernaehrungkatrezept ON ernaehrungskategorien.Ernaehrungskategorie_id = ernaehrungkatrezept.Ernaehrungskategorie_id
	INNER JOIN rezept ON ernaehrungkatrezept.REZEPTNR = rezept.REZEPTNR
	WHERE ernaehrungskategorien.Ernaehrungskategoriename = 'Vegetarisch'
);