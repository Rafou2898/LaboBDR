package ch.heig.bdr.project.models;

/**
 * Enum to store the different type of an object
 *
 * @author Rachel Tranchida
 * @author Rafael Dousse
 * @author Quentin Surdez
 */
public enum TypeObject {
    Ressource("Ressource"), Consommable("Consommable"), Equipement("Equipement");

    private final String type;
    TypeObject(String type) {
        this.type = type;
    }

    public String getType(){
        return type;
    }
}
