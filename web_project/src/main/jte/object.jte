@import ch.heig.bdr.project.models.*
@import ch.heig.bdr.project.models.StatsCharacter


@param StatsCharacter character
@param ObjectDetail object
@param RessourceDetail ressource
@param ConsumableDetail consommable
@param EquipmentDetail equipement


<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="theme.css">
    <title>RPG Labo</title>
</head>
<style>
    body {
        font-family: 'Merriweather', serif;
        background-image: url('https://img.freepik.com/free-photo/wooden-floor-background_53876-88628.jpg?w=2000&t=st=1705752316~exp=1705752916~hmac=a6661f3c292bf73b3c994c0b4d2cc9e221f5831ae8492e6d947c3efeacfa8368');
        color: #333;
        margin: 0;
        padding: 20px;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
    }
    .container {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: flex-start;
        max-width: 1200px;
        margin: auto;
        background-color: #cfaf7b;
        border-radius: 10px;
        padding: 20px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    }

    .market-header, .character-display {
        display: flex;
        justify-content: space-between;
        align-items: center;
        width: 100%;
    }

    .character-portrait {
        width: 150px;
        margin-right: 20px;
    }

    .character-info {
        display: flex;
        flex-direction: column;
        align-items: flex-start;
    }

    .market-image {
        width: 300px;
        margin-right: 20px;
    }

    .character-name {
        font-size: 1.5em;
        margin-top: 8px;
        text-align: right;
    }

    .market-title {
        font-size: 2em;
        text-align: center;
        margin: 20px 0;
    }

    .inventory-item {
        box-sizing: border-box;
        display: flex;
        flex-direction: column;
        align-items: center;
        margin-bottom: 20px;
    }

    .inventory-item img {
        max-width: 100px;
        height: auto;
    }

    .item-details {
        text-align: center;
        margin-top: 8px;
    }

    .object-button {
        background-color: #f4f1e7;
        border: 1px solid #333;
        border-radius: 5px;
        padding: 5px 10px;
        font-size: 0.8em;
        margin-top: 8px;
        text-decoration: none;
        color: #333;
    }

    .retour-button {
        background-color: #f4f1e7;
        border: 1px solid #333;
        border-radius: 5px;
        padding: 10px 20px;
        font-weight: bold;
        text-decoration: none;
        color: #333;
    }

    .retour-button:hover {
        background-color: #e2dccb;
        cursor: pointer;
    }

    form {
        display: flex;

    }




</style>

<body>
<div class="container">
    <div class="inventory-header">
        <img src="${character.imageArchetype}" alt="Personnage" class="character-portrait" referrerpolicy="no-referrer">
        <h1>Inventaire de ${character.name}</h1>
    </div>

    <div class="inventory">
        @if(ressource != null)

            @if(ressource.rld != null)
                    <img src="${object.imageObject}" alt="Objet" class="character-portrait" referrerpolicy="no-referrer">
                <p>Type de l'objet : ${object.type}</p>
                <p>Nom de l'objet: ${object.name}</p>
                <h1>Recette possible</h1>
                @for(RecetteLinkedToResource rc : ressource.rld)
                    <p> Metier : ${rc.metier}</p>
                    <p> Création possible : ${rc.nomResultat}</p>
                    <img src="${rc.imageResultat}" alt="Recette de ressource" class="character-portrait"
                         referrerpolicy="no-referrer">

                @endfor

            @endif

        @elseif (consommable != null)
            <p>Type de l'objet : ${object.type}</p>
            <p>Nom de l'objet : ${object.name}</p>
            <p> HP : ${consommable.hp_given}</p>
            <img src="${object.imageObject}" alt="Consommable" class="character-portrait" referrerpolicy="no-referrer">
        @elseif (equipement != null)
            <p>Type de l'objet : ${object.type}</p>
            <p>Nom de l'objet: ${object.name}</p>
            <p> HP : ${equipement.hp}</p>
            <p> Force : ${equipement.force}</p>
            <p> Dex : ${equipement.dex}</p>
            <p> Level : ${equipement.level}</p>
            <p> Intelligence : ${equipement.intel}</p>
            <img src="${object.imageObject}" alt="Consommable" class="character-portrait" referrerpolicy="no-referrer">

        @else

            <p>Aucune information à afficher pour une raison surprenante</p>
        @endif


    </div>

    <div class="retour-container">


        <form action="/inventaire-character" method="GET">
            <input type="hidden" name="characterId" value="${character.id}">
            <button type="submit" class="retour-button">Retour</button>
        </form>
    </div>
</div>
</body>
</html>
