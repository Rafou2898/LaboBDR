@import ch.heig.bdr.project.models.StatsCharacter
@import java.util.ArrayList

@param StatsCharacter character
@param ArrayList<StatsCharacter> characters

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
    <h1>Gestionnaire de personnage</h1>
    <div class="question">Quel personnage souhaitez-vous utiliser?</div>
    <div class="character-select">
        <div class="character-image" id="characterImage">
            <img src="${character.imageArchetype}" alt="Image Archétype" referrerpolicy="no-referrer">
        </div>
        <div class="character-stats" id="characterStats">
            <h1>Informations de ${character.name}</h1>
            <p>Dextérité: ${character.dex}</p>
            <p>Expérience: ${character.exp}</p>
            <p>Force: ${character.force}</p>
            <p>Points de Vie (HP): ${character.hp}</p>
            <p>Intelligence: ${character.intel}</p>
            <p>Argent: ${character.argent}</p>
            <p>ID Archétype: ${character.idArchetype}</p>
            <p>Nom Archétype: ${character.nameArchetype}</p>
        </div>
    </div>
    <form action="/character" method="GET">
        <select name="characterId" onchange="this.form.submit()">
            <option value="">${character.name}</option>
            @@for(StatsCharacter sc : characters) {
            <option value="${sc.id}">${sc.name}</option>
            }@endfor
        </select>


    </form>
    <form action="/inventaire-character" method="GET">
        <input type="hidden" name="characterId" value="${character.id}">
        <button type="submit" class="enter-button">Voir l'inventaire</button>
    </form>
    <form action="/market" method="GET">
        <input type="hidden" name="characterId" value="${character.id}">
        <button type="submit" class="enter-button">Voir le marché</button>
    </form>
    <div class="retour-container">
        <a href="/" class="retour-button">Retour</a>
    </div>


</div>
</body>
</html>
