CALL DurchschnitlicheNaehrwerteAllerBestellungEinesKunden(2002);
CALL RezepteMitWenigerAlsFuenfZutaten();
CALL RezepteMitWenigerAlsFuenfZutatenUndErneahrungskategorie("Vegan");
CALL RezeptMitErnaehrungskategorie("High Protein");
CALL ZutatenOhneRezept();
CALL ZutatenVonRezept("Nudeln mit Tomatensosse");