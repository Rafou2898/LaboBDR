package ch.heig.bdr.project.models;

import java.sql.*;
import java.util.ArrayList;

/**
 * Class to represent the market
 *
 * @author Rachel Tranchida
 * @author Rafael Dousse
 * @author Quentin Surdez
 */
public class Market {

    static final String DB_URL = "jdbc:postgresql://localhost:5432"
            + "/project?"
            + "user=bdr&password=bdr"
            + "&currentSchema=rpg";

    public static String QUERY_ALL = "SELECT * FROM objets";

    public static ArrayList<ObjectDetail> objectDetails = new ArrayList<>();

    public String imageMarket = "https://static.ankama.com/upload/backoffice/direct/2019-09-16/c5a09d029b818a377e2ac2bd3c5825ac.jpg";

    public Market() {}

    /**
     * Function to add all objects to market
     * @return market
     */
    public static Market queryAllObjects() {
        Market market = new Market();
        try (Connection connection = DriverManager.getConnection(DB_URL);
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(QUERY_ALL)) {
            if (resultSet == null) {
                System.out.println("Set is null");
            }

            while (resultSet.next()) {
                ObjectDetail od = new ObjectDetail();
                od.idObject = resultSet.getInt("idobjets");
                od.name = resultSet.getString("nom");
                od.type = resultSet.getString("type");
                od.price = resultSet.getInt("prix");
                od.imageObject = resultSet.getString("objet_image");
                objectDetails.add(od);
            }
        } catch (SQLException e) {
            System.out.println("Exception: " + e);
        }
        return market;
    }

    public String toString() {
        StringBuilder sb = new StringBuilder();
        for (ObjectDetail od : objectDetails) {
            sb.append(od.toString()).append("\n");
        }
        return sb.toString();
    }
}
