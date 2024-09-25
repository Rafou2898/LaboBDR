set search_path = 'rpg';

--- Archétypes
INSERT INTO archetypes(idarchetypes, nom, archetype_image) VALUES
(1, 'Iop', 'https://static.ankama.com/dofus/renderer/look/7b317c38302c323132347c313d31363736353536342c323d31363335353838332c333d31363737373138352c343d323931303036342c353d31343536313739397c3134307d/full/1/250_250-10_100.png'),
(2, 'Eniripsa', 'https://static.ankama.com/dofus/renderer/look/7b317c37312c323131367c313d31343738353333372c323d31363730373737322c333d31363730373737322c343d31313934313134342c353d31353338383737387c3131357d/full/1/250_250-10_100.png'),
(3, 'Osamodas', 'https://static.ankama.com/dofus/renderer/look/7b317c32302c323032387c313d31353937333437302c323d31363737373136362c333d343833363537332c343d323832373032372c353d31363736313930347c3133307d/full/1/250_250-10_100.png'),
(4, 'Sacrieur', 'https://static.ankama.com/dofus/renderer/look/7b317c3131312c323138307c313d31363536353130352c323d31363735333433342c333d353939323438322c343d363030333533302c353d31363736393334307c3134307d/full/1/250_250-10_100.png'),
(5, 'Féca', 'https://static.ankama.com/dofus/renderer/look/7b317c31302c323031327c313d31363736353536342c323d373039383135372c333d31353937323931322c343d353436383235342c353d373039383135377c3132357d/full/1/250_250-10_100.png'),
(6, 'Xélor', 'https://static.ankama.com/dofus/renderer/look/7b317c35312c323038347c313d373935373332302c323d31363737373136362c333d323531323939382c343d31333934353530392c353d323531323939387c3131307d/full/1/250_250-10_100.png'),
(7, 'Ecaflip', 'https://static.ankama.com/dofus/renderer/look/7b317c36302c323039327c313d31363338303633342c323d31333732363031322c333d31363733353737382c343d323738363138362c353d31363736313930347c3135307d/full/1/250_250-10_100.png'),
(8, 'Enutrof', 'https://static.ankama.com/dofus/renderer/look/7b317c33312c323035327c313d31353338343637342c323d31353938323735362c333d343430343235372c343d31363737373136342c353d31313337333838317c39357d/full/1/250_250-10_100.png'),
(9, 'Sram', 'https://static.ankama.com/dofus/renderer/look/7b317c34302c323036307c313d31353931393239342c323d333130313831342c333d333130313831342c343d333130313831342c353d383734383632387c3134307d/full/1/250_250-10_100.png'),
(10, 'Cra', 'https://static.ankama.com/dofus/renderer/look/7b317c39312c323134387c313d31363736313730332c323d31343737353331322c333d383039313930342c343d31343035333839352c353d363936333436327c3133357d/full/1/250_250-10_100.png'),
(11, 'Sadida', 'https://static.ankama.com/dofus/renderer/look/7b317c3130302c323135362c313235337c313d383533373838372c323d383136343039392c333d31343430323636392c343d31343430323636392c353d31313936303839327c3135307d/full/1/250_250-10_100.png'),
(12, 'Pandawa', 'https://static.ankama.com/dofus/renderer/look/7b317c3132312c323139367c313d31363338303633342c323d343533383932352c333d393731313838392c343d31353435373938342c353d393731313838397c3134357d/full/1/250_250-10_100.png');

--- Sorts
INSERT INTO sorts(nom, degat, type, fk_archetypes_idarchetypes, sort_image) VALUES
('Epee du Destin', 60, 'Feu', 1, 'https://static.ankama.com/dofus/www/game/spells/55/11849.png'), -- Iop
('Mot Farceur', 25, 'Intelligence', 2, 'https://static.ankama.com/dofus/www/game/spells/55/12869.png'), -- Eniripsa
('Aquaculture', 35, 'Intelligence', 3, 'https://static.ankama.com/dofus/www/game/spells/55/12785.png'), -- Osamodas
('Bouclier Sacré', 50, 'Intelligence', 4, 'https://static.ankama.com/dofus/www/game/spells/55/11939.png'), -- Sacrieur
('Tétanie', 65, 'Force', 5, 'https://static.ankama.com/dofus/www/game/spells/55/12169.png'), -- Féca
('Invocation de la Marionnette', 30, 'Intelligence', 6, 'https://static.ankama.com/dofus/www/game/spells/55/12131.png'), -- Xelor
('Roulette Chanceuse', 40, 'Force', 7, 'https://static.ankama.com/dofus/www/game/spells/55/12294.png'), -- Ecaflip
('Pelle du Trésor', 70, 'Agilite', 8, 'https://static.ankama.com/dofus/www/game/spells/55/12225.png'), -- Enutrof
('Coup de lOmbre', 55, 'Intelligence', 9, 'https://static.ankama.com/dofus/www/game/spells/55/12013.png'), --Sram
('Fleche du Precision', 45, 'Agilite', 10, 'https://static.ankama.com/dofus/www/game/spells/55/11875.png'), -- Cra
('Pouvoir Naturel', 55, 'Dexterite', 11, 'https://static.ankama.com/dofus/www/game/spells/55/12710.png'), -- Sadida
('Karcham', 60, 'Agilite', 12, 'https://static.ankama.com/dofus/www/game/spells/55/12346.png'); -- Pandawa





-- Objets
-- Equipements



-- Ajouter une nouvelle ressource en utilisant l'ID de l'objet
INSERT INTO objets(idobjets, nom, type, objet_image, prix) VALUES
(100, 'Bottes du Bouftou', 'Equipement', 'https://static.ankama.com/dofus/www/game/items/200/11003.png', 150),
(101, 'Cape du Tofu', 'Equipement', 'https://static.ankama.com/dofus/www/game/items/200/17097.png', 25),
(102, 'Coiffe du Prespic', 'Equipement', 'https://static.ankama.com/dofus/www/game/items/200/16081.png', 48),
(103, 'Anneau du Mulou', 'Equipement', 'https://static.ankama.com/dofus/www/game/items/200/9103.png', 54),
(104, 'Épée Gloursonne', 'Equipement', 'https://static.ankama.com/dofus/www/game/items/200/6111.png', 89),
(105, 'Bouclier du Bowisse', 'Equipement', 'https://static.ankama.com/dofus/www/game/items/200/82021.png', 83),
(106, 'Anneau du Sagesse', 'Equipement', 'https://static.ankama.com/dofus/www/game/items/200/9007.png', 24),
(107, 'Bâton du Tabi', 'Equipement', 'https://static.ankama.com/dofus/www/game/items/200/4006.png', 38);


INSERT INTO equipements(fk_objets, type_equipement, hp, force, dex, intel, level) VALUES
(100, 'Bottes', 0, 0, 6, 0, 1),
(101, 'Cape', 15, 0, 5, 12, 5),
(102, 'Chapeau', 10, 0, 8, 5, 5),
(103, 'Accessoire', 8, 3, 4, 10, 10),
(104, 'Arme', 0, 15, 2, 0, 4),
-- Pour le Bouclier du Bwork
(105, 'Bouclier', 15, 0, 5, 0, 4),

-- Pour l'Anneau du Scarafeuille
(106, 'Accessoire', 12, 2, 6, 8, 3),

-- Pour le Bâton du Tofu
(107, 'Arme', 10, 3, 4, 12, 20);


-- Consommables

INSERT INTO objets(idobjets, nom, type, objet_image, prix) VALUES
(200, 'Pain Prenelle', 'Consommable', 'https://static.ankama.com/dofus/www/game/items/200/33076.png', 90),
(201, 'Potion de Soin', 'Consommable', 'https://static.ankama.com/dofus/www/game/items/200/12003.png', 40),
(202, 'Potion de Mériana', 'Consommable', 'https://static.ankama.com/dofus/www/game/items/200/43041.png', 60),

(204, 'Pain de Mie', 'Consommable', 'https://static.ankama.com/dofus/www/game/items/200/33074.png', 15);

INSERT INTO consommables(fk_objets, hp) VALUES
(200, 150),
-- Pour la Potion de Vie
(201, 100),

-- Pour la Potion de Mana
(202, 0),

-- Pour l'Eau de source

(204, 15);

-- Ressources
INSERT INTO objets (idobjets, nom, type, objet_image, prix) VALUES
(300, 'Blé', 'Ressource', 'https://static.ankama.com/dofus/www/game/items/200/34009.png', 10),
(301, 'Fer', 'Ressource', 'https://static.ankama.com/dofus/www/game/items/200/39024.png', 150),
(302, 'Bois', 'Ressource', 'https://static.ankama.com/dofus/www/game/items/200/38086.png', 40),
(303, 'Cuivre', 'Ressource', 'https://static.ankama.com/dofus/www/game/items/200/39108.png', 35),
(304, 'Or', 'Ressource', 'https://static.ankama.com/dofus/www/game/items/200/39022.png', 78),
(305, 'Pierre précieuse', 'Ressource', 'https://static.ankama.com/dofus/www/game/items/200/50109.png', 62),
(306, 'Eau de source', 'Ressource', 'https://static.ankama.com/dofus/www/game/items/200/15778.png', 90),
(307, 'Ortie', 'Ressource', 'https://static.ankama.com/dofus/www/game/items/200/36642.png', 9),
(308, 'Poudre de Perlinpainpain', 'Ressource', 'https://static.ankama.com/dofus/www/game/items/200/48002.png', 2);

INSERT INTO ressources(fk_objets) VALUES
(300),
(301),
(302),
(303),
(304),
(305),
(306),
(307),
(308);

-- Métiers
INSERT INTO metiers(idmetiers, nom) VALUES
(0, 'Paysan'),
(1, 'Alchimiste');

INSERT INTO recettes(idrecettes, consommables_fk_objets, metier_fk) VALUES
(0, 204, 0), --Recette pain Incarnam -- paysan
(1, 201, 1); --Potion de vie -- alchimiste

INSERT INTO ressources_has_recettes(ressources_fk_objets, recettes_idrecettes) VALUES
-- Le pain d'Incarnam a comme ingrédient eau de source et blé
(300, 0),

(306, 0),
-- Potion de vie : poudre perlinpainpain + eau
(306, 1),
(308, 1);
-- personnages

/*INSERT INTO inventaire(idinventaires, taillemax) VALUES
(0, 50),
(1, 60),
(2, 150);*/
INSERT INTO personnages(idpersonnages, nom, hp, exp, argent, force, dex, intel, fk_inventaire, fk_archetypes, fk_metier) VALUES
(0, 'Rafou', 42, 150, 200, 5, 10, 15, null, 1, 0),
(1, 'Sinaf19', 42, 300, 100, 5, 10, 15, null, 2, 0),
(2, 'Sainane', 3, 450, 150, 5, 1, 15, null, 3, 1);

-- Equipement des personnages
/*INSERT INTO slots(type_equipement, fk_personnage, fk_equipements) VALUES
('Bottes', 2, 100),
('Cape', 2, 101),
('Chapeau', 2, 102),
('Arme', 2, null),
('Bottes', 1, null),
('Cape', 1, null),
('Chapeau', 1, null),
('Arme', 1, null),
('Bottes', 0, null),
('Cape', 0, null),
('Chapeau', 0, null),
('Arme', 0, null);*/

-- Objet dans inventaire
INSERT INTO estdansinventaire(objets_idobjets, inventaires_idinventaires) VALUES
(300, 2),
(102, 2),
(200, 2);
