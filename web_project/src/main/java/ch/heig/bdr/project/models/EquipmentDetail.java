package ch.heig.bdr.project.models;

import java.sql.*;
import java.util.ArrayList;

/**
 * Class to represent the information of an equipment
 *
 * @author Rachel Tranchida
 * @author Rafael Dousse
 * @author Quentin Surdez
 */
public class EquipmentDetail {

    static final String DB_URL = "jdbc:postgresql://localhost:5432"
            + "/project?"
            + "user=bdr&password=bdr"
            + "&currentSchema=rpg";

    public static String QUERY_ALL = "SELECT * FROM equipements";

    public static String QUERY_ONE = "SELECT * FROM equipement_info()";

    public int idObject;

    public String typeEquipment;

    public int hp;

    public int force;

    public int dex;

    public int intel;

    public int level;


    /**
     * Function to get the details of a specific equipment
     * @param equipmentId the id of the equipment of interst
     * @return equipmentDetail
     */
    public static EquipmentDetail queryEquipmentById(int equipmentId) {
        String queryWithId = QUERY_ONE.substring(0, QUERY_ONE.length() - 1) + equipmentId + QUERY_ONE.substring(QUERY_ONE.length() - 1);

        EquipmentDetail ed = new EquipmentDetail();
        try (Connection connection = DriverManager.getConnection(DB_URL);
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(queryWithId)) {
            if (resultSet == null) {
                System.out.println("Set is null");
            }

            while (resultSet.next()) {
                ed.idObject = resultSet.getInt("idequipement");
                ed.typeEquipment = resultSet.getString("type");
                ed.hp = resultSet.getInt("hp");
                ed.force = resultSet.getInt("force");
                ed.dex = resultSet.getInt("dex");
                ed.intel = resultSet.getInt("intel");
                ed.level = resultSet.getInt("level");
            }
        } catch (SQLException e) {
            System.out.println("Exception: " + e);
        }
        return ed;
    }

    /**
     * Function to get all equipments
     * @return arraylist of equipments
     */
    public static ArrayList<EquipmentDetail> queryAllEquipments() {
        ArrayList<EquipmentDetail> equipments = new ArrayList<>();
        try (Connection connection = DriverManager.getConnection(DB_URL);
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(QUERY_ALL)) {
            if (resultSet == null) {
                System.out.println("Set is null");
            }

            while (resultSet.next()) {
                EquipmentDetail ed = new EquipmentDetail();
                ed.idObject = resultSet.getInt("fk_objets");
                ed.typeEquipment = resultSet.getString("type");
                ed.hp = resultSet.getInt("hp");
                ed.force = resultSet.getInt("force");
                ed.dex = resultSet.getInt("dex");
                ed.intel = resultSet.getInt("intel");
                ed.level = resultSet.getInt("level");
                equipments.add(ed);
            }
        } catch (SQLException e) {
            System.out.println("Exception: " + e);
        }
        return equipments;
    }


}
