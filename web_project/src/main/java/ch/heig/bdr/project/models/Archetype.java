package ch.heig.bdr.project.models;

import java.sql.*;
import java.util.ArrayList;

/**
 * Class to represent the Archetype table with its spells
 *
 * @author Rachel Tranchida
 * @author Rafael Dousse
 * @author Quentin Surdez
 */
public class Archetype {

    static final String DB_URL = "jdbc:postgresql://localhost:5432"
            + "/project?"
            + "user=bdr&password=bdr"
            + "&currentSchema=rpg";

    static final String QUERY_ALL = "SELECT * from archetypes a inner join sorts s on a.idarchetypes = s.fk_archetypes_idarchetypes";

    public int idArchetype;

    public String nameArchetype;

    public String archetypeImage;

    public int idSort;

    public String type;

    public String nameSort;

    public String imageSort;

    public Archetype(int idArchetype, String nameArchetype, String archetypeImage, int idSort, String type, String nameSort, String imageSort) {
        this.idArchetype = idArchetype;
        this.nameArchetype = nameArchetype;
        this.archetypeImage = archetypeImage;
        this.idSort = idSort;
        this.type = type;
        this.nameSort = nameSort;
        this.imageSort = imageSort;
    }

    public Archetype() {
    }

    /**
     * Query to get an archetype by id
     * @param id the id of the archetype
     * @return the archetype
     */
    public static Archetype queryArchetypeById(int id) {
        String queryId = QUERY_ALL + " WHERE idarchetypes = " + id;
        Archetype archetype = new Archetype();
        try (Connection connection = DriverManager.getConnection(DB_URL);
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(queryId)) {
            if (resultSet == null) {
                System.out.println("Set is null");
                return null;
            }

            if (resultSet.next()) {
                System.out.println("Found element");
                Archetype a = new Archetype();
                a.idArchetype = resultSet.getInt("idarchetype");
                a.nameArchetype = resultSet.getString("a.nom");
                a.archetypeImage = resultSet.getString("archetype_image");
                a.idSort = resultSet.getInt("idsorts");
                a.type = resultSet.getString("type");
                a.nameSort = resultSet.getString("s.nom");
                a.imageSort = resultSet.getString("sort_image");
                return a;
            }
        } catch (SQLException e) {
            System.out.println("Exception: " + e);
        }
        return archetype;
    }

    /**
     * Query to get all archetypes
     * @return the list of archetypes
     */
    public static ArrayList<Archetype> queryArchetypeAll() {
        ArrayList<Archetype> archetypes = new ArrayList<>();
        try (Connection connection = DriverManager.getConnection(DB_URL);
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(QUERY_ALL);) {
            if (resultSet == null) {
                System.out.println("Set is null");
                return null;
            }

            while (resultSet.next()) {
                System.out.println("Found element");
                Archetype a = new Archetype();
                a.idArchetype = resultSet.getInt("idarchetype");
                a.nameArchetype = resultSet.getString("nom");
                a.archetypeImage = resultSet.getString("archetype_image");
                a.idSort = resultSet.getInt("idsorts");
                a.type = resultSet.getString("type");
                a.nameSort = resultSet.getString("s.nom");
                a.imageSort = resultSet.getString("sort_image");
                archetypes.add(a);
            }
        } catch (SQLException e) {
            System.out.println("Exception: " + e);
        }
        return archetypes;
    }

}