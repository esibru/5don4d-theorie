---
title       : Base de donnée 4
author      : Sébastien Drobisz
description : Supports de l'UE 5DON4D.
keywords    : NoSQL, distribué, dénormalisation
marp        : true
paginate    : true
theme       : sdr
mermaid     : true
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
* la réalisation d’un système **polyglotte** illustrant la gestion de données diverses dans une application moderne.
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

Introduction au NoSQL

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

![](/slides/img/shared-db.jpg)

</center>

* Les données modifiées par une application doit être vue par les autres ;
* garantie de cohérence, une application ne doit pas être en mesure de corrompre les données d'une autre application
* ...

---

## Modèle standard

Quelques différences entre les bases de données relationnelles, mais globalement identiques.

* Compétences des développeurs réutilisées dans beaucoup de projets.
* Requêtes SQL et fonctionnement de base identique.
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

![](/slides/img/scaling-up.png)
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

![](/slides/img/scaling-out.png)
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
Un cluster désigne des techniques consistant à regrouper plusieurs ordinateurs **indépendants** appelés noeuds, afin de permettre une **gestion globale** et de dépasser les limitations d'un ordinateur pour **augmenter la disponibilité**, **facliliter la montée en charge**, permettre une **répartition de la charge**, faciliter la **gestion des ressources**.

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
   > * un terme qui ferait un bon hashtag,
   > * qui ne renvoyait pas trop de résultat sur google
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

<!-- _class: transition -->

Introduction du NoSQL

---

# Définition du NoSQL

Il n'existe pas de définition, plutôt un ensemble de caractéristiques choisies à la convenance.
* Pas d'utilisation du SQL
* Non relationnel
* Sans schéma ⚠️
* Distribué
* Autres propriétés que les propriétés ACID.

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

<!-- _class: biblio -->

- **[NoSQL Distilled](https://www.oreilly.com/library/view/nosql-distilled-a/9780133036138/)** - A Brief Guide to the Emerging World of Polyglot Persistence. *Pramod J. Sadalage et Martin Fowler*
- **[A critique of the CAP theorem](https://martin.kleppmann.com/2015/05/11/please-stop-calling-databases-cp-or-ap.html)** *Martin Kleppmann*

---

<!-- _class: transition2 -->  

Merci !

---

# ACID ([Wikipédia](https://fr.wikipedia.org/wiki/Propri%C3%A9t%C3%A9s_ACID))

Les propriétés *ACID* (atomicité, cohérence, isolation et durabilité) sont un ensemble de propriétés qui garantissent qu'une transaction informatique est exécutée de façon fiable. 
