---
title       : Introduction aux méthodes DevOps
author      : Jonathan Lechien
description : Supports de l'unité 4DOP1DR.
keywords    : Marp, Slides, Informatique, DEVOPS.
marp        : true
paginate    : true
theme       : jobs
mermaid     : true
footer      : "JLC - 4DOP1DR"

--- 
   
<!-- _class: titlepage -->

![bg left:33%](./img/devops-wallpaper.jpg)

<div class="title"         > 4DOP1DR - Théorie   </div>
<div class="subtitle"      > Introduction aux méthodes DevOps   </div>
<div class="author"        > JLC - Jonathan Lechien  </div>
<div class="date"          > Bruxelles, 2025      </div>
<div class="organization"  > Haute École Bruxelles-Brabant : Département des Sciences Informatiques    </div>

---        
     
# Objectifs pédagogiques

- Comprendre les *pratiques* clés du DevOps telles que **l’intégration continue**, le **déploiement continu** et l’automatisation des processus ;
- Utiliser les *outils* DevOps pour automatiser les tâches de **développement**, de **test**, de **déploiement** et de **surveillance**.


---

# Organisation de l'unité

<div class="columns">
<div>

## BIM3

- 2H par semaine de théorie
- 2H par semaine de laboratoire

</div>  
<div>    

## BIM4

- 4H par semaine de laboratoire

</div>    
</div> 

<div class="center">
<br>
Planning détaillé disponible sur PoEsi
</div>

--- 
 
<!-- _class: cite -->        

L'**évaluation** de l'unité repose sur un contrôle continu combinant un **QCM** pour 25% de la note et la **réalisation de scénarios pratiques** pour 75% de la note. 

---

# DevOps : Contexte et origine

<div class="columns">
<div>

<center>

![h:450](./img/dev-vs-ops.jpg)

</center>

</div>
<div>

## Problème
Manque de collaboration :
    - Le développement ajoute des nouvelles fonctionnalités.
    - Les opérations garantissent la stabilité du système.

## Solution 
Intégration des pratiques Agile et Lean.

</div>
</div>


--- 

# Historique du DevOps

- **2007-2008** : Naissance du concept lors d'une discussion sur les pratiques de collaboration entre développement et opérations.
- **2009** : Première conférence DevOpsDays organisée par Patrick Debois.
- **Années 2010** : Adoption croissante par les entreprises pour améliorer la livraison continue et la qualité des logiciels.
- **Aujourd'hui** : DevOps est un standard pour la gestion du cycle de vie des logiciels.

--- 
 
<!-- _class: cite -->        

DevOps est une **culture** et un ensemble de **pratiques** visant à améliorer la collaboration entre les équipes de développement (Dev) et des opérations (Ops).

---

# Principes Clés
- **Automatisation** des processus.
- **Amélioration continue** : **Intégration continue** (CI) et **Livraison continue** (CD).
- **Monitoring**.
- **Collaboration renforcée** entre équipes.


---
# DevOps : Cycle de vie

![h:450px](./img/cycle3.png)



---

# Outils populaires

<div class="columns">
<div>

### Planification et Collaboration
- **Jira**, **Trello**

### Développement
- **Git**, **SVN**

### Vérification du code
- **xUnit**, **Selenium**, **SonarQube**

### Package et release
- **Docker**

</div>

<div>

### Intégration et Livraison
- **Jenkins**, **Travis CI**,**GitLab CI/CD**

### Configuration et Orchestration
- **Ansible**, **Puppet**, **Terraform**, **Kubernetes**

### Monitoring
- **Prometheus**, **Grafana**
</div>

---        
     
# Matières

<div class="columns">
<div>
      
<!-- _class: cool-list -->

### Dev

1. *Docker et Docker-compose*
2. *Sonarqube*
3. *Gitlab CI/CD*
   
</div>  
<div>    

### Ops

5. *Terraform* 
6. *AWS/Azure/AlwaysData* 
7. *Prometheus*
 
</div>    
</div> 

---

<!-- _class: transition2 -->  

Conteneurisation avec Docker

--- 

<!-- _class: cite -->    

**Docker** est une plateforme qui permet de créer, déployer et exécuter des applications dans des conteneurs légers, portables et isolés. Ces **conteneurs** regroupent tout ce dont une application a besoin pour fonctionner garantissant qu'elle s'exécute de manière cohérente, quelle que soit l'environnement.

---
# Exemple : Tester Wordpress sous Ubuntu

<div class="columns">
<div>

## Installation native

[Description détaillée via ce lien](https://developer.wordpress.org/advanced-administration/before-install/)

1. Installer apache
1. Installer PHP
1. Installer mysql
1. Créer une base de données
1. Télécharger WordPress
1. Configurer Wordpress


</div>
<div>

## Installation Docker

1. Créer un fichier `docker-compose.yml`
1. Copier le contenu du fichier de [Docker Hub](https://hub.docker.com/_/wordpressl)
1. Démarrer Wordpress via `docker-compose up -d`

</div>
</div>

---
# Installation Native vs Docker

|               | Installation native | Via Docker |
|---------------|----------------------|--------------|
| Simplicité    | Complexe (packages, dépendances) | Très simple (une commande) |
| Isolation     | Nécessite configuration spécifique | Complètement isolé |
| Portabilité   | Dépend de l’OS et du package manager | Fonctionne partout |
| Maintenance   | Mise à jour manuelle | Facile avec les images Docker |


---

# Différences avec une Machine Virtuelle

| Critère         | Machine Virtuelle    | Docker |
|-----------------|----------------------|----------|
| Isolation       | Complète (OS dédié)  | Processus isolés |
| Poids           | Lourd (Giga Octets)  | Léger (Méga Octets) |
| Performance     | Moins performant     | Plus performant |
| Démarrage       | Lent (minutes)       | Rapide (secondes) |


--- 

# Architecture

<div class="columns">
<div>

<center>

![](./img/docker-architecture.png)

</center>

</div>
<div>

- **Docker Engine** : Composant central assurant l'exécution des conteneurs.
  - **Docker Client** : Interface en ligne de commande ou graphique permettant d’interagir avec Docker.
  - **Docker Daemon (dockerd)** : Service de fond qui gère les conteneurs, images et réseaux.
- **Docker Registry** : Stocke et distribue les images Docker (ex. Docker Hub, GitHub Container Registry).

</div>
</div>

---

# Installer Docker

<div class="columns">
<div>

## Linux

- Installer **Docker Engine**
- Configurer Docker en tant qu'utilisateur non-root
- [Lien vers Docker Engine](https://docs.docker.com/engine/install/)
- Installer **Docker Desktop** n'est pas obligatoire

</div>
<div>

## MacOS
- Installer **Docker Desktop**
- [Lien vers Docker Desktop](https://docs.docker.com/desktop/)

## Windows
- Activer **WSL 2**
- Installer **Docker Desktop**

</div>
</div>

---

# Docker Desktop

<div class="columns">
<div>

<center>

![h:350](./img/docker-desktop.png)


</center>

</div>
<div>

- Fournit une interface utilisateur pour gérer les conteneurs et images.
- Intègre le moteur Docker sur MacOS et Windows.
- Sur **Windows**, utilise **WSL 2** (ou Hyper-V si WSL 2 n'est pas activé).
- Sur **MacOS**, utilise un **hyperviseur léger** basé sur Apple Hypervisor Framework.
- Facilite l’accès aux registres Docker et aux extensions Docker.

</div>
</div>

---

# Registres Docker

<div class="columns">
<div>

<center>

![h:350](./img/docker-hub.png)


</center>

</div>
<div>

- Stockent et distribuent des **images Docker**
- Exemples : 
  - **Docker Hub** *(public)* : registre par défaut
  - GitHub Container Registry
  - AWS ECR, Azure ACR *(privés)*

</div>
</div>

---

# Images Docker

- Contiennent tout le nécessaire pour exécuter une application (code, runtime, dépendances...)
- Versionnées et partageables via des **registres**
- Création avec un **Dockerfile**
- Les images sont souvent versionnées avec des **tags** (ex. `postgres:15`, `postgres:latest`)
- `latest` pointe vers la version par défaut si aucun tag n’est spécifié.
- Téléchargeable via une commande du type `docker pull postgres:15`

---

# Informations sur l'image

Lister les images locales via `docker image ls`

```bash
REPOSITORY   TAG       IMAGE ID       CREATED        SIZE
postgres     15        19f99b135e18   2 months ago   426MB
```

[Informations complètes sur une image accessible via Docker Hub](https://hub.docker.com/_/postgres/) ou `docker image inspect postgres:15`

---

# Images Docker Officielles ✅

<div class="columns">
<div>

<center>

![h:350](./img/docker-official-jre.png)

</center>

</div>
<div>

- Maintenues par l’éditeur officiel ou la communauté Docker
- Sécurisées et mises à jour régulièrement
- Exemples : 
  - `postgres`
  - `nginx`
  - `node`
  - `python`
  - `java`

</div>
</div>

---

# Taille des images

- Une image Docker dépend entre autre de l’OS sous-jacent
- Par exemple les versions **Alpine** sont plus légères
- Alpine Linux est une distribution Linux ultra-légère


```bash
REPOSITORY   TAG         IMAGE ID       CREATED        SIZE
postgres     15-alpine   28223f2e117a   2 months ago   273MB
postgres     15          19f99b135e18   2 months ago   426MB
```

---

# Conteneurs

- Instances exécutables d’une **image Docker**.
- Isolés et légers.
- Peuvent être arrêtés, redémarrés, supprimés via leur nom ou leur ID.

```bash
docker run    python:latest
docker stop   keen_banach
docker start  keen_banach
docker rm     keen_banach
```

---

# Nommage des conteneurs

- Chaque conteneur peut être nommé pour une identification plus facile.
- Utilisation de `--name` lors du démarrage d’un conteneur :
```bash
docker run --name mon_postgres postgres:15
```
- Un conteneur nommé est plus facile à gérer pour les commandes comme `docker stop`

---

# Que se passe-t-il si aucun nom n’est attribué ?

- Docker génère automatiquement un nom aléatoire.
- Les noms sont composés de deux mots (ex: `eager_tesla`).
- Pour voir le nom généré :
```bash
docker ps
```
- Exemple de sortie :
```bash
CONTAINER ID   NAME          IMAGE        STATUS
f2d1a4f3c2f3  eager_tesla  postgres:15  Up 2 minutes
```
- Il est recommandé d’attribuer un nom explicite pour une meilleure gestion.

---

# Binding des ports

- Le binding des ports permet de rediriger un port de l’hôte vers un port du conteneur.
- Syntaxe : `-p <port_hôte>:<port_conteneur>`
- Exemple avec PostgreSQL :
```bash
docker run -p 5432:5432 postgres:15
```

- Pour voir les ports exposés :
```bash
docker ps
```

---

# Variables d’environnement dans les conteneurs

- Permettent de configurer des paramètres sans modifier l’image
- Exemples pour PostgreSQL :
  - `POSTGRES_USER` : Nom d’utilisateur par défaut
  - `POSTGRES_PASSWORD` : Mot de passe de l’utilisateur
  - `POSTGRES_DB` : Nom de la base de données par défaut

```bash
docker run \
  --name postgres \
  -e POSTGRES_USER=admin \
  -e POSTGRES_PASSWORD=secret \
  -e POSTGRES_DB=mydatabase \
  -p 5432:5432 \
  postgres:15
```

---

# Visualiser les logs d’un conteneur

- **Voir les logs en temps réel** :
```bash
docker logs -f <name>
```
- **Afficher les dernières lignes** :
```bash
docker logs --tail 100 <name>
```

---

# Exécuter une requête dans PostgreSQL

- Vérifier le nom du conteneur PostgreSQL :
```bash
docker ps
```
- Se connecter au conteneur et exécuter une requête SQL :
```bash
docker exec -it postgres psql -U admin -d mydatabase -c "SELECT NOW();"
```

---

# Dockerfile

- Fichier permettant de créer une **image Docker personnalisée**
    - **FROM** : Spécifie l’image de base
    - **ENV** : Définit des variables d’environnement
```dockerfile
FROM postgres:15
ENV POSTGRES_USER=myuser
ENV POSTGRES_PASSWORD=mypassword
ENV POSTGRES_DB=mydb
```

- Construire l’image :
```bash
docker build -t mon-postgres .
```

---

# Directives Dockerfile

<div class="columns">
<div>

- **RUN** : Exécute une commande lors de la construction de l’image
- **COPY** : Copie des fichiers depuis l’hôte vers l’image
- **WORKDIR** : Définit le répertoire de travail par défaut
- **EXPOSE** : Indique un port que le conteneur écoutera
- **CMD** : Définit une commande par défaut pour le conteneur

</div>
<div>

Exemple :
```dockerfile
FROM postgres:15
WORKDIR /app
COPY . /app
RUN apt-get update && apt-get install -y nano
ENV POSTGRES_USER=myuser
EXPOSE 5432
CMD ["postgres"]
```

</div>
</div>

---

# Remarque : spécifier la version dans FROM

- Toujours utiliser une version spécifique pour éviter des surprises

```dockerfile
FROM postgres:15
```

- Utiliser `latest` avec prudence !

---

# Image Layers et historique

- Une image est composée de plusieurs **layers** (couches)
- Couche consultable via `docker history <image>`

---

# Liens Layers-Dockerfile

```Dockerfile 
# Utilisation de l'image Ubuntu comme base
FROM ubuntu:24.04

# Mettre à jour les paquets et installer curl
RUN apt-get update && apt-get install -y curl

# Définir un message de bienvenue
CMD echo "Bienvenue dans votre premier conteneur Docker !"
```

```bash
IMAGE          CREATED          CREATED BY                                      SIZE      COMMENT
9ff3052babf9   38 seconds ago   CMD ["/bin/sh" "-c" "echo \"Bienvenue dans v…   0B        buildkit.dockerfile.v0
<missing>      38 seconds ago   RUN /bin/sh -c apt-get update && apt-get ins…   54.4MB    buildkit.dockerfile.v0
<missing>      8 days ago       /bin/sh -c #(nop)  CMD ["/bin/bash"]            0B        
<missing>      8 days ago       /bin/sh -c #(nop) ADD file:6df775300d76441aa…   78.1MB    
<missing>      8 days ago       /bin/sh -c #(nop)  LABEL org.opencontainers.…   0B        
<missing>      8 days ago       /bin/sh -c #(nop)  LABEL org.opencontainers.…   0B        
<missing>      8 days ago       /bin/sh -c #(nop)  ARG LAUNCHPAD_BUILD_ARCH     0B        
<missing>      8 days ago       /bin/sh -c #(nop)  ARG RELEASE                  0B        
```

---
# Image classique : Single-Stage - Partie 1

```dockerfile
# Utilisation d'une image contenant Maven et JDK 17
FROM maven:3.9-eclipse-temurin-17

# Définition du répertoire de travail
WORKDIR /app

# Copier les fichiers du projet dans le conteneur
COPY pom.xml .
COPY src ./src
```
---
# Image classique : Single-Stage - Partie 2

```dockerfile
# Compiler l'application
RUN mvn clean package -DskipTests

# Exposer le port utilisé par l'application
EXPOSE 8080

# Démarrer l'application
CMD ["java", "-jar", "target/app.jar"]
```

---

# Image avancée : Multi-Stage Build - Partie 1 

```dockerfile
# Étape 1 : Construction de l'application avec Maven
FROM maven:3.9-eclipse-temurin-17 AS builder

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers du projet dans le conteneur
COPY pom.xml .
COPY src ./src

# Télécharger les dépendances et compiler l'application
RUN mvn clean package -DskipTests
```

---

# Image avancée : Multi-Stage Build - Partie 2

```dockerfile
# Étape 2 : Création d'une image légère pour l'exécution
FROM eclipse-temurin:17-jre

# Définir le répertoire de travail
WORKDIR /app

# Copier uniquement le JAR compilé depuis l'étape précédente
COPY --from=builder /app/target/*.jar app.jar

# Exposer le port utilisé par l'application
EXPOSE 8080

# Lancer l'application
CMD ["java", "-jar", "app.jar"]
```
---

# Comparaison Single Stage - Multi Stage

| Critère            | Single-Stage                         | Multi-Stage                         |
|--------------------|----------------------------------|----------------------------------|
| **Taille de l’image** | Plus lourde (Maven et JDK inclus) | Plus légère (seulement JRE et JAR) |
| **Performance**    | Démarrage légèrement plus lent  | Plus rapide car optimisé         |
| **Sécurité**       | Maven et outils de build inutiles en production | Pas d'outils de build dans l’image finale |

```bash
REPOSITORY           TAG       IMAGE ID       CREATED          SIZE
image-multi-stage    latest    fcc6267ba8f7   4 seconds ago    283MB
image-single-stage   latest    4068a159c3d2   36 seconds ago   599MB
```

---
<!-- _class: transition2 -->  

Docker-compose

--- 

<!--
- application microservices
- kubernetes
-->  

---

<div>         
 
![h:450px](./img/work-in-progress.jpeg)
   
</div> 

---
<!-- _class: transition2 -->  

Analyse de la qualité du code<br>
Sonarqube

--- 

<div>         
 
![h:450px](./img/work-in-progress.jpeg)
   
</div> 


---
<!-- _class: transition2 -->  

Définition d'un pipeline<br>
GitlabCI/CD

--- 

<div>         
 
![h:450px](./img/work-in-progress.jpeg)
   
</div> 

---
<!-- _class: transition2 -->  

Gérer l'infrastructure<br>
Terraform

--- 

<div>         
 
![h:450px](./img/work-in-progress.jpeg)
   
</div> 

---
<!-- _class: transition2 -->  

Le monitoring<br>
Prometheus

--- 

<div>         
 
![h:450px](./img/work-in-progress.jpeg)
   
</div> 