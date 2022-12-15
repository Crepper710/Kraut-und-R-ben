SET @kunden_id := (
    SELECT KUNDE.KUNDENNR
	 FROM KUNDE
	 WHERE KUNDE.VORNAME = "Hanna" AND KUNDE.NACHNAME = "Soerensen"
);

DELETE FROM BESTELLUNGZUTAT
WHERE BESTELLUNGZUTAT.BESTELLNR IN (
    SELECT BESTELLUNG.BESTELLNR
    FROM BESTELLUNG
    WHERE BESTELLUNG.KUNDENNR = @kunden_id
);

DELETE FROM BESTELLUNG
WHERE BESTELLUNG.KUNDENNR = @kunden_id;

DELETE FROM KUNDE
WHERE KUNDE.KUNDENNR = @kunden_id;

SET @kunden_id := NULL;