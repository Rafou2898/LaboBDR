package ch.heig.bdr.project.models;

import java.sql.*;
import java.util.ArrayList;

/**
 * Class to represent the stats of a character
 *
 * @author Rachel Tranchida
 * @author Rafael Dousse
 * @author Quentin Surdez
 */
public class StatsCharacter {

    static final String DB_URL = "jdbc:postgresql://localhost:5432"
            + "/project?"
            + "user=bdr&password=bdr"
            + "&currentSchema=rpg";

    static final String QUERY_ALL = "SELECT idPersonnages, p.nom, hp, exp, argent, force, dex, intel, idArchetypes, a.nom as nomArchetype, archetype_image FROM personnages p INNER JOIN archetypes a ON p.FK_Archetypes = a.idArchetypes";

    public String name;

    public int hp;

    public int exp;

    public int argent;

    public int force;

    public int dex;

    public int intel;

    public int id;

    public int idArchetype;

    public String nameArchetype;

    public String imageArchetype;

    public static StatsCharacter s;

    public StatsCharacter() {
    }

    public StatsCharacter(String name, int hp, int exp, int argent, int force, int dex, int intel, int id, int idArchetype, String nameArchetype, String imageArchetype) {
        this.name = name;
        this.hp = hp;
        this.exp = exp;
        this.argent = argent;
        this.force = force;
        this.dex = dex;
        this.intel = intel;
        this.id = id;
        this.idArchetype = idArchetype;
        this.nameArchetype = nameArchetype;
        this.imageArchetype = imageArchetype;
    }

    /**
     * Function to get a new object StatsCharacter
     * @param id of the character we want to inspect
     * @return StatsCharacter
     */
    public static StatsCharacter queryStatsCharacterById(int id) {
        String queryId = QUERY_ALL + " WHERE idPersonnages = " + id;
        StatsCharacter statsCharacters = new StatsCharacter();
        try (Connection connection = DriverManager.getConnection(DB_URL);
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(queryId);) {
            if (resultSet == null) {
                System.out.println("Set is null");
                return null;
            }

            if (resultSet.next()) {
                s = new StatsCharacter();
                s.id = resultSet.getInt("idPersonnages");
                s.name = resultSet.getString("nom");
                s.hp = resultSet.getInt("hp");
                s.exp = resultSet.getInt("exp");
                s.argent = resultSet.getInt("argent");
                s.force = resultSet.getInt("force");
                s.dex = resultSet.getInt("dex");
                s.intel = resultSet.getInt("intel");
                s.idArchetype = resultSet.getInt("idArchetypes");
                s.nameArchetype = resultSet.getString("nomArchetype");
                s.imageArchetype = resultSet.getString("archetype_image");
                return s;
            }

        } catch (SQLException e) {
            System.out.println("Exception: " + e);
        }
        return statsCharacters;
    }

    @Override
    public String toString() {
        return String.format("Character : %s id: %d dex: %d exp: %d force: %d hp: %d intel: %d argent %d idarchetype: %d nameArchetype: %s imageArchetype: %s", s.name, s.id, s.dex, s.exp, s.force, s.hp, s.intel, s.argent, s.idArchetype, s.nameArchetype, s.imageArchetype);
    }

    /**
     * Function to return stats of all characters
     * @return Array with stats of all characters
     */
    public static ArrayList<StatsCharacter> queryStatsCharacterAll() {
        ArrayList<StatsCharacter> statsCharacters = new ArrayList<>();
        try (Connection connection = DriverManager.getConnection(DB_URL);
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(QUERY_ALL);) {
            if (resultSet == null) {
                System.out.println("Set is null");
                return null;
            }

            while (resultSet.next()) {

                StatsCharacter s = new StatsCharacter();
                s.id = resultSet.getInt("idPersonnages");
                s.name = resultSet.getString("nom");
                s.hp = resultSet.getInt("hp");
                s.exp = resultSet.getInt("exp");
                s.argent = resultSet.getInt("argent");
                s.force = resultSet.getInt("force");
                s.dex = resultSet.getInt("dex");
                s.intel = resultSet.getInt("intel");
                s.idArchetype = resultSet.getInt("idArchetypes");
                s.nameArchetype = resultSet.getString("nomArchetype");
                s.imageArchetype = resultSet.getString("archetype_image");
                statsCharacters.add(s);
            }

        } catch (SQLException e) {
            System.out.println("Exception: " + e);
        }
        return statsCharacters;
    }

}
