package ch.heig.bdr.project.models;

import java.sql.*;
import java.util.ArrayList;

/**
 * Class to represent the character inventory
 *
 * @author Rachel Tranchida
 * @author Rafael Dousse
 * @author Quentin Surdez
 */
public class CharacterInventory {

    public static ArrayList<InventorySlot> inventory = new ArrayList<>();

    static final String DB_URL = "jdbc:postgresql://localhost:5432"
            + "/project?"
            + "user=bdr&password=bdr"
            + "&currentSchema=rpg";

     public static String QUERY_ONE = "SELECT * FROM character_inventory()";

    public CharacterInventory() {}

    /**
     * Query to get all the inventory of a character
     * @param characterId the id of the character
     * @return the inventory of the character
     */
    public static ArrayList<InventorySlot> queryInventoryByCharacterId(int characterId) {
        String queryWithId = QUERY_ONE.substring(0, QUERY_ONE.length() - 1) + characterId + QUERY_ONE.substring(QUERY_ONE.length() - 1);
        try (Connection connection = DriverManager.getConnection(DB_URL);
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(queryWithId);) {
            if (resultSet == null) {
                System.out.println("Set is null");
            }

            while (resultSet.next()) {

                InventorySlot is = new InventorySlot();
                is.idObjet = resultSet.getInt("idobjets");
                is.nom = resultSet.getString("nom");
                is.type = resultSet.getString("type");
                is.prix = resultSet.getInt("prix");
                is.imageObjet = resultSet.getString("objet_image");
                is.nombre = resultSet.getInt("nombre");
                is.idCharacter = resultSet.getInt("inventaire_idperso");
                inventory.add(is);
            }
        } catch (SQLException e) {
            System.out.println("Exception: " + e);
        }
        return inventory;
    }
}
