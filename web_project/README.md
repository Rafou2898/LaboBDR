# Projet BDR - Gestionnaire de personnage

Authors: Rachel Tranchida, Rafael Dousse, Quentin Surdez

# Installation

Le projet utilise Docker ainsi que Docker-compose. Il est donc nécessaire d'avoir installé sur sa machine Docker. 

Ensuite, par manque de connaissance pour inclure les fichiers `HTML` dans le `.jar`, le projet doit utiliser IntelliJ
pour pouvoir fonctionner. 

Pour lancer la base de donnée, il suffit de se rendre à la racine du projet et de lancer la commande suivante: 

```shell
docker compose up
```

Cela aura pour effet de construire la base de donnée que nous avons créé. Le port utilisé pour communiquer avec 
l'extérieur est le 5432. 

Après chargement du projet dans l'IDE, il est nécessaire de run la méthode main de la classe App. Ensuite il faut 
se connecter à l'adresse suivante: http://localhost:7272

Concernant la base de données, elle a été créée et remplie automatiquement. Il est possible de s'y connecter via 
n'importe quel logiciel de gestion de base de données en utilisant les informations suivantes: 

```
Host: localhost
Port: 5432
User: bdr
Password: bdr
Database Name: project
```

Il est possible de changer les ports de la webapp ainsi que celui de la base de donnée. Pour se faire il faut changer
le numéro de port dans la classe `App`. Le port de la base de donnée peut être changer dans le fichier `docker-compose.yaml`
sous le header ports.

Pour finir l'arrêt du container se fait via la commande suivante: 

```shell
docker-compose down
```
