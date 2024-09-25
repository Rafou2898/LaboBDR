package ch.heig.bdr.project.models;

import java.sql.*;

/**
 * Class to represent the details of an object
 *
 * @author Rachel Tranchida
 * @author Rafael Dousse
 * @author Quentin Surdez
 */
public class ObjectDetail {
    static final String DB_URL = "jdbc:postgresql://localhost:5432"
            + "/project?"
            + "user=bdr&password=bdr"
            + "&currentSchema=rpg";

    public static String QUERY = "SELECT * FROM objets WHERE idobjets = ";
    public int idObject;

    public String name;

    public String type;

    public int price;

    public String imageObject;

    public ObjectDetail() {}

    public String toString() {
        return "ObjectDetail{" +
                "idObject=" + idObject +
                ", name='" + name + '\'' +
                ", type='" + type + '\'' +
                ", price=" + price +
                ", imageObject='" + imageObject + '\'' +
                '}';
    }

    /**
     * Function to get the details of an object
     * @param objectId id of the object of interest
     * @return details of the object
     */
    public static ObjectDetail queryObjectById(int objectId) {
        String queryWithId = QUERY + objectId;

        ObjectDetail od = new ObjectDetail();
        try (Connection connection = DriverManager.getConnection(DB_URL);
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(queryWithId)) {
            if (resultSet == null) {
                System.out.println("Set is null");
            }

            while (resultSet.next()) {
                od.idObject = resultSet.getInt("idobjets");
                od.name = resultSet.getString("nom");
                od.type = resultSet.getString("type");
                od.price = resultSet.getInt("prix");
                od.imageObject = resultSet.getString("objet_image");
            }
        } catch (SQLException e) {
            System.out.println("Exception : " + e);
        }
        return od;
    }

    /**
     * Function to buy an object and insert it in the inventory of the character
     * @param idObject bought object
     * @param idCharacter character that bought the object
     */
    public static void buyObject(int idObject, int idCharacter) {
        String query = String.format("select insert_in_inventory(%d, %d);", idObject, idCharacter);

        try (Connection connection = DriverManager.getConnection(DB_URL);
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(query)) {
            if (resultSet == null) {
                System.out.println("Set is null");
            }
        } catch (SQLException e) {
            System.out.println("Exception : " + e);
        }
    }
}
