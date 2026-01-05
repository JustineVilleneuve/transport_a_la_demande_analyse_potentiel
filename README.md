# Transport à la demande – Analyse de potentiel territorial

## Objectif du projet

Ce projet vise à analyser le potentiel de déploiement du **transport à la demande (TAD)** en périphérie de Rennes.  
Il s’inscrit dans une démarche d’**aide à la décision territoriale**, en croisant des données socio-économiques, démographiques et d’offre de transport collectif.

L’objectif est de :
- identifier les **communes prioritaires** pour un déploiement de TAD,
- qualifier les **déséquilibres entre offre existante, besoins de la population et usage réel**,
- fournir aux équipes métiers des **indicateurs et scores directement exploitables** pour orienter les études et décisions opérationnelles.

Ce travail constitue le livrable principal du **Bloc 6 de la certification RNCP**.  
Il est conçu comme un **MVP scalable**, avec des choix de modélisation volontairement assumés et documentés.

## Périmètre d’analyse

- **42 communes** en périphérie de Rennes  
- Environ **240 000 habitants**
- Réseau STAR :
  - **168 lignes de bus**
  - **1 ligne de métro**
- Données de fréquentation couvrant **une année complète** (sept. 2024 – août 2025)

## Structure du dépôt

Les données présentes dans le dépôt sont **des échantillons ou données intermédiaires**, destinées à illustrer la démarche et à permettre la reproductibilité des traitements.


## Pipeline & architecture data

Le projet repose sur un pipeline **ETL classique**, orienté analyse et restitution métier :

**Sources**  
- Réseau STAR : arrêts, lignes, fréquence de passage, fréquentation réelle  
- INSEE / data.gouv : revenus médians, taux de motorisation, données démographiques  

**Traitements**  
- Extraction et transformation via **Python (pandas)**  
- Stockage et modélisation dans **PostgreSQL**  

**Restitution**  
- Calcul des indicateurs et scores en SQL  
- Visualisation et exploration via **Power BI**


## Analyse & livrables métiers

L’analyse aboutit à la production de **scores et KPIs directement actionnables**, livrés via un rapport Power BI.

Le livrable permet aux équipes métiers de répondre à trois questions clés :

### Où agir ?
- Identification des **communes à fort, moyen ou faible potentiel de TAD**
- Classement basé sur un **score composite de potentiel**

### Pourquoi ces communes ?
- Décomposition du score en :
  - score d’offre de service,
  - score de besoin (profil socio-économique),
  - niveau d’utilisation réelle du réseau existant
- Lecture détaillée des indicateurs clés par commune

### Comment préparer le déploiement ?
- Analyse fine de la fréquentation par :
  - tranche horaire,
  - période,
  - type de ligne
- Indicateurs locaux pour orienter :
  - le type de service à envisager,
  - les plages horaires pertinentes,
  - les zones à investiguer plus finement

L’objectif est de proposer un **outil d’aide à la décision**, et non une décision automatisée.


## Outils utilisés

- **Python**
  - pandas : nettoyage, agrégation, préparation des données
- **PostgreSQL / pgAdmin**
  - modélisation relationnelle
  - calcul des indicateurs
  - vues analytiques SQL
- **SQL**
  - jointures multi-sources
  - normalisation d’indicateurs
  - calcul de scores composites
- **Power BI**
  - exploration des résultats
  - restitution métier
- **Git & GitHub**
  - versioning
  - livrable du projet RNCP


## Ce que j’ai appris

Ce projet m’a permis de consolider des compétences clés en data analyse et modélisation :

- Structurer un projet data **de bout en bout**, des sources à la restitution métier
- Concevoir un **schéma SQL orienté MVP**, en assumant des compromis entre normalisation, lisibilité et performance
- Mettre en place des **scores composites** à partir de données hétérogènes
- Normaliser et pondérer des indicateurs pour les rendre comparables et interprétables
- Traduire une problématique métier en **indicateurs opérationnels**
- Documenter les choix techniques dans une logique de **scalabilité et d’industrialisation future**


## 🚧 État du projet

Le projet est actuellement **terminé dans sa version MVP**.

- Pipeline complet implémenté
- Modèle stabilisé
- Scores et KPIs calculés
- Rapport Power BI livré
- Documentation et présentation finalisées

Les prochaines étapes incluront des pistes d’optimisation du modèle pour un déploiement à plus grande échelle.

## Remerciements

Merci à mes acolytes Amanda Velez et Tanguy Borucki !
