SELECT ZUTAT.BEZEICHNUNG
FROM ZUTAT
WHERE ZUTAT.ZUTATENNR NOT IN (
	SELECT REZEPTZUTAT.ZUTATENNR
	FROM REZEPTZUTAT
);