
-- -----------------------------------------------------
-- Schema RPG
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS RPG;

-- -----------------------------------------------------
-- Table RPG.Inventaire
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS RPG.Inventaire (
  idInventaires SERIAL,
  tailleMax INT NOT NULL,
  PRIMARY KEY (idInventaires));



-- -----------------------------------------------------
-- Table RPG.Archetypes
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS RPG.Archetypes (
  idArchetypes SERIAL,
  nom VARCHAR(45) NULL,
  archetype_image TEXT,
  PRIMARY KEY (idArchetypes));

-- -----------------------------------------------------
-- Table RPG.Sorts
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS RPG.Sorts (
  idSorts SERIAL,
  type VARCHAR(45) NULL,
  nom VARCHAR(45) NULL,
  degat INT NULL,
  sort_image TEXT,
  FK_Archetypes_idArchetypes INT NOT NULL,
  PRIMARY KEY (idSorts),
  CONSTRAINT fk_Sorts_Archetypes1
    FOREIGN KEY (FK_Archetypes_idArchetypes)
    REFERENCES RPG.Archetypes (idArchetypes)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table RPG.Objets
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS RPG.Objets (
  idObjets INT NOT NULL,
  nom VARCHAR(45) NULL,
  type VARCHAR(45) NULL,
  prix INT NULL,
  objet_image TEXT,
  PRIMARY KEY (idObjets));


-- -----------------------------------------------------
-- Table RPG.Consommables
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS RPG.Consommables (
  FK_Objets INT NOT NULL,
  hp INT NULL,
  PRIMARY KEY (FK_Objets),
  CONSTRAINT fk_Consommables_Objets1
    FOREIGN KEY (FK_Objets)
    REFERENCES RPG.Objets (idObjets)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



-- -----------------------------------------------------
-- Table RPG.Metiers
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS RPG.Metiers (
  idMetiers SERIAL,
  nom VARCHAR(45) NULL,
  PRIMARY KEY (idMetiers));


-- -----------------------------------------------------
-- Table RPG.Recettes
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS RPG.Recettes (
  idRecettes SERIAL,
  Consommables_FK_Objets INT NOT NULL,
  Metier_FK INT NOT NULL,
  PRIMARY KEY (idRecettes),
  CONSTRAINT fk_Recettes_Consommables1
    FOREIGN KEY (Consommables_FK_Objets)
    REFERENCES RPG.Consommables (FK_Objets)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
CONSTRAINT fk_Recettes_Metier1
    FOREIGN KEY (Metier_FK)
    REFERENCES RPG.Metiers (idMetiers)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table RPG.Personnages
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS RPG.Personnages (
  idPersonnages SERIAL,
  nom VARCHAR(45) NULL,
  hp INT NULL,
  exp INT NULL,
  argent INT NULL,
  force INT NULL,
  dex INT NULL,
  intel INT NULL,
  FK_Inventaire INT NOT NULL,
  FK_Archetypes INT NOT NULL,
  FK_Metier INT NOT NULL,
  PRIMARY KEY (idPersonnages),
  CONSTRAINT fk_Personnages_Inventaires
    FOREIGN KEY (FK_Inventaire)
    REFERENCES RPG.Inventaire (idInventaires)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Personnages_Archetypes1
    FOREIGN KEY (FK_Archetypes)
    REFERENCES RPG.Archetypes (idArchetypes)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Personnages_Metiers1
    FOREIGN KEY (FK_Metier)
    REFERENCES RPG.Metiers (idMetiers)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table RPG.Equipements
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS RPG.Equipements (
  FK_Objets INT NOT NULL,
  type_equipement VARCHAR(45) NULL,
  hp INT NULL,
  force INT NULL,
  dex INT NULL,
  intel INT NULL,
  level INT NULL,
  PRIMARY KEY (FK_Objets),
  CONSTRAINT fk_Equipements_Objets1
    FOREIGN KEY (FK_Objets)
    REFERENCES RPG.Objets (idObjets)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table RPG.Slots
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS RPG.Slots (
  idSlots SERIAL,
  type_equipement VARCHAR(45) NULL,
  FK_Personnage INT NOT NULL,
  FK_Equipements INT NULL,
  PRIMARY KEY (idSlots),
  CONSTRAINT fk_Slots_Personnages1
    FOREIGN KEY (FK_Personnage)
    REFERENCES RPG.Personnages (idPersonnages)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Slots_Equipements1
    FOREIGN KEY (FK_Equipements)
    REFERENCES RPG.Equipements (FK_Objets)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table RPG.Ressources
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS RPG.Ressources (
  FK_Objets INT NOT NULL,
  PRIMARY KEY (FK_Objets),
  CONSTRAINT fk_Ressources_Objets1
    FOREIGN KEY (FK_Objets)
    REFERENCES RPG.Objets (idObjets)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table RPG.EstDansInventaire
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS RPG.EstDansInventaire (
  idEstDansInventaire SERIAL,
  Objets_idObjets INT NOT NULL,
  Inventaires_idInventaires INT NOT NULL,
  PRIMARY KEY (idEstDansInventaire),
  CONSTRAINT fk_EstDansInventaire_Objets1
    FOREIGN KEY (Objets_idObjets)
    REFERENCES RPG.Objets (idObjets)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_EstDansInventaire_Inventaires1
    FOREIGN KEY (Inventaires_idInventaires)
    REFERENCES RPG.Inventaire (idInventaires)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table RPG.Ressources_has_Recettes
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS RPG.Ressources_has_Recettes (
  Ressources_FK_Objets SERIAL,
  Recettes_idRecettes INT NOT NULL,
  PRIMARY KEY (Ressources_FK_Objets, Recettes_idRecettes),
  CONSTRAINT fk_Ressources_has_Recettes_Ressources1
    FOREIGN KEY (Ressources_FK_Objets)
    REFERENCES RPG.Ressources (FK_Objets)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Ressources_has_Recettes_Recettes1
    FOREIGN KEY (Recettes_idRecettes)
    REFERENCES RPG.Recettes (idRecettes)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

