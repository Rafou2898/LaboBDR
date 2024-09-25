@import ch.heig.bdr.project.models.StatsCharacter
@import ch.heig.bdr.project.models.InventorySlot
@import java.util.ArrayList


@param StatsCharacter character
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
    <div class="inventory-header">
        <img src="${character.imageArchetype}" alt="Personnage" class="character-portrait" referrerpolicy="no-referrer">
        <h1>Inventaire de ${character.name}</h1>
    </div>

    <div class="inventory">
        @if(!inventory.isEmpty())


            @for(InventorySlot item : inventory)
                <div class="inventory-item">
                    <div>
                        <img src="${item.imageObjet}" alt="${item.nom}" referrerpolicy="no-referrer">
                        <div class="item-details">


                            <form action="/object/" method="GET">
                                <input type="hidden" name="characterId" value="${character.id}">
                                <input type="hidden" name="objectId" value="${item.idObjet}">
                                <button type="submit" class="retour-button">${item.nom}</button>
                            </form>

                            <span>(Quantité: ${item.nombre})</span>
                        </div>
                    </div>
                </div>
            @endfor
        @else
            <p>L'inventaire est vide</p>
        @endif

    </div>

    <form action="/character" method="GET">
        <input type="hidden" name="characterId" value="${character.id}">
        <button type="submit" class="retour-button">Retour</button>
    </form>
</div>
</body>
</html>
