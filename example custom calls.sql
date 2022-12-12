# Alle Rezepte inklusive ihrer Nährwerte auflisten
CALL AlleNaehrwerteAllerRezepte();

# Alle Lieferanten, die die Zutaten für ein bestimmtes Rezept liefern
CALL LieferantenAllerZutatenEinesBestimmtenRezeptes("Nudeln mit Tomatensosse");

# Alle Rezepte, ohne eine bestimmte Beschraenkung
CALL RezepteOhneBeschraenkungen("Laktose");