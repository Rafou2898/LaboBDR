set search_path = rpg;

-- function to see inventory of one character with all needed headers
create or replace function character_inventory(character_id INTEGER)
    RETURNS TABLE(idobjets INT, nom VARCHAR, type VARCHAR, prix INT, objet_image TEXT, nombre BIGINT, inventaire_idperso INT)
AS $$
BEGIN
    RETURN QUERY
        SELECT iv.idobjets, iv.nom, iv.type, iv.prix, iv.objet_image, iv.nombre, inventaires_idinventaires
        FROM inventory_view as iv
                 JOIN personnages p ON iv.inventaires_idinventaires = p.fk_inventaire
        WHERE p.idpersonnages = character_id;
END;

$$ language 'plpgsql';

--Function to see the slot of a character
create or replace function character_slot(character_id INTEGER)
    RETURNS TABLE(idslots INT, fk_objets INT, type_equipement VARCHAR, hp INT,
                  force INT, dex INT, intel INT, level INT, objet_image TEXT) AS
$$
BEGIN
    RETURN QUERY
        SELECT  s.idslots, e.fk_objets, e.type_equipement, e.hp, e.force, e.dex,
                e.intel, e.level, o.objet_image
        FROM slots s
                 INNER JOIN equipements e ON s.fk_equipements = e.fk_objets
                 INNER JOIN objets o ON e.fk_objets = o.idobjets
                 LEFT JOIN personnages p ON s.fk_personnage = p.idpersonnages
        WHERE p.idpersonnages = character_id;
END;
$$ language 'plpgsql';

-- Function to see info of ressource from its id
CREATE OR REPLACE FUNCTION consommable_info(consommable_id INTEGER)
    RETURNS TABLE(idConsommable INT, hp_given INT) AS

$$
BEGIN
    RETURN QUERY
        SELECT fk_objets, hp FROM consommables
        WHERE fk_objets = consommable_id;
END;
$$ language 'plpgsql';

-- Function to get all receipes from a specific resource
CREATE OR REPLACE function receipe_for_resource_view(idRessource INTEGER)
    RETURNS TABLE( image TEXT, recetteResultatNom VARCHAR(45), idmetiers INTEGER, metier VARCHAR(45), idRecette INTEGER) AS
$$
BEGIN
    RETURN QUERY
        SELECT  objets.objet_image, objets.nom, metiers.idmetiers, metiers.nom, recettes.idrecettes
        FROM ressources_has_Recettes
                 JOIN recettes on Ressources_has_Recettes.recettes_idrecettes = recettes.idrecettes
                 JOIN metiers on recettes.metier_fk = metiers.idmetiers
                 JOIN objets on objets.idobjets = recettes.consommables_fk_objets
        WHERE ressources_has_recettes.ressources_fk_objets = idRessource;

END;
$$ language 'plpgsql';

-- Function to get all equipment info from its id
create or replace function equipement_info(equipement_id integer)
    returns TABLE(idequipement integer, type character varying, hp integer, force integer, dex integer, intel integer, level integer)
as
$$
BEGIN
    RETURN QUERY
        SELECT * FROM equipements
        WHERE fk_objets = equipement_id;
END;
$$ language 'plpgsql';

-- Function to insert in an inventory knowing the object id and the character id
CREATE OR REPLACE FUNCTION insert_in_inventory(id_object INT, id_character INT)
    RETURNS VOID AS
$$
DECLARE
    id_inventaire INT;
BEGIN
    SELECT fk_inventaire INTO id_inventaire FROM personnages
    WHERE idpersonnages = id_character;

    INSERT INTO estdansinventaire (objets_idobjets, inventaires_idinventaires)
    VALUES (id_object, id_inventaire);

    RETURN;
END;
$$ language 'plpgsql';

CREATE OR REPLACE FUNCTION character_equipment_stat_sum(character_id INTEGER)
    RETURNS TABLE( e_hp BIGINT, e_force BIGINT, e_dex BIGINT, e_intel BIGINT
                 ) AS
$$
BEGIN
    RETURN QUERY
        SELECT COALESCE(SUM(e.hp), 0) as e_hp, COALESCE(SUM(e.force), 0) as e_force, COALESCE(SUM(e.dex), 0) as e_dex, COALESCE(SUM(e.intel), 0) as e_intel
        FROM slots s
                 LEFT JOIN equipements as e on s.fk_equipements = e.fk_objets
        WHERE fk_personnage = character_id;

END;
$$ LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION overall_stats_view(character_id INT)
    RETURNS TABLE(id INT, hp NUMERIC, force NUMERIC, dex NUMERIC, intel NUMERIC
                 ) AS
$$
BEGIN
    RETURN QUERY
        SELECT character_id, SUM(e_hp + p.hp), SUM(e_force + p.force), SUM(e_dex + p.dex), SUM(e_intel + p.intel)
        FROM character_equipment_stat_sum(character_id)
                 INNER JOIN personnages as p on idpersonnages = character_id;


END;
$$ language 'plpgsql';


-- Function to return the count of object in a specific inventory
CREATE OR REPLACE FUNCTION count_inventory(idInventory INTEGER)
    RETURNS INTEGER AS
$$
BEGIN
    return (SELECT count(*) from estdansinventaire
            WHERE inventaires_idinventaires = idInventory);
END;
$$ language 'plpgsql';

-- Huge trigger to equip an equipment
CREATE OR REPLACE FUNCTION trigger_insert_slots()
    RETURNS TRIGGER AS
$$
DECLARE
    level_equipment INT;
    level_character INT;
    type_slot VARCHAR(45);
    type_exists BOOLEAN;
    current_equipment_id INT;
    current_slot_id INT;
    inventory_id INT;
BEGIN
    SELECT level INTO level_equipment FROM equipements
    WHERE fk_objets = NEW.fk_equipements;

    SELECT exp INTO level_character FROM personnages
    WHERE idpersonnages = NEW.fk_personnage;

    -- For now we consider the level as being the number of exp no linear relations
    -- Perhaps we could do 0.25 * level_character ?
    level_character = 0.05 * level_character;

    RAISE INFO 'character level %', level_character;
    RAISE INFO 'equipement level %', level_equipment;

    SELECT type_equipement INTO type_slot FROM equipements
    WHERE fk_objets = new.fk_equipements;

    IF type_slot <> new.type_equipement THEN
        RAISE EXCEPTION 'You can not equip in this slot the equipment with this type: %', type_slot;
    end if;

    IF level_character < level_equipment THEN
        RAISE EXCEPTION 'You can not equip an equipment whose level is higher than your character';
    END IF;

    SELECT EXISTS (
        SELECT * FROM slots
        WHERE fk_equipements IS NOT NULL
          AND type_equipement = NEW.type_equipement
          AND fk_personnage = NEW.fk_personnage
    ) INTO type_exists;

    IF type_exists THEN

        -- Store the slot id of the previous item
        SELECT idslots INTO current_slot_id FROM slots
        WHERE fk_personnage = NEW.fk_personnage
          AND type_equipement = NEW.type_equipement;

        -- Store the equipment id of the previous item
        SELECT fk_equipements INTO current_equipment_id FROM slots
        WHERE fk_personnage = NEW.fk_personnage
          AND type_equipement = NEW.type_equipement;

        -- Insert into the inventory the previously equipped item
        SELECT fk_inventaire INTO inventory_id FROM personnages p
        WHERE p.idpersonnages = NEW.fk_personnage;

        INSERT INTO estdansinventaire (objets_idobjets, inventaires_idinventaires)
        VALUES (current_equipment_id, inventory_id);

        -- Update the equipment
        UPDATE slots
        SET fk_equipements = NEW.fk_equipements
        WHERE idslots = current_slot_id;

        RETURN NULL;
    END IF;

    SELECT EXISTS (
        SELECT * FROM slots
        WHERE fk_equipements IS NULL
          AND type_equipement = NEW.type_equipement
          AND fk_personnage = NEW.fk_personnage
    ) INTO type_exists;

    IF type_exists THEN
        UPDATE slots
        SET fk_equipements = new.fk_equipements
        WHERE type_equipement = new.type_equipement
          AND fk_personnage = new.fk_personnage;
        RETURN NULL;
    END IF;

    RETURN NEW;
END;
$$ language 'plpgsql';

-- Well the actual trigger
CREATE OR REPLACE TRIGGER trigger_before_insert_on_slots
    BEFORE INSERT ON slots
    FOR EACH ROW
EXECUTE FUNCTION trigger_insert_slots();


CREATE OR REPLACE FUNCTION trigger_insert_personnage()
    RETURNS TRIGGER AS
$$
BEGIN
    INSERT INTO slots (type_equipement, fk_personnage, fk_equipements)
    VALUES ('Bottes', new.idpersonnages, null),
           ('Cape', new.idpersonnages, null),
           ('Arme', new.idpersonnages, null),
           ('Accessoire', new.idpersonnages, null),
           ('Chapeau', new.idpersonnages, null),
           ('Bouclier', new.idpersonnages, null);
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE OR REPLACE TRIGGER trigger_after_insert_on_personnage
    AFTER INSERT ON personnages
    FOR EACH ROW
EXECUTE FUNCTION trigger_insert_personnage();

CREATE OR REPLACE FUNCTION trigger_insert_inventaire()
    RETURNS TRIGGER AS
$$
DECLARE
    inventory_id INT;
BEGIN
    INSERT INTO inventaire (taillemax) VALUES (10)
    RETURNING idinventaires INTO inventory_id;

    new.fk_inventaire = inventory_id;

    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE OR REPLACE TRIGGER trigger_before_insert_on_personnage
    BEFORE INSERT ON personnages
    FOR EACH ROW
EXECUTE FUNCTION trigger_insert_inventaire();

-- Function to check if inventory is full before the insertion
CREATE OR REPLACE FUNCTION trigger_insert_on_inventory()
    RETURNS TRIGGER AS
$$
DECLARE
    max_size_inventory INT;
BEGIN

    SELECT taillemax INTO max_size_inventory FROM inventaire i
    WHERE i.idinventaires = NEW.inventaires_idinventaires;

    RAISE INFO 'max size %', max_size_inventory;
    RAISE INFO 'current count inv %', count_inventory(new.inventaires_idinventaires);

    IF max_size_inventory <= count_inventory(new.inventaires_idinventaires) THEN
        RAISE EXCEPTION 'Insertion not allowed. Inventory is already full.';
        -- RETURN NULL;
    END IF;

    RETURN NEW;
END;
$$ language 'plpgsql';

-- Trigger to check if there is enough space in the inventory
CREATE OR REPLACE TRIGGER trigger_before_insert_on_inventory
    BEFORE INSERT ON estdansinventaire
    FOR EACH ROW
EXECUTE FUNCTION trigger_insert_on_inventory();