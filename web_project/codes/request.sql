SELECT * FROM character_inventory();

SELECT * FROM consommable_info();
select insert_in_inventory(fk_objets, fk_personnage);

SELECT * FROM equipement_info();
SELECT * FROM equipements;
SELECT * FROM character_slot();
SELECT * FROM objets;
SELECT * FROM objets WHERE idobjets = key_idobjets;
SELECT *  from receipe_for_resource_view(idressource);
SELECT idPersonnages, p.nom, hp, exp, argent, force, dex, intel, idArchetypes, a.nom as nomArchetype, archetype_image FROM personnages p INNER JOIN archetypes a ON p.FK_Archetypes = a.idArchetypes;
SELECT * from archetypes a inner join sorts s on a.idarchetypes = s.fk_archetypes_idarchetypes;
