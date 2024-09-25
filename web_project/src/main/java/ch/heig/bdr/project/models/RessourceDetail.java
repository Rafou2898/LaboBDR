package ch.heig.bdr.project.models;

import java.sql.*;
import java.util.ArrayList;

/**
 * Class to represent the details of a ressource
 *
 * @author Rachel Tranchida
 * @author Rafael Dousse
 * @author Quentin Surdez
 */
public class RessourceDetail {

   public ArrayList<RecetteLinkedToResource> rld = new ArrayList<>();
   int idObjet;

   public RessourceDetail() {

   }

   static final String DB_URL = "jdbc:postgresql://localhost:5432"
           + "/project?"
           + "user=bdr&password=bdr"
           + "&currentSchema=rpg";


   static String queryLinkedRecette = "SELECT *  from receipe_for_resource_view(%d)";

   /**
    * Function to get the ressource detail of one specific ressource
    * @param idObjet of the object of interest
    * @return all its informations
    */
   public static RessourceDetail getRessource(int idObjet) {
      RessourceDetail rd = new RessourceDetail();
      rd.idObjet = idObjet;
      String recetteQueryById = String.format(queryLinkedRecette, idObjet);
      try (Connection connection = DriverManager.getConnection(DB_URL);
           Statement statement = connection.createStatement();
           ResultSet resultSet = statement.executeQuery(recetteQueryById)) {
         if (resultSet == null) {
            System.out.println("Set is null");
         }

         while (resultSet.next()) {
            RecetteLinkedToResource rld = new RecetteLinkedToResource();
            rld.idRecette = resultSet.getInt("idRecette");
            rld.metier = resultSet.getString("metier");
            rld.idMetier = resultSet.getInt("idmetiers");
            rld.nomResultat = resultSet.getString("recetteResultatNom");
            rld.imageResultat = resultSet.getString("image");
            rd.rld.add(rld);
         }
      } catch (SQLException e) {
         System.out.println("Exception: " + e);
      }
      return rd;
   }


}
