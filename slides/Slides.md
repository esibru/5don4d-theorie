---
title       : Base de donnée 4
author      : Sébastien Drobisz
description : Supports de l'UE 5DON4D.
keywords    : NoSQL, distribué, dénormalisation
marp        : false
paginate    : true
theme       : sdr
footer      : "SDR - 5DON4D"
--- 

<!-- _class: titlepage -->

![bg left:33%](./img/5don4d-wallpaper.jpg)

<div class="title"         > 5DON4D - Théorie         </div>
<div class="subtitle"      > Base de donnée 4    </div>
<div class="author"        > SDR - Sébastien Drobisz  </div>
<div class="date"          > Bruxelles, 2025          </div>
<div class="organization"  > Haute École Bruxelles-Brabant : Département des Sciences Informatiques    </div>

---

# Objectifs pédagogiques

- Comprendre la mouvence **NoSQL**.
- Critiquer les forces et les faiblesses des différents modèles de données.
- Adapter la configuration d'un système distribué à certains scénarios
- Concevoir un système multi-modèle adapté.

---

# Organisation de l'unité

## BIM1 & BIM2

- 2h par semaine théorie
- 2h par semaine de laboratoire

--- 

L'**évaluation** repose sur 
* la réalisation d'un système **polyglotte** illustrant la gestion de données diverses dans une application moderne.
* un examen théorique.

---

# Plan du cours

* Introduction au NoSQL
* Introduction aux 4 modèles de données "typiques"
* Concepts de systèmes distribués
  * CAP - BASE
  * Réplication
  * Sharding
* Réflexion sur les agrégats
* Série chronologique DB
* NewSQL
* Recherche de données

---
<!-- _class: transition2 -->

Cours 01 : Introduction au NoSQL

---

<!-- _class: cite -->

Qu'est ce que le NoSQL ?

Est-il meilleur que le modèle relationnel ?

---

<!-- _class: transition -->

Retour sur le modèle relationnel

---

Les bases de données relationnelles, ont longtemps été le choix par défaut.

* Oracle DB
* MySQL,
* PostgreSQL,
* ...

---

# Clés du succès

* **Persistance** et **manipulation** des données
* Gestion de la **concurrence**
* **Intégration**
* **Modèle standard**
---
## Données persistantes

* Gestion de données non volatile.
* Lecture, écriture, recherche plus facile qu'un système de fichier.
  - manipulation de petits éléments d'information,
  - récupération en *lots*,
  - agréger l'information (somme, moyenne...)
  - ...

---

## Contrôle de la concurrence

* Plusieurs utilisateurs peuvent modifier le même morceau d'information en même temps.
  > Risque : *conflits*
  > Solution : *transactions* (atomicité & rollback en cas d'erreur)
---

## Intégrer (lier) des applications en utilisant une base de données partagée

<center>

![](./img/shared-db.jpg)

</center>

* Les données modifiées par une application doit être vue par les autres ;
* garantie de cohérence, une application ne doit pas être en mesure de corrompre les données d'une autre application
* ...

---

## Modèle standard

Quelques différences entre les bases de données relationnelles, mais globalement identiques.

* Compétences des développeurs réutilisées dans beaucoup de projets.
* Requêtes SQL et fonctionnement de base identique.
* organisation des données adaptées à la majorité des requêtes,
* Concept de transaction, trigger...

---

# Impedance missmatch

Coexistance de deux représentations

* le modèle relationnel ;
* les structures en mémoire :
  * listes,
  * tableaux,
  * objets imbriqués,
  * héritage,
  * ...

> Traduction nécessaire, frustration des développeurs...
---

<center>

![h:550](./img/impedance.png)

</center>

---

*1990 :* Naissance de l'orienté objet et des *bases de données orientées objet* :face_with_open_eyes_and_hand_over_mouth:.

<center>

![h:300](./img/die-trash.jpeg)

</center>

---

> ## Les **ORM** facilite, mais le développeur ne peut ignorer ce qu'il fait.
>
> - le lazy/eager loading,
> - les associations (`1..N`, `N..N`),
> - coût des jointures,
> - la gestion des index,
> - nécessité d'écrire des requêtes plus complexes,
> - ...

---

# Bdd applicative & bdd intégrative

## Base de donnée avec le rôle d'intégrer

Application implémentée par des équipes différentes sont unies par une même base de données. Le *SQL* joue un rôle la flexibilité de l'utilisation du schéma en joue un autre.

Inconvénients : 
* La structure peut devenir extrêment complexe.
* Syncronisation entre les équipes nécessaires (développement plus difficile).
* Des applications différentes ont des besoins différents. Ex. performance -> index (problème d'insertion pour une application A - pour une meilleure recherche de l'application B).

---

## Base de donnée applicative

Changement dans les années 2000, utilisation de services web.

> ## Les services web ([Wikipedia](https://fr.wikipedia.org/wiki/Service_web))
> Un service web est un protocole d'interface informatique de la famille des technologies web permettant la communication et l'échange de données entre applications et systèmes hétérogènes dans des **environnements distribués**. Il s'agit donc d'un ensemble de fonctionnalités exposées sur internet ou sur un intranet, par et pour des applications ou machines, sans intervention humaine, de manière synchrone ou asynchrone. 
>
> Le protocole de communication est défini dans le cadre de la norme SOAP dans la signature du service exposé (WSDL). Actuellement, le protocole de transport est essentiellement TCP (via HTTP)

---

> ## Base de donnée applicative
> * communication des applications via le protocol HTTP.
> * Une et une seule application accède à la base de donnée. 

Possibilité de communiquer grâce à des structures de données plus riches ; d'abord XML, ensuite JSON.

* tableaux
* données imbriquées
* listes

---

Malgré cela, pas de ruée pour stocker les données différemment. Le modèle relationnel est maîtrisé et fonctionne suffisamment bien.

---

# Utilisation de Cluster

## Web 2.0 et bulle internet des années 2000.

Activités, tracking, gestion des données des réseaux sociaux (liens...) => la quantité de données explose.

> 2 options face à cette quantité d'information
> 
> * Scalabilité verticale
> * Scalabilité horizontale

---


## Scaling vertical (scaling-up)

<div class="columns">
<div>

![](./img/scaling-up.png)
Crédits : [geeks for geeks](https://www.geeksforgeeks.org/system-design/system-design-horizontal-and-vertical-scaling/)

</div>
<div>

* Pas de changement dans le code de l'application,
* réseau plus simple,
* maintenance plus facile.

</div>
</div>


---

### Scaling horizontal (scaline-out)

<div class="columns">
<div>

![](./img/scaling-out.png)
Crédits : [geeks for geeks](https://www.geeksforgeeks.org/system-design/system-design-horizontal-and-vertical-scaling/)

</div>
<div>

* Augmente la "disponibilité",
* plus robuste,
* facilité d'augmenter la charge.

</div>
</div>


⚠️ Les bases de données relationnelles ne sont pas prévues pour ce type d'architecture !

---

Adaptation des bases de données relationnelles aux clusters

* Challenges techniques :
   * Sous système avec disque partagé.
   * Séparation par shard (géré par l'application).

* Coût des licences : 1 machine = 1 licence

=> Google et Amazon influence un changement.

---

# Cluster ([Wikipédia](https://fr.wikipedia.org/wiki/Grappe_de_serveurs))
Un cluster désigne des techniques consistant à regrouper plusieurs ordinateurs **indépendants** appelés nœuds, afin de permettre une **gestion globale** et de dépasser les limitations d'un ordinateur pour **augmenter la disponibilité**, **facliliter la montée en charge**, permettre une **répartition de la charge**, faciliter la **gestion des ressources**.

La création de petits cluster est un procédé peu coûteux, consistant à grouper plusieurs ordinateurs en **réseau**.

---


# Émergence du NoSQL

## Origine du terme

1. 1998 - Apparition du terme NoSQL ([Strozzi NoSQL](https://en.wikipedia.org/wiki/Strozzi_NoSQL))
   * Fichier "ASCII" (format *relationnel*)
   * manipulé par ~~SQL~~ des scripts *shell*.
   * aucune influence sur les BDD traitées dans ce cours.

1. 2005 - première release de BigTable (Google)
   * wide-column et clé-valeur
   * forte charge opérationnelle et capacité d'analyse.


---

3. [Papier Amazon Dynamo 2007](https://www.allthingsdistributed.com/2007/10/amazons_dynamo.html).

1. **11 juin 2009**, meetup informel à SanFrancisco organisé par Johan Oskarsson. Objetif : discuter de **base de données distribuées** & **non-relationnelles**.
   > ## Il fallait
   > * un bon hashtag,
   > * pas trop utilisé sur Google
   > * => *#NoSQL* proposé dans le chan irc #cassandra. Ne représente pas vraiment le sujet, mais est un bon hashtag 🤡) 

---

Sujets des talks : 
 * Voldemort (clé-valeur)
 * Cassandra (wide column store)
 * Dynomite (clé-valeur)
 * HBase (wide column store)
 * Hypertable (wide column store)
 * CouchDB (document)
 * MongoDB (document)

---

# ~~Définition~~ Caractéristiques du NoSQL

Il n'existe pas de définition, plutôt un ensemble de caractéristiques.
* Pas d'utilisation du SQL
* XXI siècle
* Non relationnel
* Sans schéma ⚠️
* Distribué
* Autres propriétés que les propriétés ACID.

---

Les caractéristiques ne sont pas toujours rencontrées : 

Ex : Modèle graphe sur un serveur unique.

---

<!-- _class: cite -->
Au final, il est préférable de voir le NoSQL comme une mouvence. Stocker les données en choisissant le modèle de donnée et l'architecture la plus adaptée aux besoins. Les bdd NoSQL et les BDD relationnelles sont devenues des options.

---

2 raisons d'utiliser le NoSQL : 

* besoins de performance (scalabilité)
* améliorer la productivité du développement d'une applicaation

---

# Quelques mots-clés

<div class="columns">
<div>

* modèles de données
* Impédence missmatch
* Scalabilité
* Cluster
* Sans schéma
* CAP

</div>
<div>

* Sharding
* Réplication
* Aptitude au Big Data
* Performance
* dénormalisation
* Haute disponibilité

</div>
</div>

---
<!-- _class: transition2 -->

Cours 02 : Modèles de données "agrégat"

---

Un *modèle de donnée* décrit comment intéragir avec les données.

* à ne pas confondre avec le modèle de stockage qui décrit comment la base de donnée stoque et manipule les donnée en interne.

---

Généralement, on fait le lien avec

> ## Modélisation des données (Wikipedia)
>
> Dans la conception d'un système d'information, la *modélisation des données* est l'analyse et la conception de l'information contenue dans le système afin de représenter la structure de ces informations et de structurer le stockage et les traitements informatiques.
>
> Il s'agit essentiellement d'*identifier les entités logiques* et *les dépendances logiques* entre ces entités. La modélisation des données est une représentation abstraite, dans le sens où les valeurs des données individuelles observées sont ignorées au profit de la structure, des relations, des noms et des formats des données pertinentes, même si une liste de valeurs valides est souvent enregistrée. 

Représentation qu'on peut faire à l'aide d'un diagramme ~~entité-relation~~ entité-association.

---

<!-- _class: cite -->

Dans les slides qui suivent, nous utiliserons le terme *modèle de données* pour décrire la manière dont les base de données organisent les données (métamodèle).

---
<center>

![h:500](./img/dm-client-order.png)

*Figure 1.1.* Diagramme entité-association normalisé.

</center>

---

## Le modèle de donnée relationnel

* Ensemble de table (*relation*)
* Chaque table possède des lignes ou enregistrement (*tuple*) qui représente des instances.
* Les instances sont décritent au travers de colonnes (⚠️ 1 valeur par *cellule*).
* Une colonne peut faire référence à un autre relation constituant une association entre elles-deux

---

## Modèles de données du NoSQL

> Orientées agrégats
> * Document
> * Clé-valeur
> * Famille de colonnes

> Non orientées agrégats
> * Graphe

---

# *Agrégats*

Orientation différente du relationnel :

- Modèle Relationnel : On prend l'information et on la divise en tuples (plats, non imbriqués)
- Orientation agrégat : On pense à comment manipuler les données. Souvent, on veut des **structures complexes** :
  - Listes
  - Structures imbriquées

---

> ## Définition
> 
> Terme qui vient de [Domain-Driven Design](https://fabiofumarola.github.io/nosql/readingMaterial/Evans03.pdf). Un *agrégat* est une collection d'objets liés que l'on souhaite traité comme *unité d'information*. En particulier, cela forme une unité pour 
> * *la manipulation de donnée* et 
> * *la gestion de la cohérence*.

## Avantages

* Un agrégat forme une unité naturelle pour la réplication et le sharding (dans un cluster).
* Le développeur a l'habitude de manipuler des données imbriquées, des listes, tableaux...

---

<center>
Diagramme entité-association normalisé.

![h:500](./img/dm-client-order.png)


</center>

---

<center>

Échantillon de données

![h:500](./img/data-sample-client-order.png)

</center>

---

<center>

Diagramme pensé en terme d'agrégat (solution 1)

![h:500](./img/dm-agg1-client-order.png)

</center>

---

```json 

{ // in customers
  "id": 1,
  "name": "Martin",
  "billingAddress": [{"city": "Chicago"}] ⚠️ Dénormalisation
}

{ // in orders
  "id": 99,
  "customerId": 1,
  "orderItems": [{
      "productId": 27,
      "price": 32.45,
      "productName": "NoSQL Distilled"
    }
  ],
  "shippingAddress": [{"city":"Chicago"}], ⚠️
  "orderPayment": [{
      "ccinfo":"1000-1000-1000-1000",
      "txnId":"abelif879rft",
      "billingAddress":{"city":"Chicago"} ⚠️
    }
  ]
}
```

---

* Apparition de 3 copies d'une même adresse (*dénormalisation*). 
   * 🗒️ En relationnel, il est nécessaire de prévenir la modification d'une ligne d'adresse.
* Le lien entre un client et une commande ne fait partie d'aucun agrégat. → Il s'agit d'une association.

* > Dénormalisation du nom du produit. Pourquoi est-ce acceptable/souhaitable en NoSQl ?
  > * On souhaite minimiser le nombre accès aux agrégats.

* ⚠️ Ce qui compte, ce n'est pas vraiment la façon exacte dont on dessine la frontière d'un agrégat, mais plutôt de réfléchir à la manière dont on va accéder aux données.

---

<center>

Diagramme pensé en terme d'agrégats (solution 2)
![h:500](./img/dm-agg2-client-order.png)
</center>

---

```json
{
  "customer": {
    "id": 1,
    "name": "Martin",
    "billingAddress": [
      { "city": "Chicago" }
    ],

    "orders": [ {
        "id": 99,
        "customerId": 1,
        "orderItems": [ {
            "productId": 27,
            "price": 32.45,
            "productName": "NoSQL Distilled"
          }
        ],
        "shippingAddress": [
          { "city": "Chicago" }
        ],
        "orderPayment": [ {
            "ccinfo": "1000-1000-1000-1000",
            "txnId": "abelif879rft",
            "billingAddress": { "city": "Chicago" }
          }
        ]
      }
    ]
  }
}
```
---

<!-- _class: cite -->

Quelle agrégation est meilleure ?

---

Cela dépend de comment on souhaite manipuler les données
* Accès client ↛  accès aux commandes ⇒ modèle 1
   > Permet d'accéder individuellement aux commandes
* Accès client → accès aux commandes ⇒ modèle 2

Dépend de l'application, ce qui en fait un désavantage par rapport aux systèmes ignorant les agrégats.

---

## Non conscient des agrégats vs orienté agrégat

- **Relational & Graph DBs** : Non conscient des agrégats
  → pas de notion d'agrégat, juste des relations sans sémantique entre les données.
- **NoSQL (Key-Value, Document, Column-Family)** : aggregate-oriented
  → l'agrégat indique l'unité de stockage et d'accès



---

## Pourquoi l'orientation agrégat ?

- Facilite le **stockage distribué en cluster**
- L'agrégat indique quelles données doivent vivre ensemble sur le même nœud 
- Simplifie la gestion de la cohérence locale

⇒ Une bdd relationnelle ne peut pas utiliser des données d'agrégat pour optimiser le stockage et la distribution de données.

---

Ne pas connaître les agrégats est-il un handicap ?

* Parmi les deux modèles d'agrégat précédement proposés.Comment réaliser un historique de la vente des produits ?

---

## Conséquence sur les transactions

- **SGBDR** : transactions ACID multi-tables (sans limite)
- **NoSQL agrégat-orienté** : atomicité **au niveau d'un seul agrégat**
  → si plusieurs agrégats : gestion à la charge de l'application
- **Graph & relationnel** : ACID complet possible

> ## Transation ACID (Atomique, cohérent, isolé, durable)
> 
> Permet 
> * de mettre à jour plusieurs table en une opération. 
> * l'opération est réussie ou non-appliquée
> * les opérations concurrente sont isolées et ne peuvent pas voir des mises à jours partielles.

---

<!-- _class: transition -->
Modèles Clé-valeur & Document

---

## Base de données Clé-valeur

- Données = { **clé** → **agrégat opaque** }
- Avantages :
  - Flexibilité totale sur le contenu
  - Performance simple (lookup par clé)
- Limite : pas de requêtes internes, pas de sous-récupération

---

## Base de données Document

- Données = { **clé** → **document structuré** }
- Avantages :
  - Requêtes par *"clé"* internes
  - Récupération partielle possible
  - Index sur le contenu
- Limite : moins libre que clé-valeur

---

## Clé-valeur vs Document

- **Key-Value** : lookup uniquement par clé
- **Document** : requêtes riches sur la structure
- La frontière est floue (Redis, Riak, etc.)

---

<!-- _class: transition -->
Famille de colonne

---

## Origine : Google Bigtable

- Modèle repris par **HBase** et **Cassandra**
- Stockage en **colonnes groupées (famille de colonnes)**
- Différent des colonnes « relationnelles » classiques

---

## Structure

- Map à **deux niveaux :**
  - **Row** (identifiant → agrégat)
  - **Columns** regroupées en **familles**
- Accès possible : tout le row ou colonnes spécifiques

---

<center>

![h:500](./img/column-familly.png)

</center>

---

<!-- _class: transition -->
Comparaison des 3 modèles

---

## Comparaison des 3 modèles

- **Key-Value** : agrégat opaque, lookup par clé uniquement
- **Document** : agrégat transparent, requêtes internes possibles
- **Column-Family** : agrégat en 2 niveaux (row + familles de colonnes)

---

## Points communs

- Agrégat = unité d'accès et de mise à jour
- Optimisé pour le **cluster**
- Donne un compromis entre **structure** et **flexibilité**

---

<!-- _class: transition2 -->

Cours 03 : Plus de détail sur les modèles de données

---

<!-- _class: transition -->

Associations

---

# Rapel 
2 cas :

1. Accès client → accès aux commandes
1. Accès individuels aux commandes

---

Récupération des détails du client dans le cas n°2 :

1. on récupère l'enregistrement lié à la commande,
2. on lit l'ID du client,
3. on récupère l'agrégat du client.

> ⚠️ Attention, la base de donnée n'aura pas connaissance de ce lien.
>    * Conséquences ?
>
> Certaines bdd mettent en place des méchanismes pour optimiser : index (MongoDB), metadonnée (Riak).
---

### Modèlisation alternative (Client intégré à l'ordre)

``` json
{
  "_id": 456,
  "customer": { "id": 123, "name": "Alice", "email": "alice@example.com" },
  "total": 25.0
  ...
}
```

---

| Modèle                  | La base "connait" la relation ? | Requêtes croisées possibles ? | Risque d'incohérence |
|--------------------------|----------------------------------|--------------------------------|-----------------------|
| **SQL**                 | ✅ Oui (clé étrangère)           | ✅ Jointures puissantes         | Faible (contrainte FK et ACID) |
| **Clé-valeur pur**      | ❌ Non (juste ID stocké)        | ❌ Non                          | Moyen (c'est à l'app de gérer) |
| **Document (cas n°1 - par référence)** | ⚠️ Un peu (via index)          | ✅ Oui (via index)              | Moyen (pas de FK stricte) |
| **Document (embedding)** | ❌ Non (pas de lien)            | ❌ Non  (mais pas besoin)    | Élevé (duplication) |
| **Clé-valeur avec liens (Riak)** | ✅ Oui (via metadata)        | ⚠️ Limité (suivi de lien interne au sgbd)        | Moyen (pas de validation à l'écriture)|

---

<!-- _class: transition -->

Et avec le modèle graphe ?

---

<center>

![h:550](./img/graph-structure-example.png)
</center>

---

> ## Graphe de connaissance ([wikipedia](https://en.wikipedia.org/wiki/Knowledge_graph))
> In knowledge representation and reasoning, a *knowledge graph* is a knowledge base that uses a graph-structured data model or topology to represent and operate on data. Knowledge graphs are often used to store interlinked descriptions of entities – objects, events, situations or abstract concepts – while also encoding the free-form semantics or relationships underlying these entities.

> ## Traduction & simplification
> Un graphe de connaissances est une base de données qui utilise un graphe (sommets et arêtes) pour représenter l'information.
Il permet de stocker des descriptions reliées entre elles concernant des entités (par exemple : objets, personnes, événements, situations ou idées abstraites) et de représenter aussi les relations qui existent entre ces entités.

---

<!-- _class: cite -->

Trouver les livres de la catégorie bases de données écrits par un auteur apprécié par un ami.

---

| Modèle                  | La base "connait" la relation ? | Requêtes croisées possibles ? | Risque d'incohérence |
|--------------------------|----------------------------------|--------------------------------|-----------------------|
| **Graphe (Neo4j)** | ✅ Oui (objet de 1ère classe)        | ✅✅ Oui        | Faible ([first-class citizen](https://neo4j.com/news/5-factors-driving-graph-database-explosion/))|

---

# Dans un modèle relationnel

On peut parcourir les clés étrangères à l'aide des jointures, mais c'est vite couteux, difficile à écrire, lire...

## Exemple :
``` sql
SELECT DISTINCT vArrivee.nom, vArrivee.pays
FROM ville vDepart
JOIN troncon t1 ON vDepart.idville = t1.villeDepart
JOIN troncon t2 ON t1.villeArrivee = t2.villeDepart
JOIN troncon t3 ON t2.villeArrivee = t3.villeDepart
JOIN ville vArrivee ON t3.villeArrivee = vArrivee.idville
WHERE vDepart.nom = 'Bruxelles';
```

---

Dans une base de données graphe, la plupart des requêtes servent surtout à explorer les relations entre les données.

1. Point de départ : recherche par un attribut indexé
1. suivi des arêtes

---

# Modèle graphe vs modèles agrégats
* Nature différente des agrégats (voir opposé)
* Sur un serveur unique (~~distribué dans un cluster~~)
* ACID complet
* Liens avec les autres sgbd NoSQL : 
  * Augmentation d'intérêt conjointement
  * rejet du modèle relationnel.

---

<!-- _class: transition -->

Sans schéma

---

<!-- _class: cite -->
Les bases de données NoSQL sont « sans schéma ».

---

## Modèle relationnelle : Une camisole

* Avant de stocker des données : définir un **schéma**
  * Tables
  * Colonnes (sémantique & type)
  * contraintes
  * ...
* Impossible de stocker sans schéma préalable

--- 
## NoSQL : un stockage plus flexible

- Pas de schéma imposé
- Chaque type de NoSQL permet d'ajouter librement :
  - **Clé-valeur** : n'importe quelle donnée associée à une clé
  - **Document** : structure libre dans chaque document
  - **Famille de colonne** : données dans les colonnes au choix
  - **Graphe** : nouvelles arêtes et propriétés ajoutées librement 

---

## Avantages du *sans schéma*

* Plus grande liberté et flexibilité,
* Pas besoin de tout prévoir à l'avance,
* Adaptation facile au projet en cours,
* Suppression de données non utilisées (sans effets de bord),
* Ajout de données sans faire des "trous".

---

## Limites du *Schemaless*

- Programmes supposent une **structure implicite** / **schéma à la lecture** :
  - Ex. champ `billingAddress` ≠ `addressForBilling` (valeur ≠ "Bob")
  - Les types doivent être cohérents (ex. `5` ≠ `"five"`)
- Le schéma est **dans le code applicatif** :
  - Rend la compréhension des données plus difficile (doc)
  - La BD ne peut pas optimiser ni valider

---

## Pourquoi garder un schéma ?

* Schéma fixe pour :
  * Cohérence
  * Optimisation
  * Validation
* La **rejet du schéma** par NoSQL est une rupture importante

---

> ## *Schéma implicite*
> Ensemble de supposition - à propos de la structure de donnée - faites dans l'application qui manipule les données.

---

## Problèmes pratiques au schéma implicite

* Pour comprendre les données il peut être nécessaire de plonger de le code
   > ⚠️ Attention, aussi valide dans le modèle relationnelle (column1, column2...).
* risques ☢️ : incohérences, incompatibilités
* Approches possibles :
  * Centraliser l'accès aux données : via une seule appli + API (service web)
  * Délimiter clairement les zones accessibles par chaque appli 🤮.

---

## Schémas relationnels : plus flexibles qu'on ne pense

* SQL permet de modifier un schéma à tout moment
* Des colonnes peuvent être ajoutées à la volée
* On peut stocker différentes valeurs dans une même colonne (devrions nous le faire ?) → privilégier une bdd sans schéma.

---

## En résumé

- Le *« sans schéma »*
  * pour 👍 : Flexibilité, adaptation rapide, gestion des données variées
  * contre 👎 difficultés d'optimisation et de validation
* > ## En réalité
  > * **le schéma n'a pas disparu**, bdd ↦ app
  > * La flexibilité s'arrête à l'horizon des agrégats.

---

<!-- _class: transition -->

Vues et Vues matérialisées

---

## Limite des modèles orientés agrégats

* Pratique pour accéder à une commande complète
* moins pour des questions globales (ex. vente total de la semaine des produit)
* Nécessite souvent de lire **tous les ordres** → coûteux
* Les index aident, mais on va contre la structure.
  * à la base on veut des agrégats autonomes

---

> ## *Vue classique*
> 
> - Définie par une **requête SQL**
> - Ne stocke pas les résultats
> - À chaque accès : la requête est **recalculée**

---

> ## [Vues matérialisées](https://www.postgresql.org/docs/current/rules-materializedviews.html)
> * Vue dont le *resultat est persisté* sous format "relation"
>   ``` sql
>   CREATE MATERIALIZED VIEW mymatview AS SELECT * FROM mytab;
>   ```
> * ≠ tables : pas de modification directe
> * *requête persisté*
>   * ⟳ mise à jour
>     ``` sql
>     REFRESH MATERIALIZED VIEW mymatview;
>     ```

---

| Caractéristique | Vue classique | Vue matérialisée |
|-----------------|---------------|------------------|
| **Stockage** | Non | Oui |
| **Fraîcheur des données** | Toujours à jour | Peut être périmée |
| **Performance lecture** | Plus lente | Très rapide |
| **Mémoire utilisée** | Faible | Plus élevée |
| **Cas d'usage** | Données fraîches | Requêtes lourdes et répétées + léger retard toléré |

---

## NoSQL et vues

- Vue classique existante (potentiellement très coûteuses)
- **vues matérialisées** (usage plus fréquent)
  - fait des algorithmes type **Map-Reduce**
  - Très central dans les bases orientées agrégats 
     → requête hors agrégat fréquentes. 

Ex: 📖 [Solution MongoDB](https://www.mongodb.com/docs/manual/core/materialized-views/)

---

## Stratégies de mise à jour

* **Eager** (immédiat)
  * Mise à jour en même temps que les données de base
  * Fraîcheur maximale
  * Coût élevé en écriture

* **Batch** (périodique)
  * Recalcul régulier
  * Moins coûteux
  * Données périmée (compréhension du métier : *ex.* produit vendu / semaine)

---

## Implémentations possibles hors base de données

* Construire la vue en dehors de la BD et la réinjecter
* Laisser la base calculer et maintenir la vue selon une configruation (trigger)
* Usage d'**incremental map-reduce** (mise à jour incrémentale)

---

## Dénormalisation interne

- Exemple : document *commande* contenant un résumé (*résumé de commande*)
   - Évite de parcourir tout l'objet pour une requête simple
- Dans les bases **column-family** : vues matérialisées gérées dans d'autres familles de colonnes
- Mise à jour possible dans la **même transaction atomique**

---

## En résumé

- Les **agrégats** facilitent certains accès, mais compliquent les requêtes globales
- Les **vues matérialisées** apportent une solution :
  - Rapidité en lecture
  - Flexibilité d'accès
  - Mais nécessitent une gestion des mises à jour (eager ou batch)

---

<!-- _class: transition -->
Modélisation pour les accès données

---

## Réflexion

* Comment modéliser la bd commandes/client.
  * pour pouvoir faire des requêtes individuelles sur les commandes.
  * pouvoir récupérer efficacement les commandes réalisées par un client.

* Dans le cas développé, comment peut-on optimiser la requête : quelles commandes contiennent un produit donné.

-> la manière de créer les agrégats dépend des lectures que nous souhaitons faire.

---

<!-- _class: transition -->

 III - Distribution des données

---

<!-- _class: transition2 -->

1 - Introduction

---

<center>

![h:500](./img/distribution-road.png)

</center>

---

<!-- _class: transition3 -->

Départ : Aucune distribution

---

> « Plus simple, la première des options de distribution est celle que nous recommandons le plus souvent : **aucune distribution**. »

- La base de données tourne sur **une seule machine**
  → gère **toutes les lectures et écritures**
- Cette approche **évite toute complexité** :
  - plus simple à administrer
  - plus facile à raisonner pour les développeurs
- Si possible : **préférer toujours un modèle mono-serveur**.

---

# Quand le mono-serveur reste pertinent

Même si de nombreuses bases NoSQL sont conçues pour les **clusters** :

- Le **modèle de données** du NoSQL peut mieux convenir à l’application,
  **même sur un seul serveur**.
- Exemple :
  - **Bases de données graphe** → fonctionnement optimal sur un seul nœud
  - **Document stores** ou **key-value stores** → efficaces pour des agrégats simples

> ⚠️ Si l’on peut éviter la distribution, **on choisira toujours une approche mono-serveur**.

---

<!-- _class: transition3 -->

On the road

---

<!-- _class: cite -->

Que se passe-t-il lorsque **plusieurs machines** participent au stockage et à la récupération des données ?

---

# Pourquoi distribuer les données ?

*  **Scalabilité**
  Répartir la charge (lecture, écriture, volume) sur plusieurs machines.

* **Tolérance aux pannes / Haute disponibilité**
  Le système continue de fonctionner même si une machine (ou un datacenter) tombe en panne.

* **Latence**
  Servir les utilisateurs depuis des serveurs **géographiquement proches** pour réduire les délais réseau.

---

<!-- _class: cite -->

Quelle est la différence entre un nœud, un cluster et un datacenter ?

---

# Cas Cassandra

<center>

![h:400](./img/arch_cassandra.png)
</center>

[Cluster, Datacenters, Racks and Nodes in Cassandra (Baeldung)](https://www.baeldung.com/cassandra-cluster-datacenters-racks-nodes)

---


# Monter en charge : vertical vs horizontal

##  Scalabilité verticale (scale up)
- Acheter une **machine plus puissante** : plus de CPU, RAM, disques.
- Simple à mettre en place, mais :
  - coût croît **plus vite que linéairement**
  - bottlenecks (réseau...) 
  - limites physiques (ex: nonuniform memory access) et géographiques

## Scalabilité horizontale (scale out)
- Ajouter **plusieurs machines** (nœuds) travaillant de manière distribuée.
- Nécessite des mécanismes de coordination, mais plus flexible et résilient.
---

# Architectures possibles

---

### 1️⃣ Mémoire partagée (shared-memory)
> Une seule machine avec de multiples processeurs et mémoire commune (OS unique).
✅ Simple
❌ Coût élevé, tolérance de panne limitée.

### 2️⃣ Disque partagé (shared-disk)
> Plusieurs machines partagent les mêmes disques via un réseau rapide.
✅ Utilisé en entrepôts de données.
❌ Problèmes de **verrouillage** et de **concurrence**.

### 3️⃣ Sans partage (shared-nothing)
> Chaque nœud a ses **propres CPU, RAM, disque**.
✅ Très populaire, peu coûteux, extensible
❌ Complexité accrue pour les développeurs.

---

# Entrepôt de données (data warehouse)

> [Wikipedia](https://fr.wikipedia.org/wiki/Entrep%C3%B4t_de_donn%C3%A9es)
> Un *entrepôt de données (data warehouse)* est une **base de données** regroupant une partie ou l'**ensemble des données fonctionnelles d'une entreprise**. Il entre dans le cadre de l'**informatique décisionnelle** ; son but est de fournir un ensemble de données servant de **référence unique**, utilisée pour la **prise de décisions** dans l'entreprise par le biais de **statistiques et de rapports** réalisés via des outils de reporting. 
>
> D'un point de vue technique, il sert surtout à 'délester' les bases de données opérationnelles des requêtes pouvant nuire à leurs performances.

---

<div class="columns">
<div>

![h:400](./img/data_warehouse_overview.JPG)
[Wikipedia](https://fr.wikipedia.org/wiki/Entrep%C3%B4t_de_donn%C3%A9es#/media/Fichier:Data_warehouse_overview.JPG)

</div>
<div>

> [Wikipedia](https://fr.wikipedia.org/wiki/Entrep%C3%B4t_de_donn%C3%A9es)
> - extraction des données de production, transformations éventuelles et chargement de l'entrepôt (c'est l'ETL ou Extract, Transform and Load ou encore datapumping).
> - on peut voir l'entrepôt de données comme une **architecture décisionnelle** capable à la fois de gérer l'**hétérogénéité** et le **changement** et dont l'enjeu est de **transformer** les données en **informations directement exploitables** par les utilisateurs du métier concerné. 
</div>
</div>

---

# Modèle "Shared-nothing" ou horizontal scaling ou scaling out

## Avantages
- Pas besoin de matériel spécialisé
- Possibilité de répartir les données **dans plusieurs régions**
- Réduction de la latence et meilleure résilience
- Accessible même aux **petites entreprises** via le cloud

## Mais attention
> Plus de puissance ⟹ aussi plus de complexité à gérer (cohérence, pannes, synchronisation…)

---

# Réplication et Partitionnement

## Réplication

> Copier les **mêmes données** sur plusieurs nœuds (potentiellement dans différents lieux).
>   * Assure la **redondance** et la **résilience** (des nœuds peuvent être indisponibles).
>   * Peut aider à améliorer les performances.

## Partitionnement (sharding)
> Découper une grosse base de donnée en sous-ensembles (appelés *partition* ou *shard*) ; répartis sur plusieurs nœuds.

---

## Réplication 🤝 partitionnement
> Les deux techniques sont souvent **combinées** ↦ compromis difficile pour réaliser, configurer, utiliser un système distribué.

<center>

![h:400](./img/sharding-replication.png)

</center>

---

# Théorème CAP

<div class="columns">
<div>

<center>

![h:400](./img/CAP_Theorem_Euler_Diagram.png)

</center>

</div>
<div>

- Cohérence
- disponibilité
- tolérance aux partition
* *choisissez-en deux !*

</div>
</div>

---

> [Wikipedia](https://en.wikipedia.org/wiki/CAP_theorem)
> * **Disponibilité** - Chaque requête reçue par un nœud non défaillant du système doit aboutir à une réponse. (définition formulée dans le théorème CAP, par Gilbert et Lynch.)
>   |Théorème CAP||architecture logicielle|
>   |---|---|---|
>   |Disponibilité (pas de délais)|≠|haute disponibilité ou faible latence|
> * **Cohérence (~~consistance~~)** - Chaque lecture reçoit la donnée la plus récente écrite, ou une erreur.
>   |Théorème CAP||Transaction ACID|
>   |---|---|---|
>   |Cohérence de réplication ou linéarisable|≠|Cohérence logique|
> * **Tolérance aux partitions** - Le système continue de fonctionner même si un nombre arbitraire de messages est perdu (ou retardé) par le réseau entre les nœuds.

---

<center>

![h:450](./img/cap-Julia_Evans.png)

</center>

> <span class="ref">📖 [CAP - Julia Evans]https://jvns.ca/blog/2016/11/19/a-critique-of-the-cap-theorem/</span>
> <Span class="ref">📖 [Martin Kleppmann - A Critique of the CAP Theorem](https://arxiv.org/abs/1509.05393)</span>

---

<!-- _class: transition2 -->

2 - Réplication

---

<!-- _class: cite -->

La réplication consiste à conserver une copie des mêmes données sur plusieurs machines connectées entre elles via un réseau.

---

# Objectifs

* Garder les données proche géographiquement (↘ latence).
* Permettre au système de continuer à fonctionner même si certains de ses nœuds tombent en panne. (↗ la disponibilité).
* Augmenter horizontallement (scale-out) le nombre de machines qui répondent aux requêtes de lectures (↗ capacité traitement). 

---

# Approches

> **Note**
> - Le jeu de donnée peut tenir sur un seul nœud (pas de partition).
> - l'enjeu réside dans le changement (pas de changement -> on copie et c'est fini).
* 3 approches : 
   * Réplication à *leader unique*
   * Réplication à *multi-leader*
   * Réplication *sans leader (P2P)*

---

# Compromis à considérer

La réplication d’une base de données soulève de nombreux **choix techniques** :

- **Réplication synchrone** ou **asynchrone** ?
- Comment **gérer les réplicas défaillants** ?
- Quelles **garanties de cohérence** offrir aux utilisateurs ?

> Ces options varient selon les SGBD, mais les **principes généraux** sont similaires dans la plupart des systèmes.

---

# Faire du neuf avec du vieux

> La réplication des bases de données est étudiée depuis les **années 1970** 🧠

- Les **principes fondamentaux** ont peu changé, 
  car les **contraintes du réseau** (latence, pannes, déconnexion)
  restent les mêmes aujourd’hui.


Ce qui a évolué :
- L'utilisation plus générale de systèmes distribués par les développeurs applicatifs.
  → Préconception, vulgarisation (ex: cohérence éventuelle)...

⚠️Considération pour le développeur (ex: [MongoDB](https://www.mongodb.com/docs/development/))

---

# Comprendre la cohérence éventuelle

> Beaucoup de malentendus entourent la **cohérence éventuelle**.

Dans ce chapitre, nous aborderons :
- le **retard de réplication** (*replication lag*),
- les garanties de lecture :
  - **read-your-writes** (lire ce qu’on vient d’écrire),
  - **monotonic reads** (lectures toujours cohérentes dans le temps).
- ...

**Objectif** : comprendre les **conséquences pratiques**  des choix de réplication dans un système distribué.

---

# Réplica

Chaque nœud qui enregistre une copie de la base de donnée est appelée *Réplica*.

🧩 Problème :
> Comment s’assurer que toutes les répliques contiennent les **mêmes données** ?

Chaque **écriture** doit être appliquée sur **toutes les répliques**.

La méthode la plus courante : **leader-based replication** (aussi appelée **master–slave** ou **active/passive**).

---

<!-- _class: transition3 -->

Leader & followers

---
# Principe général

### Le leader
- Une réplique est désignée comme **leader** (aussi : *master* ou *primary*).
- Tous les **écritures** passent **uniquement par lui**.
- Le leader **enregistre** d’abord la donnée localement.

### Les followers
- Les autres répliques sont des **followers** (*read replicas*, *slaves*, *secondaries*).
- Le leader leur **envoie un flux de changements** (replication log / change stream).
- Chaque follower **applique les écritures dans le même ordre** que le leader.

> Ex. [MongoDB : Primary & secondary](https://www.mongodb.com/docs/manual/replication/)
---

# Lecture et écriture

- **Écritures** : uniquement sur le **leader**
- **Lectures** : possibles sur **le leader ou les followers**

<center>

![h:300](./img/leader-follower.png)
</center>

---

<!-- _class: transition3 -->

Réplication synchrone vs asynchrone

---

# Réplication : synchrone ou asynchrone ?

Un aspect important d’un système répliqué :
> **La manière dont la réplication s’effectue.**

Deux approches possibles :
- **Réplication synchrone**
- **Réplication asynchrone**

> **Info**
> - *Paramétrable* dans certaines bases relationnelles ; 
> - *Figé dans le code* dans d’autres.

---


# Fonctionnement général

1. Le client envoie une requête d’**écriture** au **leader**.
1. Le leader enregistre la modification localement.
1. Le leader **transmet le changement aux followers**.
1. Le leader **confirme le succès** au client.

> La différence entre *synchrone* et *asynchrone* : faut-il attendre une réponse du followers ?

---

<center>

![h:400](./img/replica-synchrone-asynchrone.png)
</center>

* Follower 1 - réplication synchrone. Leader attend réception du ok → notification du client.
* Follower 2 - Réplication asynchrone. Leader suppose `:writeok:` sans attendre.

---

> ⓘ Info
> La mise-à-jour d'un follower se fait généralement en moins d'une seconde.
> 
> Circonstances de délais : 
> - un follower subit ou récupère d'une panne ;
> - un follower saturé ;
> - des problèmes sur le réseau.

---

# Réplication synchrone

## ✅ Avantage :

- Le follower a toujours une copie à jour et cohérente. 
⇒ Si le leader tombe, la donnée est sûre.

## ❌ Inconvénient :

- Si le follower ne répond pas (panne, réseau), le leader bloque toutes les écritures jusqu'à rétablissement du follower.

---

# Réplication asynchrone

## ✅ Avantages :

- Le leader ne bloque jamais.
- Performances plus élevées

## ❌ Inconvénient :

- Si le leader échoue avant la réplication, certaines écritures peuvent être perdues. 
⇒ La durabilité n’est pas garantie.

---

# Réplication asynchrone et non durabilité

<center>

![](./img/follower_asynch_non_durable.png)
</center>

⚠️ Le client a bien reçu la confirmation d'écriture.
✅ Reste une bonne idée s'il y a beaucoup de follower ou géographiquement distribué.

---

# Tout synchroniser, une bonne idée ?

Si tous les followers étaient synchrones, la panne d’un seul nœud bloquerait tout le système 😱
⇒ **impraticable** en production.

## Solution si souhait de backup :

- *1* unique follower synchrone.
- Les autres sont asynchrones.
- Un follower synchrone trop lent est remplacé.

> Cette configuration s’appelle souvent : **Réplication semi-synchrone**

---

# Configuration d'un nouveau follower

Comment charger les données du leader ?

<div class="columns">
<div>

* copier les données du leader ? 
↦ Prend du temps & Flux de données en cours !
⇒ perte d'écriture.

![](./img/setting_up_follower.svg)
</div>

<div>

* Lock de base de donnée ? 
↦ Contre la haute disponibilité
</div>
</div>

---

## Configuration sans indisponibilité

1. Création du snapshot
2. Copie du snapshot
3. Follower demande au Leader les changements survenus depuis le snapshot
→ Snapshot associé à une position dans le *replication log*
   - Postgres - LSN (Log Sequence Number)
   - MongoDB - oplog(https://www.mongodb.com/docs/manual/core/replica-set-oplog/)
4. Lorsque le follower a rattrapé son retard, il se synchronise au flux comme les autres followers.

---

<center>

![h:550](./img/setting_up_follower-no_downtime.svg)
</center>

---


<!-- _class: transition3 -->

Prise en charge d'une panne de nœud (outage)

---

# Contexte

- Dans un système distribué, **n’importe quel nœud peut tomber en panne** :
  - panne matérielle
  - erreur logicielle
  - ou simple **maintenance planifiée** (ex. redémarrage après mise à jour)

---

# Objectifs

- Maintenir le **système globalement disponible**,
  même si un ou plusieurs nœuds tombent.
- Réduire au **minimum l’impact d’une panne locale**.
- Permettre le **redémarrage d’un nœud** sans interruption du service.

---

# Panne d'un follower

- Chaque **follower** conserve localement un **log des changements** reçus du leader.
- Si un follower tombe et redémarre ou s'il y a un problème réseau
  1. Lit sa dernière opération dans le log.
  2. Demande au leader les opérations manquantes.
  3. Applique ces changements pour **se resynchroniser**.
  4. peut recevoir et appliquer le flux de changements habituel.

---

# Panne du leader : failover

## Définition

- Quand le **leader échoue**, un autre nœud doit prendre le relais.
- Ce processus est appelé **failover** (ou reprise).
- Il implique de :
  1. Promouvoir un nouveau leader
  2. Reconfigurer les clients
  3. Synchroniser les autres réplicas avec le nouveau leader

---

## Type de failover

- **Manuel** : un administrateur est notifié et choisit le nouveau leader.
- **Automatique** : le système détecte l’échec et agit seul. 

---

## Failover automatique

### Étape 1 - Détecter la panne du leader

- Causes possibles : crash, coupure réseau, panne de courant...
- Pas de détection parfaite.
- Méthode la plus courante : **timeout** ⏱️
  - Si le leader ne répond plus après x secondes → on le déclare mort.
- Exemple : *heartbeat* manquant pendant 30s.

---

### Étape 2 — Choisir un nouveau leader

- Peut se faire via :
  - une **élection** entre nœuds, ou
  - un **contrôleur** déjà élu qui désigne le leader.
- Meilleur candidat
   - celui avec les **données les plus à jour** (ex : réplica synchrone)
   - celui avec une meilleure latence (au center)
- C’est un **problème de consensus**.

---

### Étape 3 — Reconfiguration

- Les clients doivent envoyer leurs **writes** au nouveau leader.
- L’ancien leader, s’il revient :
  - peut encore se croire leader ⇒ problème
  - doit être **forcé à devenir follower**.

---

## Problèmes possibles

### 1.  **Pertes de données** (réplication asynchrone)

- Le nouveau leader n’a pas tous les derniers writes.
- Si l'ancien leader revient,
  - Le nouveau leader a probablement reçu des writes conflictuel
  - Le plus courant → les writes non répliqués de l’ancien leader sont **supprimés**

---

### 2. Perte & **data leak**

> [Incident Github](https://github.blog/news-insights/github-availability-this-week/) - « Synchronisation » avec un système externe
>
> - Un follower (MySQL) est promu leader (des données ne sont pas à jour )
> - Utilisation d'un compteur auto-incrémenté pour les clés primaires.
> - Réutilisation de clés primaires déjà utilisées.
> - Clés utilisées dans Redis
> * → Des données privées ont été affichées aux mauvais utilisateurs.

---

### 3. **split brain** (deux leaders)

- Nœuds pensent être leader.
⇒ les deux nœuds acceptent les écritures ⇒ **incohérence** ou **corruption**
- Certains système on des mécanismes pour couper un nœud si 2 leaders.
  → (*Shoot The Other Node In The Head*)
- Quel nœud choisir ? ⚠️ Ne pas couper les deux nœuds par accident.

---

### 4. **Durée du sursis ?**

Combien de temps faut-il attendre avant de déclarer un nœud mort ?

- Temps trop long 
→ on augmente le risque et la gravité des problèmes.
- Temps trop court
  → faux positifs et failover inutiles.
  - un pic de requêtes peut provoquer un ralentissement (pas le meilleur moment pour changer de leader...),
  - un ralentissement sur le réseau peut survenir.
   
   
  Dans les deux cas, un failover inutile risque d'empirer la situation.

---

## En pratique

- Beaucoup d’équipes préfèrent un **failover manuel**,  
  même si le système supporte l’automatique.
- Ces problèmes relèvent des **fondamentaux des systèmes distribués** :
  - Pannes de nœuds  
  - Réseaux non fiables  
  - Équilibre entre cohérence, disponibilité, durabilité et latence

---

<!-- _class: transition3 -->

Implémentation des logs de réplication

---

<!-- _class: cite -->

Le **leader** applique les écritures et envoie les changements à ses **followers**.  
Ces changements sont enregistrés dans un **log de réplication**. Comment transmettre ces logs ?

---

# 1. Réplication basée sur les « statements » (SBR)

- Le leader *log* chaque requête d'écriture (*statement*) qu'il a reçu et les transmet à ses followers.
   > Exemple de requêtes (modèle relationnel) : `INSERT`, `UPDATE`, `DELETE`, `REPLACE`.
- Chaque follower exécute ces requêtes à leur tour.

→ Facile et léger. Mais ?

---

### Inconvénients

- **Fonctions Non-déterministes** : `NOW()` ou `RAND()` → donne des résultats différents à chaque appel.
- **Ordre d’exécution** critique pour `AUTO_INCREMENT` et `WHERE`.
   - INSERT ↦ COUNT ≠ Count ↦ INSERT
- **Effets de bord** possibles (triggers, procédures, functions).

---

### Piste de solution

- remplacer les fonctions non déterministes par avec une valeur fixe.

Trop de cas annexes. 

- MySQL v5.1 (défaut): ~~statement-based replication~~ ↦ Row-based replication (RBR)
   📖 [avantages et désavantage SBR et RBR]()
- VoltDB l'utilise encore - cas exceptionnel

---

# 2. Write-ahead log (WAL) Shipping

Le leader écrit toutes les modifications dans un journal d’écriture (*WAL*).
(⚠️ bas niveau - Quel byte a été modifié dans quel bloc du disque)


Ce même journal est :
- écrit sur disque local,
- envoyé sur le réseau vers les followers.

Le follower rejoue le WAL pour reconstruire l’état exact du leader.

---

### ✅ Avantages

- Très précis, fiable après crash.
- Reflète exactement les opérations disque du leader.
- Utilisé dans PostgreSQL et Oracle.

### ❌ Inconvénients

- Format bas niveau → lié au moteur de stockage.
- Versions différentes (leader/follower) souvent incompatibles.
- Rend les mises à jour logicielles sans arrêt difficiles (nécessite downtime).

---

# 3. Logical (row-based) log replication

- Le log de réplication est découplé du moteur de stockage interne (**logical log**).
- Chaque entrée du log correspond à une ligne d'une table modifiée :
   - INSERT - nouvelles valeurs
   - DELETE - identifiant unique (ex. clé primaire) 
   (toutes les valeurs si nécessaires. ex.  m2m)
   - UPDATE - identifiant + nouvelles valeurs

> **1 transaction**
>
> *n* modifications → *n* enregistrements dans le log + 1 « transaction commitée».

---

### ✅ Avantages

- Retrocompatibilité (*n* noeud, *m* version).
- Peut fonctionner avec plusieurs moteurs de stockage.
- Facile à parser par des systèmes externes : 
ex. Data warehouse (*change data capture*)

---

### Change Data Capture (CDC)

- Technique dérivée de la réplication logique.
- Permet d’envoyer les changements vers des systèmes externes :
   - ETL / pipelines de données (Extract Transform Load).
   - ElasticSearch, Kafka, etc.
- Base de nombreuses architectures event-driven modernes.
   - ex : [MongoDB CDC](https://www.mongodb.com/docs/kafka-connector/current/sink-connector/fundamentals/change-data-capture/?event-producer=mongodb) 
   - [MongoDB Change Streams (ex. code)](https://www.mongodb.com/docs/manual/changeStreams/)
---

# 4. Trigger-Based Replication

- Implémentée au **niveau applicatif** via des triggers SQL.
- Chaque modification déclenche un code :
   - écrit le changement dans une table spéciale
   - un processus externe lit cette table et réplique ailleurs

---

### Cas d'utilisation 

Besoin de plus de flexibilité. Ex. 
   - besoin de répliquer un sous ensemble de données,
   - répliquer d'un type de bd à un autre,
   - intégrer de la logique métier.

   → remonter la réplication au niveau applicatif.

### Comment 

Utilisation des **triggers** et ou des **procédures stockées**.

---

### Points d'attention

- Plus lent (overhead).
- Plus exposé aux bugs.

### Exemple

- [PostgreSQL - Bucardo](https://wiki.postgresql.org/wiki/Bucardo)

---

<!-- _class: transition2 -->

Problème avec le replication lag

---

# Pourquoi parle-t-on de « lag » ?

> ### Replication lag
> La réplication n’est pas instantanée :
  les **followers** peuvent avoir un **retard** sur le **leader**.

En général : < 1s, mais peut atteindre plusieurs secondes ou minutes.

---

## Architecture courante

- **Leader-based replication** :
  - écriture → **leader**
  - les lectures → **followers**
- Bon compromis si les écritures sont rares.

> **Architecture read-scaling**
> ↗ lecture → ↗ followers

⚠️ Mais cette approche repose sur une **réplication asynchrone** (pq ?).

<!-- Dans le cas d'une approche de réplication synchrone, un seul noeud down ou isolé bloque tout le système. -->

---

## Le risque : l’incohérence temporaire

- Si un follower est en retard :
  - il ne reflète pas encore les dernières écritures du leader.
- Résultat :
  - deux requêtes simultanées (leader vs follower) → **résultats différents**.
- C’est un état **temporairement incohérent** :
  > le système devient *eventually consistent*.

---

## Eventual Consistency

<center>

![h:500](./img/eventual_consistency.svg)
</center>

---

- Tous les réplicas **finiront par converger**,  
  mais sans garantie sur **quand**
- Terme popularisé par Douglas Terry et Werner Vogels.

Le *replication lag* est généralement < 1s, s'il devient plus long → problème pour les appliciations.

---

## Trois problèmes typiques

* **Read-Your-Writes** inconsistency  
* **Monotonic Reads** violation  
* **Consistent Prefix Reads** violation  

---

## 1. Read-Your-Writes Consistency

### Situation
- L’utilisateur écrit une donnée (sur le *leader*).
- Puis relit la même donnée (sur le *follower*).
Le follower n’a pas encore reçu la mise à jour.

### Effet
> L’utilisateur ne voit pas sa propre modification.
> → Il croit que ses données sont perdues 😬

---

<center>

![h:450](./img/read_your_write.png)
Lecture d'un réplica à jour suivi d'une lecture d'un réplica en retard.
</center>

---

Nous avons besoin de cohérence : *read-after-write* ou encore *read-your-write*

### Exemple de solution

- Lire depuis le **leader** les données que l’utilisateur peut modifier (profil utilisateur). 
- Lire depuis le **leader pendant X secondes** après une écriture (monitoring).
- Le client mémorise le **timestamp** de son dernier write : Si un follower est en retard
  - demander à un autre follower,
  - mettre la requête en pause.

> **Logical Timestamp**
> - log sequence number
> - horloge du système

---

## 2. Monotonic reads

### Situation

- Un utilisateur lit depuis deux réplicas différents.
  - 1ère lecture → follower à jour (petit lag)
  - 2e lecture → follower en retard (grand lag)
- Résultat : il voit les **données reculer dans le temps**

---

## Exemple

> L’utilisateur voit d’abord un nouveau commentaire apparaître,  
> puis disparaître lors d’un rafraîchissement.

> **Garantie monotonic read**
> « On ne lit jamais une version plus ancienne que celle déjà vue. »

---

<center>

![h:500](./img/monotonic_read.png)
</center>

---

## Solutions

- Associer chaque utilisateur à **un même replica** :  
  - ex. hash sur l’ID utilisateur.  
- Si le replica échoue → basculer vers un autre plus à jour.

---


## 3. consistent Prefix Reads

### mise en situation

**Mr. Poons :** “How far into the future can you see?”  
**Mrs. Cake :** “About ten seconds, Mr. Poons.”  
→ Sur un follower lent : la réponse arrive avant la question.

---

<center>

![h:500](./img/consistent_prefix_reads.png)

</center>

---

## Consistent Prefix Reads

> En cas de causalité, les écritures doivent toujours être lues dans l'ordre temporel.  
>  
> Si A précède B, on ne peut pas lire B avant A.

Difficile à garantir lorsqu'il y a **plusieurs partitions (leader)** :
- Pas d’ordre global entre partition (écriture).
- Certaines partitions peuvent être plus à jour que d’autres.

---

<!-- _class: transition2 -->
Réplication Multi-Leader

![h:300](./img/multi-leader_scheme.svg)

---

## Idées générales

- Au lieu d’un **seul leader**, **plusieurs nœuds** acceptent des écritures.
- Chaque leader est aussi **follower** des autres.
- Avantage clé : écrire localement même si un lien réseau vers un autre DC est coupé.
- Inconvénient majeur : **conflits d’écriture** possibles.

---

## Moins fréquent que la réplication avec un leader

- En **monodatacenter**, la complexité dépasse souvent les gains.
- Utile quand :
  - multi-datacenters (ex: réplication géographique)
  - clients **offline** (sync différée) 📱
  - édition **collaborative** en **temps réel**

---

# Cas d'usage

* Multi-datacenters
* Client offline
* Édition collaborative

---

## Cas d’usage — Multi-datacenters

- **Single-leader** :
  - toutes les écritures traversent l’Internet → **latence** élevée
  - sensibilité aux pannes du DC leader
- **Multi-leader** :
  - écriture **locale**, réplication **asynchrone** inter-DC
  - meilleure tolérance aux pannes/réseau
- ⚠️ Risque : conflits entre DC → **résolution nécessaire**

---

<center>

![h:550](./img/multi-leader_replication_x_multi-DC.png)
</center>

---

<center>

![h:300](./img/hazard-area-op.png)

</center>

Zone dangereuse à éviter si possible.

- Configuration piégeuse,
- intéractions subtiles avec d'autres sgbd (génération auto d'ID, triggers...)

---

## Cas d’usage — Clients offline (calendrier)

- Chaque appareil = db interne agit comme mini-leader local.
- Modifs en local, **sync asynchrone** quand réseau dispo.
- Lag de quelques **heures/jours** possible.
- Modèle conceptuel ≈ multi-DC « extrême ».
- Exemples historiques : calendriers.

> et google doc ?

---

![bg left:33%](./img/google-doc_logo.svg)

## Cas d’usage — Édition collaborative

- Plusieurs éditeurs → **écritures concurrentes**
- Changements fins (ex. **frappe par frappe**), (pas de modification offline)
- Besoin de **résolution de conflits** (algos dédiés)
- Alternative : verrou (équivaut à single-leader + transactions)

---

# Prise en charge des conflits

---

### Deux leaders modifient **la même donnée** en parallèle

<center>

![h:400](./img/multi-leader_conflict.png)
</center>

---

## Détection de conflit **Synchrone** & **Asynchrone**

<div class="columns">
<div>

### Un leader (synchrone)

Le 2ème write
- est mis en attente
- ou annulée

</div>
<div>

### Multi-leader (asynchrone)

Les deux writes **réussissent**, conflit détecté **plus tard**

</div>
</div>

> ## 💡 Réplication synchrone entre leader ?
> Perte du principal avantage : écritures indépendantes
> ⇒ 🛑 Utiliser un seul leader !

---

## Évitement de conflit

### Observation

> ℹ️ Beaucoup d'implémentation multi-leader implémentent mal la gestion des conflits

### Appliquer une gestion d'évitement de conflits ✅

* 💡 Router toutes les écritures d’un **même enregistrement** vers **un leader désigné**
   > *ex:* Données personnelles utilisateur dans un « home Datacenter » (parfait pour optimisation géographique)

* ⚠️ Re-routage possible (panne datacenter, déménagement utilisateur...)
⇒ retour du risque de conflits

---

## Converger vers un état cohérent

### Un leader
> Les écritures sont appliquées selon un ordre unique, défini par le traitement du leader.

### Plusieurs leaders
> Chaque nœud peut appliquer les écritures dans un ordre différent, ce qui conduit à plusieurs ordonnancements équivalents mais potentiellement divergents.

---

### Objectif :
> Avoir **tous les réplicas** doivent résoudre les conflits de manière à finir avec le **même état final**.

- Approches communes :
  - **LWW** (*Last Write Wins*) via timestamp/ID max → simple mais **perte de données**
  - **Priorité du # de répliques** (ID de nœud) → aussi perte potentielle
    - <span class="math"> x </span> répliques avec`v:2`
    - <span class="math"> y </span> répliques avec `v:1`
    - si <span class="math"> x < y </span> alors `v:1`
  - **Fusion** des valeurs (ex. concat triée) → dépend du domaine
  - **Conflit enregistré**, résolu plus tard (prompt à l'utilisateur/code applicatif)

---

## Logiques de résolution personnalisée

- **On write** : detection de conflit ↦ handler de conflit (rapide, *non interactif*)
- **On read** : renvoyer versions multiples → app décide (peut impliquer l’utilisateur)
> *Granularité*
> Souvent par **ligne/document**, pas de transaction entière
⇒ Chaque écriture est traitée séparément

---

### Résolution automatique (compliqué 🤯)

> **Cas d'école**
>  Pannier amazon qui conserve les items ajoutés mais peut ne supprimer certains articles.

> ### État de l'art en 2017
> - **CRDTs** : famille de structures de données modifiées - de manière concurrente - sans conflit (compteurs, sets, listes...) (merge 2-voies)
> - **Mergeable persistent data structures** : tracking de l'historique + merge 3-voies (git)
> - **Operational Transformation (OT)** : édition collaborative (suite d'élément - ex: suite de caractères (Google Doc)

---

## Exemple de conflits

- Modification d'un même champ.
- Réservation d'une chambre d'hotel
- ...

---

# Topologies multi-leaders

> **Topologie de réplication**
> Descrit les chemins de communication que les requêtes d'écriture doivent traverser pour se propager d'un leader aux autres leaders.

> Cas nb leaders ≤ 2 identiques

---

<center>

![h:280](./img/multi-leader_topology.png)
</center>

- **Ring (cercle)** : chaque leader transmet à un et un seul voisin.
- **Star / arbre** : un seul leader reçoit et transmet aux autres leaders.
- **All-to-all** : chaque leader transmet à tous les autres.
> Tag d’ID de nœuds traversés dans le log pour prévenir les boucles (pensez au parcours de graphe en 3alg3).

---

### Tolérance aux pannes & Ordonnancement

- **Ring & Star** : panne d’un nœud → propagation interrompue
- **All-to-all** : meilleure résilience (évite le single point of failure), mais **désordre d’arrivée** possible
⇒ Problème de **causalité** :
  - un **UPDATE** peut arriver avant l’**INSERT** correspondant sur un nœud
  - horloges insuffisantes → besoin de **version vectors** / suivi causal

---
<center>

![h:450](./img/all_to_all_causality.png)
</center>

⚠️ Attention souvent pas ou mal géré. Toujours vérifier la prise en charge de ce type de conflits par le sgbd si important pour l'application.

---

<!-- _class: transition2 -->
Réplication sans leader.

![h:300](./img/leaderless_scheme.svg)

---

## Idées générales

- Pas de **leader** : **n’importe quel replica** peut accepter des écritures.
- Le client envoie aux **plusieurs réplicas** (via un **coordinateur** léger).
- Pas d’**ordre global** imposé → conséquences sur cohérence et résolutions de conflits.
- Exemples : **Cassandra**, **Riak**, **Voldemort** (inspirés de **Amazon Dynamo**).

---

## Écrire quand un nœud est down

- Avec un ou plusieurs leader, on doit attendre un failover (reprise du leader).
- Sans leader (exemple 3 réplicas)
   - le client écrit en **parallèle** aux 3.  
   - Si 1 réplique est indisponible, **2 réplicas** réponde **ok**.
   - Le nœud en retard lira ensuite une **valeur obsolète** → besoin de **réparation**.

---

### Pour résoudre le problème potentiel de valeur obsolète 
  - une lecture à la base de données = plusieurs requêtes de lecture en parallèle (≠ replicas).
  - des réponses ≠ peuvent être obtenue
  - utilisation d'un numéro de version pour connaître la valeur la plus récente.

---

<center>

![h:500](./img/quorum_w_r-read_repair.png)
</center>


---

<center>

![](./img/work-in-progress.jpeg)
<center>

---

<!-- _class: biblio -->

- **Kleppmann, M. (2015).** A Critique of the CAP Theorem. [🔗](https://martin.kleppmann.com/2015/05/11/please-stop-calling-databases-cp-or-ap.html)
- **Kleppmann, M. (2017).** Designing data-intensive applications.
- **Sadalage, P. J., & Fowler, M. (2013).** NoSQL distilled: a brief guide to the emerging world of polyglot persistence. Pearson Education.

---

<!-- _class: transition2 -->

Merci !