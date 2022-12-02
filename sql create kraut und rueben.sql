DROP DATABASE IF EXISTS krautundrueben;
CREATE DATABASE IF NOT EXISTS krautundrueben;
USE krautundrueben;


CREATE TABLE KUNDE (
    KUNDENNR        INTEGER NOT NULL,
    NACHNAME        VARCHAR(50),
    VORNAME         VARCHAR(50),
    GEBURTSDATUM	  DATE,
	 STRASSE         VARCHAR(50),
	 HAUSNR			  VARCHAR(6),			
    PLZ             VARCHAR(5),
    ORT             VARCHAR(50),
    TELEFON         VARCHAR(25),
    EMAIL           VARCHAR(50)
    );

CREATE TABLE ZUTAT(
    ZUTATENNR			INTEGER NOT NULL,
    BEZEICHNUNG      VARCHAR(50),
    EINHEIT        	VARCHAR (25),
    NETTOPREIS       DECIMAL(10,2),
    BESTAND          INTEGER,
    LIEFERANT			INTEGER,
	 KALORIEN			INTEGER,
	 KOHLENHYDRATE		DECIMAL (10,2),
	 PROTEIN				DECIMAL(10,2)
);

CREATE TABLE BESTELLUNG (
    BESTELLNR        INTEGER AUTO_INCREMENT NOT NULL,
    KUNDENNR         INTEGER,
    BESTELLDATUM     DATE,
    RECHNUNGSBETRAG  DECIMAL(10,2),
    PRIMARY KEY (BESTELLNR)
);

CREATE TABLE BESTELLUNGZUTAT (
    BESTELLNR       INTEGER NOT NULL,
    ZUTATENNR       INTEGER,
    MENGE     		  INTEGER
);

CREATE TABLE LIEFERANT (
    LIEFERANTENNR   INTEGER NOT NULL,
    LIEFERANTENNAME VARCHAR(50),
    STRASSE         VARCHAR(50),
    HAUSNR			  VARCHAR(6),
    PLZ             VARCHAR(5),
    ORT             VARCHAR(50),
    TELEFON			  VARCHAR(25),
    EMAIL           VARCHAR(50)
);

CREATE TABLE REZEPT (
	 REZEPTNR      INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,
	 REZEPTNAME    VARCHAR(50)
);

CREATE TABLE REZEPTZUTAT (
    ZUTATENNR INTEGER NOT NULL,
    REZEPTNR INTEGER NOT NULL,
    MENGE INTEGER,
    PRIMARY KEY (ZUTATENNR, REZEPTNR)
);

CREATE TABLE beschraenkungen (
    Beschraekungs_ID     INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,
	 Beschraekungsname    VARCHAR(50)
);

CREATE TABLE beschraenkungenrezept (
    Beschraekungs_ID INTEGER NOT NULL,
    REZEPTNR INTEGER NOT NULL,
    PRIMARY KEY (Beschraekungs_ID, REZEPTNR)
);

Create TABLE ernaehrungskategorien (
    Ernaehrungskategorie_id     INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Ernaehrungskategoriename    VARCHAR(50)
);

CREATE TABLE ERNAEHRUNGKATREZEPT (
    Ernaehrungskategorie_id INTEGER NOT NULL,
    REZEPTNR INTEGER NOT NULL
);

/******************************************************************************/
/***                              Primary Keys                              ***/
/******************************************************************************/


ALTER TABLE ZUTAT ADD PRIMARY KEY (ZUTATENNR);
ALTER TABLE KUNDE ADD PRIMARY KEY (KUNDENNR);
ALTER TABLE LIEFERANT ADD PRIMARY KEY (LIEFERANTENNR);
ALTER TABLE BESTELLUNGZUTAT ADD PRIMARY KEY (BESTELLNR,ZUTATENNR);
ALTER TABLE ERNAEHRUNGKATREZEPT ADD PRIMARY KEY (Ernaehrungskategorie_id, REZEPTNR);


/******************************************************************************/
/***                              Foreign Keys                              ***/
/******************************************************************************/

ALTER TABLE ZUTAT ADD FOREIGN KEY (LIEFERANT) REFERENCES LIEFERANT (LIEFERANTENNR);
ALTER TABLE BESTELLUNGZUTAT ADD FOREIGN KEY (BESTELLNR) REFERENCES BESTELLUNG (BESTELLNR);
ALTER TABLE BESTELLUNG ADD FOREIGN KEY (KUNDENNR) REFERENCES KUNDE (KUNDENNR);
ALTER TABLE BESTELLUNGZUTAT ADD FOREIGN KEY (ZUTATENNR) REFERENCES ZUTAT (ZUTATENNR);
ALTER TABLE REZEPTZUTAT ADD FOREIGN KEY (ZUTATENNR) REFERENCES ZUTAT (ZUTATENNR);
ALTER TABLE REZEPTZUTAT ADD FOREIGN KEY (REZEPTNR) REFERENCES REZEPT (REZEPTNR);
ALTER TABLE ERNAEHRUNGKATREZEPT ADD FOREIGN KEY (REZEPTNR) REFERENCES REZEPT (REZEPTNR);
ALTER TABLE ERNAEHRUNGKATREZEPT ADD FOREIGN KEY (Ernaehrungskategorie_id) REFERENCES ernaehrungskategorien (Ernaehrungskategorie_id);
ALTER TABLE beschraenkungenrezept ADD FOREIGN KEY (Beschraekungs_ID) REFERENCES beschraenkungen (Beschraekungs_ID);
ALTER TABLE beschraenkungenrezept ADD FOREIGN KEY (REZEPTNR) REFERENCES REZEPT (REZEPTNR);
