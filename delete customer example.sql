# Kunden ID von Hanna Soerensen ermitteln
SET @kunden_id := (
    SELECT KUNDE.KUNDENNR
	 FROM KUNDE
	 WHERE KUNDE.VORNAME = "Hanna" AND KUNDE.NACHNAME = "Soerensen"
);

# Alle Verbindungen von Bestellung und Zutat löschen, die auf Hanna zurück zu führen sind
DELETE FROM BESTELLUNGZUTAT
WHERE BESTELLUNGZUTAT.BESTELLNR IN (
    SELECT BESTELLUNG.BESTELLNR
    FROM BESTELLUNG
    WHERE BESTELLUNG.KUNDENNR = @kunden_id
);

# Alle Bestellung von Hanna löschen
DELETE FROM BESTELLUNG
WHERE BESTELLUNG.KUNDENNR = @kunden_id;

# Hanna aus der Kunden Tabelle entfernen
DELETE FROM KUNDE
WHERE KUNDE.KUNDENNR = @kunden_id;

# Optional: Die kunden id auf null setzten
SET @kunden_id := NULL;