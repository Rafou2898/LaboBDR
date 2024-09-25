package ch.heig.bdr.project.models;

/**
 * Class to represent the objects in the inventory
 *
 * @author Rachel Tranchida
 * @author Rafael Dousse
 * @author Quentin Surdez
 */
public class InventorySlot {
    public int idObjet;

    public String nom;

    public String type;
    public int prix;
    public String imageObjet;
    public int nombre;
    public int idCharacter;

    public InventorySlot(int idObjet, String nom, String type, int prix, String imageObjet, int nombre, int idCharacter) {
        this.idObjet = idObjet;
        this.nom = nom;
        this.type = type;
        this.prix = prix;
        this.imageObjet = imageObjet;
        this.nombre = nombre;
        this.idCharacter = idCharacter;
    }

    public InventorySlot() {}

    public String toString() {
        return "\n" + idObjet + ", " + nom + ", " + type + ", " + prix + ", " + nombre + ", " + idCharacter;
    }
}
