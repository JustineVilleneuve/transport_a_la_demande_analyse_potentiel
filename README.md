# Transport à la demande – Analyse de potentiel territorial

## Objectif du projet

Ce projet vise à analyser le potentiel de déploiement du **transport à la demande (TAD)** en périphérie de Rennes.  
Il s’inscrit dans une démarche d’**aide à la décision territoriale**, en croisant des données socio-économiques, démographiques et d’offre de transport collectif.

L’objectif est d’identifier :
- les communes présentant un **besoin potentiel de TAD**,
- les **déséquilibres entre offre et demande de mobilité**,
- les leviers d’optimisation de l’offre existante.

Ce travail constitue le livrable principal du **Bloc 6 de la certification RNCP**, et est conçu comme un **MVP scalable**, avec des choix de modélisation volontairement explicites et assumés.

## Structure du dépôt

Les données présentes dans le dépôt sont **des échantillons ou données intermédiaires**, destinées à illustrer la démarche et à permettre la reproductibilité des traitements.

## Outils utilisés

- **Python**
  - pandas : nettoyage, agrégation et préparation des données
- **PostgreSQL / pgAdmin**
  - modélisation relationnelle
  - calcul des indicateurs
  - création de vues analytiques
- **SQL**
  - jointures multi-sources
  - normalisation d’indicateurs
  - calcul de scores composites
- **Git & GitHub**
  - versioning
  - livrable du projet RNCP
 
## Ce que j’ai appris

Ce projet m’a permis de consolider plusieurs compétences clés en data analyse et modélisation :

- Structurer un projet data de bout en bout, depuis les données sources jusqu’à une table finale exploitable en dataviz
- Concevoir un **schéma SQL orienté MVP**, en assumant des compromis entre normalisation, lisibilité et performance
- Mettre en place des **indicateurs composites** à partir de données hétérogènes
- Normaliser des variables pour les rendre comparables et interprétables
- Séparer clairement :
  - les **calculs métier** (via des vues SQL)
  - la **persistance des résultats** (via des tables finales)
- Documenter et justifier des choix techniques dans une logique de **scalabilité future**

## 🚧 État du projet

Le projet est actuellement **en cours de construction (WIP)**.

À ce stade :
- le schéma final est stabilisé pour le MVP,
- les indicateurs et scores sont calculés et documentés,
- la base est prête pour une exploitation en dataviz.

Les prochaines étapes incluront :
- une analyse détaillée des résultats,
- une interprétation territoriale des scores,
- des pistes d’optimisation du modèle pour un déploiement à plus grande échelle.
