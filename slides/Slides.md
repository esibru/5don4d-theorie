---
title       : Base de donnée 4
author      : Sébastien Drobisz
description : Supports de l'UE 5DON4D.
keywords    : NoSQL, distribué, dénormalisation
marp        : true
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

- Comprendre et mettre en application les points forts d'un **SGBDR**.
- Comprendre et mettre en application les points forts de différents **SGBD NoSQL**.
- Critiquer les forces et les faiblesses des différents modèles de données.
- Adapter la configuration d'un système distribué à certains scénarios
- Concevoir un système multi-modèle adapté.

---

<!-- _class: cite -->

5don4 — Une histoire de compromis

---

# Organisation de l'unité

## BIM1 & BIM2

- 2h par semaine théorie
- 2h par semaine de laboratoire

--- 

L'**évaluation** repose sur 
* la réalisation d'un système **polyglotte** qui vous servira de support pour évaluer la compréhension de la gestion de données dans une application moderne.
* un examen théorique.

---

# Plan du cours (en cours de révision)

* Rappel des concepts des SGBDR
* Introduction au NoSQL
* Introduction aux 4 modèles de données "typiques"
* Réflexion sur les agrégats
* Concepts de systèmes distribués
  * CAP - BASE
  * Réplication
  * Sharding
<!-- * Série chronologique DB
* NewSQL
* Recherche de données -->

---

# Rappels SGBDR — Partie 1

## SGBD, modèle Relationnel, ACID, Normalisation, Dénormalisation

### 5DON4D — Bases de données avancées

---

# Avant de commencer...

Vous utilisez une application bancaire.

Vous effectuez un virement de **100 €** :

**Alice → Bob**

Que doit garantir le système ?

---

# Quelques garanties attendues

Lors d'un virement de **100 €** :

- l'argent doit être retiré du compte d'Alice ;
- l'argent doit être ajouté au compte de Bob ;
- les deux opérations doivent réussir **ensemble** ;
- deux virements simultanés ne doivent pas corrompre les soldes ;
- une panne ne doit pas faire disparaître un virement validé.

> Ces problèmes font partie des responsabilités d'un **SGBD**.

---

# Qu'est-ce qu'une base de données ?

Une **base de données** est un ensemble organisé de données persistantes.

Exemples :

- étudiants et inscriptions ;
- comptes et transactions bancaires ;
- produits et commandes ;
- utilisateurs et publications ;
- mesures provenant de capteurs.

Mais une base de données n'est **pas** un SGBD.

---

# Base de données ≠ SGBD

**Base de données**

> Les données organisées et persistantes.

**SGBD — Système de Gestion de Bases de Données**

> Le logiciel chargé de **stocker, organiser, interroger et protéger** ces données.

Exemples : PostgreSQL, MySQL, MongoDB, Redis, Neo4j...

---

# Pourquoi ne pas utiliser des fichiers ?

Imaginons :

```text
students.csv
courses.csv
registrations.csv
```

> Cela fonctionne... jusqu'à ce que plusieurs applications veuillent :

- modifier les mêmes données ;
- garantir leur cohérence ;
- rechercher efficacement ;
- gérer les pannes ;
- contrôler les accès.

---

# Le rôle du SGBD

Un SGBD prend notamment en charge :

- la persistance ;
- l'organisation des données ;
- les requêtes ;
- les index ;
- les contraintes d'intégrité ;
- les accès concurrents ;
- les transactions ;
- la récupération après une panne ;
- les droits d'accès.

---

# Le modèle relationnel

Dans un SGBD relationnel, les données sont organisées sous forme de relations.

En pratique :

```text
STUDENT

id | name   | city
---|--------|----------
1  | Alice  | Mons
2  | Bob    | Namur
3  | Chloé  | Charleroi
```

Une relation est généralement représentée par une **table**.

---
Un peu de vocabulaire

```text
STUDENT

id | name   | city
---|--------|----------
1  | Alice  | Mons
2  | Bob    | Namur
```

- **relation** → STUDENT
- **attribut** → name
- **tuple** → (1, Alice, Mons)
- **domaine** → valeurs autorisées pour un attribut
- **clé primaire** → id

---

# Les clés

Une **clé primaire** identifie un tuple de manière unique.

```sql
CREATE TABLE student (
    id INTEGER PRIMARY KEY,
    name VARCHAR(100)
);
```

Un **clé étrangère** établit une référence vers une autre relation.
```sql
student_id INTEGER REFERENCES student(id)
```

---

# Les contraintes

Le SGBD peut garantir certaines propriétés des données.

```sql
CREATE TABLE account (
    id INTEGER PRIMARY KEY,
    owner VARCHAR(100) NOT NULL,
    balance DECIMAL(10,2)
        CHECK (balance >= 0)
);
```

Ici :
```sql
balance = -200
```
est un **état interdit**.

---

# Pourquoi les contraintes sont-elles importantes ?

## Sans contrainte :

```
Application A ──┐
                │
Application B ──┼──► Base de données
                │
Application C ──┘
```

> Leeerroooy jeeennnnnnkkkiiiiiinnnnssssssssss — at least he has chicken.

---

# Pourquoi les contraintes sont-elles importantes ?

## Avec les contraintes :

```
Applications
     │
     ▼
    SGBD
     │
     ├── PRIMARY KEY
     ├── FOREIGN KEY
     ├── UNIQUE
     ├── NOT NULL
     └── CHECK
```

Les règles sont garanties **au niveau des données**.

---
# SQL est déclaratif

Considérons :

```sql
SELECT name
FROM student
WHERE city = 'Mons';
```

Nous décrivons :

> ce que nous voulons

mais pas :

> comment le trouver

Le SGBD choisit une stratégie d'exécution.

---

# Comment trouver les données ?


```sql
SELECT *
FROM student
WHERE id = 48392;
```
Approche naïve :

1 → 2 → 3 → 4 → ... → 48392

Le SGBD pourrait devoir parcourir toute la table.

C'est un **table scan**.

---

# Les index

Un index est une structure auxiliaire permettant de retrouver plus rapidement des données.

```text
                 [50]
                /    \
             [20]    [80]
             / \      / \
           ... ...  ... ...
```

Une structure courante : **B-tree**

---

# Un index : toujours une bonne idée ?

Pas nécessairement.

## Un index :

<div class="columns"> <div>
<strong>✓ améliore</strong>

les recherches

``` sql
WHERE email = ?
```

les tris

``` sql
ORDER BY date
```
</div> <div>
<strong>✗ coûte</strong>

- de l'espace disque
- et doit être mis à jour lors des :
  - INSERT
  - UPDATE
  - DELETE
</div> </div>

---

# Un compromis récurrent

Ajouter une structure pour accélérer les **lectures** implique souvent davantage de travail lors des **écritures**.

```text
             INDEX

lecture      +++++
écriture     ---
stockage     ---
```

Nous retrouverons régulièrement ce type de compromis dans les systèmes NoSQL.

---

# Comment savoir ce que fait le SGBD ?

De nombreux SGBD permettent d'inspecter le plan d'exécution.

Avec PostgreSQL :

```sql
EXPLAIN
SELECT *
FROM student
WHERE id = 48392;
```

---

<!-- _class: transition -->
Transactions

*Que se passe-t-il lorsqu'une opération métier nécessite plusieurs modifications ?*

---

# Un virement bancaire

Alice possède 1 000 €.

Bob possède 500 €.

Alice transfère 100 € à Bob.

---

Requêtes
```sql
UPDATE account
SET balance = balance - 100
WHERE id = 'Alice';

UPDATE account
SET balance = balance + 100
WHERE id = 'Bob';
```
Résultat attendu :

```text
Alice: 900€
Bob: 600€
```

---

# Mais...

Que se passe-t-il dans le scénario de panne suivant ?

```text

Alice : 1000 €
Bob   :  500 €

UPDATE Alice -100
        │
        ▼
Alice : 900 €
Bob   : 500 €
        │
        💥
       PANNE
```

Nous avons perdu 100 €.

---

# transaction

Une **transaction** regroupe plusieurs opérations en une unité logique.

```sql
BEGIN;

UPDATE account
SET balance = balance - 100
WHERE id = 'Alice';

UPDATE account
SET balance = balance + 100
WHERE id = 'Bob';

COMMIT;
```
---

`COMMIT` signifie :

La transaction est terminée avec succès et ses modifications peuvent être validées.


```text
BEGIN ──► opérations ──► COMMIT
                           │
                           ▼
                        validé
```

---

# ROLLBACK

Si quelque chose se passe mal :

```sql
BEGIN;

UPDATE ...
UPDATE ...

ROLLBACK;
```
Les modifications de la transaction sont annulées.

---

# Mais ce n'est pas le seul problème...

Imaginons maintenant deux transactions simultanées.

Solde initial : **100 €**

Deux applications veulent modifier ce compte.

> Que peut-il se passer ?

---

# Concurrence

```text
Transaction A              Transaction B

READ → 100                 READ → 100

+ 20                       - 30

WRITE 120                  WRITE 70
```

Résultat final : **70 €**

Mais nous attendions : **90 €**

⚠️ Une modification vient de disparaître. ⚠️

---

# Le SGBD doit donc gérer...

```text
                    Transactions
                         │
          ┌──────────────┼──────────────┐
          ▼              ▼              ▼
       erreurs        pannes        concurrence
```
Nous avons besoin de garanties plus précises.

---

<!-- _class: transition -->

ACID

Quatre propriétés traditionnellement associées aux transactions.

---

# A — Atomicité

*Une transaction est exécutée entièrement ou pas du tout.*

Pour notre virement :

```text
Alice -100  ✓
Bob   +100  ✓
```
ou :

```text
Alice -100  ✗
Bob   +100  ✗
```
mais jamais :

```text
Alice -100  ✓
Bob   +100  ✗
```

---

# C — Cohérence

*Une transaction valide fait passer la base d'un état valide à un autre état valide.*

Exemple d'invariant :

```text
balance >= 0
```

ou :

```text
une inscription référence
un étudiant existant
```

Les contraintes participent au maintien de cette cohérence.

---
# Attention au mot « cohérence » ou « consistency »

Le mot **consistency** est malheureusement utilisé pour plusieurs concepts.

## ACID

Respect des règles et invariants de la base.

---

## Systèmes distribués

Cohérence entre différentes copies des données.

```text
ACID consistency ≠ replica consistency
```

Nous rencontrerons la seconde signification plus tard

Les contraintes participent au maintien de cette cohérence.

---

# I — Isolation

Deux transactions peuvent s'exécuter concurremment.

Mais leurs interactions doivent être contrôlées.

```text
T1 ──────────────┐
                 ├──► SGBD
T2 ──────────────┘
```

L'objectif est d'éviter certaines anomalies liées aux **accès concurrents**.

---

D — Durabilité

Après :

```sql
COMMIT;
```

le SGBD annonce que la **transaction est validée**.

Même si la machine tombe en panne juste après :

```text
COMMIT
   │
   ▼
   ✓
   │
   💥
```

les données validées doivent pouvoir être récupérées.

---

ACID en quatre questions

| |	Question | 
|---|---|
|A | Que se passe-t-il si l'opération échoue au milieu ?|
|C | Les règles de la base restent-elles respectées ?|
|I | Que se passe-t-il si plusieurs transactions s'exécutent simultanément ?|
|D | Que se passe-t-il après COMMIT si le serveur tombe en panne ?|

---

# À vous !

Une commande contient :

```text
Order
 ├── OrderLine A
 ├── OrderLine B
 └── Payment
 ```

La commande est créée, mais une panne survient avant la création du paiement.

Quelle propriété ACID est principalement concernée ?

---

# À vous !

Une transaction produit :

```text
balance = -50 €
```

alors que la règle métier impose :

```text
balance >= 0
```

Quelle propriété ACID est principalement concernée ?

---

# À vous !

Deux utilisateurs modifient simultanément la même donnée et l'une des modifications est perdue.

Quelle propriété ACID est principalement concernée ?

---

# À vous !

Le SGBD répond :

```text
COMMIT ✓
```

Une seconde plus tard :

```text
💥 panne électrique
```

Après redémarrage, la transaction a disparu.

Quelle propriété ACID n'a pas été respectée ?

---

<!-- _class: transition -->
Normalisation des données

---

# Normalisation des données

La **normalisation** consiste à organiser les données afin de :

- limiter la **redondance**
- éviter les **incohérences**
- faciliter les **mises à jour**
- garantir l'**intégrité** des données

---

## Exemple

Avec une seule table :

| id_commande | client | adresse_client | produit | prix |
|-------------|--------|----------------|---------|------|
| 1 | Alice | Bruxelles | Clavier | 80 € |
| 2 | Alice | Bruxelles | Souris | 30 € |

➡️ Les informations concernant **Alice sont répétées**.

---

## Après normalisation

On sépare les différentes entités :

**CLIENT**

| id | nom | adresse |
|----|-----|---------|
| 12 | Alice | Bruxelles |

**COMMANDE**

| id | client_id |
|----|-----------|
| 1 | 12 |
| 2 | 12 |

---

**PRODUIT / LIGNE_COMMANDE**

Les relations permettent ensuite de **reconstruire l'information**
avec des jointures.

> On cherche avant tout à stocker les données de manière
> **cohérente et structurée**.

La question : Comment vais-je intérroger mes données ? N'est que peux considérée ici.

---

<!-- _class: transition -->
# Dénormalisation des données

---

# Normaliser... toujours ?

La **normalisation** vise notamment à éviter :

- la redondance des données ;
- les anomalies de mise à jour ;
- les incohérences.

Mais une base parfaitement normalisée peut nécessiter :

- davantage de jointures ;
- davantage de calculs ;
- des requêtes plus complexes ou coûteuses.

> Il peut parfois être intéressant de **dupliquer volontairement une information**.

---

# Dénormalisation

La **dénormalisation** consiste à stocker volontairement une information
qui pourrait être **retrouvée ou calculée à partir d'autres données**.

Exemple :

```text
ORDER
─────────────────────────
id
customer_id
...

ORDER_LINE
─────────────────────────
order_id
quantity
unit_price
```

---

Le montant total peut être calculé :

```sql
SELECT SUM(quantity * unit_price)
FROM order_line
WHERE order_id = 42;
```

Mais on pourrait aussi stocker :

```text
ORDER
─────────────
id
customer_id
total_amount  ← donnée calculée
```

* **Avantage :** lecture plus rapide.
* **Inconvénient :** `total_amount` doit rester cohérent avec les lignes de commande.

---
 <!-- Cours 02 -->

 # Exemple Odoo

 Dans Odoo, un champ peut être calculé à partir d'autres champs.

```python
total = fields.Float(
  compute = "_compute_total"
  store = True
)
```

Avec `store=True`, une valeur qui pourrait être calculée à la demande
est conservée en base de donnée.

On échange donc de l'**espace + coût de mise à jour** contre **une lecture plus rapide**

---

<!-- _class=cite --->
Si je modifie `quantity`, que doit-il arriver à `total_amount` ?

* il faut **recalculer la valeur**. ⚠️ dès qu'on duplique une information, **la cohérence devient notre responsabilité** — ou celle d'Odoo dans cet exemple.

Dans un SGBDR sur une machine, Odoo peut maintenir cette valeur calculée. Que se passe-t'il lorsqu'elle est **répliquée sur plusieurs nœuds** ou représentée dans **plusieurs modèles de données**.
  > *comment maintenir toutes ces représentations cohérentes ?*


---

# Récapitulatif

Aujourd'hui :

```text
                  SGBD
                   │
       ┌───────────┼───────────┐
       ▼           ▼           ▼
    données     requêtes   transactions
       │           │           │
 contraintes    index         ACID
```

Un SGBD ne se contente donc pas de stocker des données.

Il fournit des garanties sur leur manipulation.

---

# Et maintenant ?

Jusqu'ici, nous avons implicitement supposé :

```text
  1 Application (1 client)
             │
             ▼
        ┌─────────┐
        │  SGBD   │
        └─────────┘
             │
             ▼
          disque
```

Que se passe-t-il lorsque plusieurs transactions, plusieurs machines et plusieurs copies des données entrent en jeu ?

---

# Rappels SGBD — Partie 2

## Concurrence, logique, durabilité et limites

### 5DON4D — Bases de données avancées

---

# Rappel

Lors du cours précédent :

- rôle d'un **SGBD** ;
- modèle relationnel et contraintes ;
- index ;
- transactions ;
- `COMMIT` / `ROLLBACK` ;
- propriétés **ACID**.

Aujourd'hui, nous allons regarder ce qui se passe lorsque...

> plusieurs choses arrivent **en même temps**.

---

<!-- Ce slide devrait avoir un style particulier. -->

# 1. Concurrence

## Plusieurs transactions, une même base de données

---

# Pourquoi exécuter plusieurs transactions simultanément ?

Un SGBD peut recevoir des requêtes provenant de :

```text
Utilisateur A ──┐
Utilisateur B ──┤
Utilisateur C ──┼──► SGBD
Utilisateur D ──┤
Application  ───┘
```

Exécuter toutes les transactions l'une après l'autre serait simple...

Mais limiterait fortement les performances.

---

Un produit possède un stock de :

```text
stock = 10
```

Deux clients commandent simultanément le dernier lot de produits.

```text
Transaction A          Transaction B

READ stock             READ stock
     ↓                       ↓
    10                      10

stock = 10 - 6         stock = 10 - 5
```

Que peut-il se passer ?

---

# Lost Update

```text
Transaction A          Transaction B

READ → 10              READ → 10

10 - 6 = 4             10 - 5 = 5

WRITE 4
                        WRITE 5
```

Résultat :

```text
stock = 5
```

La modification de la `transaction A` a été perdue.

---

# Une autre anomalie

Transaction A :

```sql
SELECT balance
FROM account
WHERE id = 42;
```

Résultat :

```
1000 €
``` 

Pendant ce temps...

La `Transaction B` modifie ce compte.

---

# A. Non-repeatable read

```text
Transaction A                 Transaction B

READ balance
→ 1000 €

                              UPDATE balance
                              → 800 €
                              COMMIT

READ balance
→ 800 €
```

La même transaction lit deux valeurs différentes pour la même donnée.

---

# B. Dirty Read

Une transaction peut-elle lire une modification qui n'a pas encore été validée ?

```text
Transaction A                 Transaction B

UPDATE balance
→ 500 €

                              READ balance
                              → 500 €

ROLLBACK
```

Transaction B a utilisé une valeur...

qui n'a finalement jamais existé dans un état validé.

---

Phantom Read

Une transaction effectue :

```sql
SELECT COUNT(*)
FROM student
WHERE year = 3;
```

Résultat : `42`

Une autre transaction ajoute un étudiant puis valide.

La même requête retourne ensuite : `43`

Une nouvelle ligne est « apparue ».

---

Isolation

Le I de ACID :

Les transactions concurrentes doivent être suffisamment isolées les unes des autres.

Mais isoler complètement les transactions peut avoir un coût.

```text
  Isolation
      ▲
      │ •
      │     
      │   •
      │          •
      └──────────── ► Concurrence
```

Il existe donc différents compromis.

---

# Niveaux d'isolation SQL

Classiquement :

| Niveau           | Isolation |
| ---------------- | --------- |
| Read Uncommitted | faible    |
| Read Committed   | ↑         |
| Repeatable Read  | ↑         |
| Serializable     | forte     |

Plus l'isolation est forte, plus le SGBD doit contrôler les interactions entre transactions.

---

# A. Serializable

Idéalement, l'exécution concurrente :

```text
T1 ─────┐
        ├──── exécution concurrente
T2 ─────┘
```

produit un résultat équivalent à une exécution :

```text
T1 → T2
```

ou :

```text
T2 → T1
```

Serializable est le niveau d'isolation le plus fort.

---

# Comment faire ?

Plusieurs mécanismes existent :

- verrous ;
- MVCC ;
- contrôle optimiste ;
- détection de conflits ;
- ordonnancement des transactions.

Le choix dépend du SGBD.

---

# Verrouillage

Exemple simplifié : `Transaction A`

```text
LOCK account 42
      │
      ▼
   UPDATE
      │
      ▼
   COMMIT
      │
      ▼
   UNLOCK
```

Une autre transaction doit éventuellement attendre.

---

# Le problème des verrous

Transaction A :

```text
LOCK account A
LOCK account B
```

Transaction B :

```text
LOCK account B
LOCK account A
```

Que peut-il se passer ?

---

# 2. Logique dans le SGBD

## Toutes les règles doivent-elles être dans l'application ?

---

# Où placer la logique ?

Prenons une règle :

> Le stock d'un produit ne peut jamais être négatif.

On pourrait vérifier cela dans l'application:

```text
Application
     │ if stock >= quantity
     │ 
     ▼
    SGBD
```

Mais que se passe-t-il si plusieurs applications accèdent à la même base ?

---

# Contraintes

Certaines règles peuvent être placées directement dans la base :

```sql
CREATE TABLE product (
    id INTEGER PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    stock INTEGER CHECK (stock >= 0)
);
```

Toutes les applications bénéficient alors de la même garantie.

---

# Les vues

Une vue représente le résultat d'une requête comme une table virtuelle.

```sql
CREATE VIEW active_students AS
SELECT id, name
FROM student
WHERE active = true;
```

Puis :

```sql
SELECT *
FROM active_students;
```

---

# Pourquoi utiliser une vue ?

Une vue peut :

* simplifier des requêtes complexes (ex: 4web3d — jointures) ;
* masquer certains détails du schéma ;
* contrôler l'accès à certaines données ;
* fournir une représentation adaptée à un usage.

Elle ne contient généralement pas elle-même les données.

---

# Vue matérialisée

Une vue matérialisée stocke le résultat de la requête.

```text
Tables
  │
  │ calcul
  ▼
┌──────────────────┐
│ Vue matérialisée │
└──────────────────┘
```

✅ Avantage : **lecture plus rapide**

❌ Inconvénient : **il faut maintenir ou rafraîchir le résultat.**

---

```text
```


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