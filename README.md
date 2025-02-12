# 4dop1dr-theorie

Ce dépôt contient les supports de l'activité *4DOP1TDR* : **Introduction aux pratiques DevOps : théorie**.

## URL de publication

Le résultat de ce projet est disponible en ligne sur : https://esibru.github.io/4dop1dr-theorie

## Inspiration

Les styles des présentations sont repris du dépôt :  https://github.com/cunhapaulo/marpstyle

La structure du projet et la configuration de *Github Actions* pour le déploiement automatique sont inspirées de https://github.com/codebytes/marp-slides-template/blob/main/.github/workflows/marp-pages.yml

## Génération des supports

- Installer l'extension marp dans VSCode : https://marp.app/
- Ouvrir le dossier `4DOP1DR-theorie` avec VSCode
  - le dossier contient les variables de configurations de marp via le fichier `.vscode/settings.json`
  - modifier les variables du `.vscode.settings.json` pour activer un thème

- Ouvrir au sein de VSCode le fichier markdown `Slide.md`
- Dans VSCode les boutons utiles sont : 
  - `Open Preview` : pour visualiser la preview
  - `Show Quick Pick of Marp Command` : pour exporter le résultat au format html ou pdf
- Pour consulter en direct le résultat :
    - utiliser le bouton `Open Preview`  de VsCode
    - lancer à la racine du projet la commande `npx @marp-team/marp-cli --server ./slides`
