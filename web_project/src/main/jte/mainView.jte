@import ch.heig.bdr.project.models.StatsCharacter
@import java.util.ArrayList

@param ArrayList<StatsCharacter> statsCharacters

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
    <div class="question">Quel Personnage souhaitez-vous utiliser?</div>
    <div class="character-select">
        <div class="character-image" id="characterImage"></div>
        <div class="character-stats" id="characterStats">

        </div>
    </div>
    <form action="/character" method="GET">
        <select name="characterId" onchange="this.form.submit()">
            <option value="">Choisissez un personnage</option>
            @for(StatsCharacter sc : statsCharacters) {
            <option value="${sc.id}">${sc.name}</option>
            }@endfor
        </select>
    </form>
</div>

</body>
</html>
