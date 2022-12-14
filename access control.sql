# Admin Rolle erstellen
CREATE ROLE IF NOT EXISTS admin_;
GRANT ALL PRIVILEGES ON *.* TO admin_ WITH GRANT OPTION;

# Lagerarbeiter rolle erstellen
CREATE ROLE IF NOT EXISTS lager_arbeiter;
REVOKE ALL PRIVILEGES ON *.* FROM lager_arbeiter;
GRANT UPDATE(BESTAND), SELECT ON krautundrueben.ZUTAT TO lager_arbeiter;
GRANT SELECT ON krautundrueben.LIEFERANT TO lager_arbeiter;
GRANT SELECT ON krautundrueben.BESTELLUNGZUTAT TO lager_arbeiter;
GRANT SELECT ON krautundrueben.BESTELLUNG TO lager_arbeiter;
GRANT SELECT ON krautundrueben.KUNDE TO lager_arbeiter;

# Buchhaltungs rolle erstellen
CREATE ROLE IF NOT EXISTS buchhaltung;
REVOKE ALL PRIVILEGES ON *.* FROM buchhaltung;
GRANT INSERT, UPDATE, SELECT, DELETE ON krautundrueben.ZUTAT TO buchhaltung;
GRANT SELECT ON krautundrueben.LIEFERANT TO buchhaltung;
GRANT SELECT ON krautundrueben.BESTELLUNGZUTAT TO buchhaltung;
GRANT SELECT ON krautundrueben.BESTELLUNG TO buchhaltung;

# Kundenbetreuungs Rolle erstellen
CREATE ROLE IF NOT EXISTS kundenbetreuung;
REVOKE ALL PRIVILEGES ON *.* FROM kundenbetreuung;
GRANT UPDATE(VORNAME, NACHNAME, STRASSE, HAUSNR, PLZ, ORT, TELEFON, EMAIL), INSERT ON krautundrueben.KUNDE TO kundenbetreuung;
GRANT INSERT, UPDATE, SELECT, DELETE ON krautundrueben.BESTELLUNGZUTAT TO kundenbetreuung;
GRANT INSERT, UPDATE, SELECT, DELETE ON krautundrueben.BESTELLUNG TO kundenbetreuung;
GRANT SELECT ON krautundrueben.ZUTAT TO kundenbetreuung;
GRANT SELECT ON krautundrueben.REZEPTZUTAT TO kundenbetreuung;
GRANT SELECT ON krautundrueben.REZEPT TO kundenbetreuung;
GRANT SELECT ON krautundrueben.BESCHRAENKUNGEN TO kundenbetreuung;
GRANT SELECT ON krautundrueben.BESCHRAENKUNGENREZEPT TO kundenbetreuung;
GRANT SELECT ON krautundrueben.ERNAEHRUNGSKATEGORIEN TO kundenbetreuung;
GRANT SELECT ON krautundrueben.ERNAEHRUNGKATREZEPT TO kundenbetreuung;
GRANT EXECUTE ON PROCEDURE krautundrueben.AlleNaehrwerteAllerRezepte TO kundenbetreuung;
GRANT EXECUTE ON PROCEDURE krautundrueben.DurchschnittlicheNaehrwerteAllerBestellungEinesKunden TO kundenbetreuung;
GRANT EXECUTE ON PROCEDURE krautundrueben.RezepteMitBestimmterZutat TO kundenbetreuung;
GRANT EXECUTE ON PROCEDURE krautundrueben.RezepteMitErnaehrungskategorie TO kundenbetreuung;
GRANT EXECUTE ON PROCEDURE krautundrueben.RezepteMitWenigerAlsEinerBestimmtenKalorienMenge TO kundenbetreuung;
GRANT EXECUTE ON PROCEDURE krautundrueben.RezepteMitWenigerAlsFuenfZutaten TO kundenbetreuung;
GRANT EXECUTE ON PROCEDURE krautundrueben.RezepteMitWenigerAlsFuenfZutatenUndErneahrungskategorie TO kundenbetreuung;
GRANT EXECUTE ON PROCEDURE krautundrueben.RezepteOhneBeschraenkungen TO kundenbetreuung;
GRANT EXECUTE ON PROCEDURE krautundrueben.ZutatenOhneRezept TO kundenbetreuung;
GRANT EXECUTE ON PROCEDURE krautundrueben.ZutatenVonRezept TO kundenbetreuung;

# Lieferantenbetreuungs Rolle erstellen
CREATE ROLE IF NOT EXISTS lieferantenbetreuung;
REVOKE ALL PRIVILEGES ON *.* FROM lieferantenbetreuung;
GRANT UPDATE(LIEFERANTENNAME, STRASSE, HAUSNR, PLZ, ORT, TELEFON, EMAIL) ON krautundrueben.LIEFERANT TO lieferantenbetreuung;
GRANT INSERT ON krautundrueben.LIEFERANT TO lieferantenbetreuung;
GRANT UPDATE(LIEFERANT), SELECT(ZUTATENNR, BEZEICHNUNG) ON krautundrueben.ZUTAT TO lieferantenbetreuung;
GRANT SELECT ON krautundrueben.LIEFERANTEN_UEBERBLICK TO lieferantenbetreuung;

# Rezeptentwickler Rolle erstellen
CREATE ROLE IF NOT EXISTS rezeptentwickler;
REVOKE ALL PRIVILEGES ON *.* FROM rezeptentwickler;
GRANT INSERT, UPDATE, SELECT, INSERT ON krautundrueben.REZEPT TO rezeptentwickler;
GRANT INSERT, UPDATE, SELECT, INSERT ON krautundrueben.BESCHRAENKUNGENREZEPT TO rezeptentwickler;
GRANT INSERT, UPDATE, SELECT, INSERT ON krautundrueben.BESCHRAENKUNGEN TO rezeptentwickler;
GRANT INSERT, UPDATE, SELECT, INSERT ON krautundrueben.ERNAEHRUNGSKATEGORIEN TO rezeptentwickler;
GRANT INSERT, UPDATE, SELECT, INSERT ON krautundrueben.ERNAEHRUNGKATREZEPT TO rezeptentwickler;
GRANT INSERT, UPDATE, SELECT, INSERT ON krautundrueben.REZEPTZUTAT TO rezeptentwickler;
GRANT SELECT ON krautundrueben.ZUTAT TO rezeptentwickler;
GRANT EXECUTE ON PROCEDURE krautundrueben.AlleNaehrwerteAllerRezepte TO rezeptentwickler;
GRANT EXECUTE ON PROCEDURE krautundrueben.RezepteMitBestimmterZutat TO rezeptentwickler;
GRANT EXECUTE ON PROCEDURE krautundrueben.RezepteMitErnaehrungskategorie TO rezeptentwickler;
GRANT EXECUTE ON PROCEDURE krautundrueben.RezepteMitWenigerAlsEinerBestimmtenKalorienMenge TO rezeptentwickler;
GRANT EXECUTE ON PROCEDURE krautundrueben.RezepteMitWenigerAlsFuenfZutaten TO rezeptentwickler;
GRANT EXECUTE ON PROCEDURE krautundrueben.RezepteMitWenigerAlsFuenfZutatenUndErneahrungskategorie TO rezeptentwickler;
GRANT EXECUTE ON PROCEDURE krautundrueben.RezepteOhneBeschraenkungen TO rezeptentwickler;
GRANT EXECUTE ON PROCEDURE krautundrueben.ZutatenOhneRezept TO rezeptentwickler;
GRANT EXECUTE ON PROCEDURE krautundrueben.ZutatenVonRezept TO rezeptentwickler;


# Beispiel f??r Rollen, nach belieben einkommentieren und bearbeiten


CREATE user if NOT EXISTS thor IDENTIFIED BY "test";
GRANT lieferantenbetreuung TO thor;
SET DEFAULT ROLE lieferantenbetreuung TO thor;

/*
CREATE USER if NOT EXISTS luca IDENTIFIED BY "test";
GRANT kundenbetreuung TO luca;
SET DEFAULT ROLE kundenbetreuung TO luca;

*/