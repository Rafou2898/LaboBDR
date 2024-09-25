@import ch.heig.bdr.project.models.*
@import ch.heig.bdr.project.models.StatsCharacter
@import ch.heig.bdr.project.models.Market
@import ch.heig.bdr.project.models.InventorySlot
@import java.util.ArrayList


@param Market market 
@param StatsCharacter character
@param ArrayList<ObjectDetail> objects
@param ArrayList<InventorySlot> inventory


<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="theme.css">
    <title>Gestionnaire de personnage</title>
</head>
<body>
<div class="container">
    <div class="market-header">
        <img src="${market.imageMarket}" alt="Marché" class="market-image" referrerpolicy="no-referrer">

        <div class="character-display">
            <div class="character-info">

                @if(!inventory.isEmpty())

                    @for(InventorySlot item : inventory)
                        <span class="inventory-item-name">${item.nom} x${item.nombre}</span>
                    @endfor
                @else
                    <span class="inventory-item-name">Inventaire vide</span>
                @endif
            </div>
            <div class="Character-image-and-name">

                <img src="${character.imageArchetype}" alt="${character.name}" class="market-character-image"
                     referrerpolicy="no-referrer">

                <span class="character-name">${character.name}</span>

            </div>
        </div>
    </div>

    <div>
        <h1 class="market-title">Marché</h1>

    </div>


    <div class="inventory">
        @if(!objects.isEmpty())
            @for(ObjectDetail item : objects)
                <div class="inventory-item">
                    <div>
                        <img src="${item.imageObject}" alt="${item.name}" referrerpolicy="no-referrer">
                        <div class="item-details">
                            <form action="/objectMarche/" method="GET">
                                <input type="hidden" name="characterId" value="${character.id}">
                                <input type="hidden" name="objectId" value="${item.idObject}">
                                <input type="hidden" name="justeBought" value="0">
                                <button type="submit" class="object-button">${item.name}</button>
                            </form>
                            <span>(Prix:<b>${item.price}.-</b>)</span>
                        </div>
                    </div>
                </div>
            @endfor
        @else
            <p>Le marché est vide</p>
        @endif

    </div>

    <form action="/character" method="GET" >
        <input type="hidden" name="characterId" value="${character.id}">
        <button type="submit" class="retour-button">Retour</button>
    </form>
</div>
</body>
</html>
