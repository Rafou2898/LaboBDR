package ch.heig.bdr.project.models;

import java.lang.reflect.Array;
import java.sql.*;
import java.util.ArrayList;

/**
 * Class to represent the equipments worn by a character
 *
 * @author Rachel Tranchida
 * @author Rafael Dousse
 * @author Quentin Surdez
 */
public class EquipmentSlot {

    static final String DB_URL = "jdbc:postgresql://localhost:5432"
            + "/project?"
            + "user=bdr&password=bdr"
            + "&currentSchema=rpg";

    public static String QUERY_ONE = "SELECT * FROM character_slot()";

    public int idSlot;

    public int idObject;

    public String typeEquipment;

    public int hp;

    public int force;

    public int dex;

    public int intel;

    public int level;

    public String imageEquipment;

    public EquipmentSlot(int idSlot, int idObject, String typeEquipment, int hp, int force, int dex, int intel,
                         int level, String imageEquipment) {
        this.idSlot = idSlot;
        this.idObject = idObject;
        this.typeEquipment = typeEquipment;
        this.hp = hp;
        this.force = force;
        this.dex = dex;
        this.intel = intel;
        this.level = level;
        this.imageEquipment = imageEquipment;
    }

    public EquipmentSlot() {};


    /**
     * Function to get all slots from one character
     * @param characterId character of interest
     * @return arraylist of equipment slots
     */
    public static ArrayList<EquipmentSlot> queryAllEquipmentSlotsFromCharacter(int characterId) {
        String queryWithId = QUERY_ONE.substring(0, QUERY_ONE.length() - 1) + characterId + QUERY_ONE.substring(QUERY_ONE.length() - 1);
        ArrayList<EquipmentSlot> equipmentsEquipped = new ArrayList<>();
        try (Connection connection = DriverManager.getConnection(DB_URL);
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(queryWithId);) {
            if (resultSet == null) {
                System.out.println("Set is null");
            }

            while (resultSet.next()) {
                EquipmentSlot es = new EquipmentSlot();
                es.idSlot = resultSet.getInt("idslots");
                es.idObject = resultSet.getInt("fk_objets");
                es.typeEquipment = resultSet.getString("type_equipement");
                es.hp = resultSet.getInt("hp");
                es.force = resultSet.getInt("force");
                es.dex = resultSet.getInt("dex");
                es.intel = resultSet.getInt("intel");
                es.level = resultSet.getInt("level");
                es.imageEquipment = resultSet.getString("objet_image");
                equipmentsEquipped.add(es);
            }
        } catch (SQLException e) {
            System.out.println("Exception: " + e);
        }
        return equipmentsEquipped;
    }


}
