package ch.heig.bdr.project;

import ch.heig.bdr.project.models.*;

import io.javalin.http.Context;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;

/**
 * Class to represent the App Controller
 *
 * @author Rachel Tranchida
 * @author Rafael Dousse
 * @author Quentin Surdez
 */
public class AppControler {

    /**
     * Make the query to display the first page
     * @param ctx The context of the request
     */
    public void getInit(Context ctx) {
        ArrayList<StatsCharacter> character = StatsCharacter.queryStatsCharacterAll();

        if (character.isEmpty()) {
            System.out.println("Character list is empty");
            return;
        }
        ctx.render("mainView.jte", Map.of("statsCharacters", character));
    }

    /**
     * Make the query to display the character of interest
     * @param ctx The context of the request
     */
    public void getCharacter(Context ctx) {
        int characterId = Integer.parseInt(ctx.queryParam("characterId"));
        StatsCharacter character = StatsCharacter.queryStatsCharacterById(characterId);

        ArrayList<StatsCharacter> characterList = StatsCharacter.queryStatsCharacterAll();

        if (characterList.isEmpty()) {
            System.out.println("Character is null");
            return;
        }

        ctx.render("character.jte", Map.of("characters", characterList, "character", character));
    }

    /**
     * Make the query to display the inventory of the character
     * @param ctx The context of the request
     */
    public void getInventaireCharacter(Context ctx) {
        int characterId = Integer.parseInt(ctx.queryParam("characterId"));
        StatsCharacter character = StatsCharacter.queryStatsCharacterById(characterId);

        ArrayList<InventorySlot> inventory = CharacterInventory.queryInventoryByCharacterId(characterId);

        ctx.render("inventaire-character.jte", Map.of("inventory", inventory, "character", character));

        //Needed because it seems that the Array doesn't get destroyed at the end of the function and every time
        //it gets called, the objects in the Array get duplicated
        inventory.clear();
    }

    /**
     * Make the query to display data an object in the inventory of a character
     * @param ctx The context of the request
     */
    public void getObject(Context ctx) throws SQLException {

        int objectId = Integer.parseInt(ctx.queryParam("objectId"));
        int characterId = Integer.parseInt(ctx.queryParam("characterId"));
        ObjectDetail object = ObjectDetail.queryObjectById(objectId);
        StatsCharacter character = StatsCharacter.queryStatsCharacterById(characterId);

        if (object.type.equals(TypeObject.Ressource.getType())) {
            RessourceDetail ressource = RessourceDetail.getRessource(objectId);
            ctx.render("object.jte", Map.of("object", object, "character", character, "ressource", ressource));

        } else if (object.type.equals(TypeObject.Consommable.getType())) {
            ConsumableDetail consommable = ConsumableDetail.queryConsumableById(objectId);
            ctx.render("object.jte", Map.of("object", object, "character", character, "consommable", consommable));
        } else if (object.type.equals(TypeObject.Equipement.getType())) {
            EquipmentDetail equipement = EquipmentDetail.queryEquipmentById(objectId);
            ctx.render("object.jte", Map.of("object", object, "character", character, "equipement", equipement));

        } else {
            System.out.println("Object type not found");
        }
    }

    /**
     * Make the query to display the market
     * @param context The context of the request
     */
    public void getMarket(Context context) {
        int idCharacter = Integer.parseInt(context.queryParam("characterId"));
        Market market = Market.queryAllObjects();
        ArrayList<ObjectDetail> objectDetails = Market.objectDetails;

        StatsCharacter character = StatsCharacter.queryStatsCharacterById(idCharacter);
        ArrayList<InventorySlot> inventory = CharacterInventory.queryInventoryByCharacterId(idCharacter);

        context.render("market.jte", Map.of("objects", objectDetails, "market", market, "character", character, "inventory", inventory));

        //Needed because it seems that the Array doesn't get destroyed at the end of the function and every time
        //it gets called, the objects in the Array get duplicated
        objectDetails.clear();
        inventory.clear();
    }

    /**
     * Make the query to display data of the object sold in the market
     * @param ctx The context of the request
     * @throws SQLException
     */
    public void getObjectMarche(Context ctx) throws SQLException {

        int objectId = Integer.parseInt(ctx.queryParam("objectId"));
        int characterId = Integer.parseInt(ctx.queryParam("characterId"));
        int bought = Integer.parseInt(ctx.queryParam("justeBought"));

        if (bought == 1) {
            ObjectDetail.buyObject(objectId, characterId);
        }

        ObjectDetail object = ObjectDetail.queryObjectById(objectId);
        StatsCharacter character = StatsCharacter.queryStatsCharacterById(characterId);
        ArrayList<InventorySlot> inventory = CharacterInventory.queryInventoryByCharacterId(characterId);

        if (object.type.equals(TypeObject.Ressource.getType())) {
            RessourceDetail ressource = RessourceDetail.getRessource(objectId);
            ctx.render("objectMarche.jte", Map.of("object", object, "character", character, "ressource", ressource, "inventory", inventory));

        } else if (object.type.equals(TypeObject.Consommable.getType())) {
            ConsumableDetail consommable = ConsumableDetail.queryConsumableById(objectId);
            ctx.render("objectMarche.jte", Map.of("object", object, "character", character, "consommable", consommable, "inventory", inventory));
        } else if (object.type.equals(TypeObject.Equipement.getType())) {
            EquipmentDetail equipement = EquipmentDetail.queryEquipmentById(objectId);
            ctx.render("objectMarche.jte", Map.of("object", object, "character", character, "equipement", equipement, "inventory", inventory));

        } else {
            System.out.println("Object type not found");
        }

        //Needed because it seems that the Array doesn't get destroyed at the end of the function and every time
        //it gets called, the objects in the Array get duplicated
        inventory.clear();
    }
}
