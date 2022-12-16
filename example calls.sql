# Auswahl aller Zutaten eines Rezeptes nach Rezeptname
CALL ZutatenVonRezept("Nudeln mit Tomatensosse");

# Auswahl aller Rezepte einer bestimmten Ernährungskategorie
CALL RezepteMitErnaehrungskategorie("Vegetarisch");

# Auswahl aller Rezepte, die eine gewisse Zutat enthalten
CALL RezepteMitBestimmterZutat("Mozzarella");

# Berechnung der durchschnittlichen Nährwerte aller Bestellungen eines Kunden
CALL DurchschnittlicheNaehrwerteAllerBestellungEinesKunden(2002);

# Auswahl aller Zutaten, die bisher keinem Rezept zugeordnet sind
CALL ZutatenOhneRezept();

# Auswahl aller Rezepte, die eine bestimmte Kalorienmenge nicht überschreiten
CALL RezepteMitWenigerAlsEinerBestimmtenKalorienMenge(500);

# Auswahl aller Rezepte, die weniger als fünf Zutaten enthalten
CALL RezepteMitWenigerAlsFuenfZutaten();

# Auswahl aller Rezepte, die weniger als fünf Zutaten enthalten und eine bestimmte Ernährungskategorie erfüllen
CALL RezepteMitWenigerAlsFuenfZutatenUndErneahrungskategorie("Vegetarisch");