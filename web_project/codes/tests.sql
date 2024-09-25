-- Fichier de test pour vérifier que tous nos triggers fonctionnent correctement

-- Test pour voir si la fonction renvoit bien les objets dans l'inventaire du perso passé en param
INSERT INTO estdansinventaire (objets_idobjets, inventaires_idinventaires) VALUES (300, 3);
INSERT INTO estdansinventaire (objets_idobjets, inventaires_idinventaires) VALUES (305, 3);
INSERT INTO estdansinventaire (objets_idobjets, inventaires_idinventaires) VALUES (101, 1);

select * from character_inventory(2);

-- Test pour voir si l'insertion d'un équipement dans un slot a le comportement attendu

-- L'équipement a un level supérieur au perso -> Exception lancée
INSERT INTO slots (type_equipement, fk_personnage, fk_equipements) VALUES ('Arme', 0, 107);

SELECT * FROM slots;

-- L'équipement a un level inférieur ou égal au perso -> met l'id équipement dans le slot correspondant
INSERT INTO slots (type_equipement, fk_personnage, fk_equipements) VALUES ('Bottes', 0, 100);

SELECT * FROM slots;

-- Le type d'équipement a déjà été inséré -> envoie celui actuel dans l'inventaire du perso
INSERT INTO slots (type_equipement, fk_personnage, fk_equipements) VALUES ('Arme', 2, 107);

SELECT * FROM slots;

INSERT INTO slots (type_equipement, fk_personnage, fk_equipements) VALUES ('Arme', 2, 104);

SELECT * FROM slots;

SELECT * FROM estdansinventaire;

-- Test pour voir si un inventaire peut avoir plus d'objets que sa limit

SELECT * from estdansinventaire ORDER BY inventaires_idinventaires ASC;

INSERT INTO estdansinventaire (objets_idobjets, inventaires_idinventaires) VALUES (305, 3);
INSERT INTO estdansinventaire (objets_idobjets, inventaires_idinventaires) VALUES (305, 3);
INSERT INTO estdansinventaire (objets_idobjets, inventaires_idinventaires) VALUES (305, 3);
INSERT INTO estdansinventaire (objets_idobjets, inventaires_idinventaires) VALUES (305, 3);
INSERT INTO estdansinventaire (objets_idobjets, inventaires_idinventaires) VALUES (305, 3);
INSERT INTO estdansinventaire (objets_idobjets, inventaires_idinventaires) VALUES (305, 3);
INSERT INTO estdansinventaire (objets_idobjets, inventaires_idinventaires) VALUES (305, 3);

SELECT * FROM character_inventory(2);

-- Exception inventaire est plein !
INSERT INTO estdansinventaire (objets_idobjets, inventaires_idinventaires) VALUES (305, 3);

-- Test pour voir si la fonction character_inventory fonctionne
SELECT * FROM character_inventory(2);

-- Test pour voir is la fonction charater_slot fonctionne
SELECT * FROM character_slot(2);

-- Test pour voir si la fonction consummable_info fonctionne
SELECT * FROM consommable_info(201);

-- Test pour voir si la fonction receipe_for_ressources_view fonctionne
SELECT * FROM receipe_for_resource_view(308);

-- Test pour voir si la fonction equipment_info fonctionne
SELECT * FROM equipement_info(107);

-- Test pour voir si la fonction insert_in_inventory fonctionne
SELECT insert_in_inventory(107, 1);

SELECT * FROM character_inventory(0);

-- Test pour les stats des objets
