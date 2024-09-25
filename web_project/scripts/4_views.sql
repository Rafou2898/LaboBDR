set search_path = 'rpg';

-- view to see all the objects our characters have
create or replace view inventory_view
as select idobjets, nom, type, prix, objet_image, count(objets.idobjets) as nombre, estdansinventaire.inventaires_idinventaires
   from estdansinventaire
            join objets on estdansinventaire.objets_idobjets = objets.idobjets
   group by idobjets, nom, type, prix, objet_image, estdansinventaire.inventaires_idinventaires;

