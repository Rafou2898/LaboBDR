package ch.heig.bdr.project.models;

import java.sql.*;
import java.util.ArrayList;

/**
 * Class to represent the information of a consumable
 *
 * @author Rachel Tranchida
 * @author Rafael Dousse
 * @author Quentin Surdez
 */
public class ConsumableDetail {


    static final String DB_URL = "jdbc:postgresql://localhost:5432"
            + "/project?"
            + "user=bdr&password=bdr"
            + "&currentSchema=rpg";

    public static String QUERY_ONE = "SELECT * FROM consommable_info()";

    public static String QUERY_ALL = "SELECT * FROM consommable";

    public int idObject;

    public int hp_given;

    public ConsumableDetail() {}

    /**
     * Function to get the details of a specific consumable
     * @param consumableId id of the consumable of interset
     * @return consumable detail
     */
    public static ConsumableDetail queryConsumableById(int consumableId) {
        String queryWithId = QUERY_ONE.substring(0, QUERY_ONE.length() - 1) + consumableId + QUERY_ONE.substring(QUERY_ONE.length() - 1);

        ConsumableDetail cd = new ConsumableDetail();
        try (Connection connection = DriverManager.getConnection(DB_URL);
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(queryWithId)) {
            if (resultSet == null) {
                System.out.println("Set is null");
            }

            while (resultSet.next()) {
                cd.idObject = resultSet.getInt("idConsommable");
                cd.hp_given = resultSet.getInt("hp_given");
            }
        } catch (SQLException e) {
            System.out.println("Exception: " + e);
        }
        return cd;
    }

    /**
     * Function to get all consumables
     * @return Arraylist of all consumables
     */
    public static ArrayList<ConsumableDetail> queryAllConsumables() {
        ArrayList<ConsumableDetail> consumables = new ArrayList<>();
        try (Connection connection = DriverManager.getConnection(DB_URL);
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(QUERY_ALL)) {
            if (resultSet == null) {
                System.out.println("Set is null");
            }

            while (resultSet.next()) {
                ConsumableDetail cd = new ConsumableDetail();
                cd.idObject = resultSet.getInt("idConsommable");
                cd.hp_given = resultSet.getInt("hp_given");
                consumables.add(cd);
            }
        } catch (SQLException e) {
            System.out.println("Exception: " + e);
        }
        return consumables;
    }

}
