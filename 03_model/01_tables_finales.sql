/* ============================================================
   Projet RNCP – Bloc 6
   MVP – Aide à la décision territoriale (Mobilité / TàD)

   Objectifs :
   - Recréer l’état final de la base de données
   - Schéma volontairement non optimisé (MVP)
   - Logique métier validée avec 2 scores distincts
   - Base destinée à l’analyse et à la dataviz

   Auteur : Justine VILLENEUVE
   ============================================================ */


/* ============================================================
   DROP TABLES (reproductibilité complète)
   ============================================================ */

DROP TABLE IF EXISTS public.communes_indicateurs_mobilite CASCADE;
DROP TABLE IF EXISTS public.star_freq_details CASCADE;
DROP TABLE IF EXISTS public.star_gtfs CASCADE;
DROP TABLE IF EXISTS public.star_id CASCADE;
DROP TABLE IF EXISTS public.star_arrets CASCADE;
DROP TABLE IF EXISTS public.star_lignes CASCADE;
DROP TABLE IF EXISTS public.covoit_aires CASCADE;
DROP TABLE IF EXISTS public.gouv_voitures CASCADE;
DROP TABLE IF EXISTS public.gouv_revenus CASCADE;
DROP TABLE IF EXISTS public.gouv_ages_tranches CASCADE;
DROP TABLE IF EXISTS public.gouv_communes CASCADE;


/* ============================================================
   TABLES DE RÉFÉRENCE – GÉOGRAPHIE & SOCIO-DÉMO
   ============================================================ */

CREATE TABLE IF NOT EXISTS public.gouv_communes
(
    code_geo integer PRIMARY KEY,
    nom_commune character varying(50) NOT NULL,
    codes_postaux character varying(100) NOT NULL,
    canton_code integer NOT NULL,
    canton_nom character varying(50) NOT NULL,
    superficie_hectare integer,
    superficie_km2 integer NOT NULL,
    latitude_centre double precision NOT NULL,
    longitude_centre double precision NOT NULL
);

CREATE TABLE IF NOT EXISTS public.gouv_ages_tranches
(
    code_geo integer PRIMARY KEY,
    age_0_10 integer,
    age_11_17 integer,
    age_18_24 integer,
    age_25_39 integer,
    age_40_54 integer,
    age_55_64 integer,
    age_65_79 integer,
    age_80_max integer,
    pop_total integer GENERATED ALWAYS AS
    (
        age_0_10 + age_11_17 + age_18_24 + age_25_39 +
        age_40_54 + age_55_64 + age_65_79 + age_80_max
    ) STORED
);

CREATE TABLE IF NOT EXISTS public.gouv_revenus
(
    code_geo integer PRIMARY KEY,
    nom_commune character varying(50) NOT NULL,
    rev_median integer NOT NULL,
    rev_type character varying(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS public.gouv_voitures
(
    code_geo integer PRIMARY KEY,
    taux_motorisation double precision
);


/* ============================================================
   TRANSPORT – INFRASTRUCTURES & OFFRE
   ============================================================ */

CREATE TABLE IF NOT EXISTS public.star_lignes
(
    id_ligne integer PRIMARY KEY,
    nom_ligne character varying(50) NOT NULL,
    famille_ligne character varying(50) NOT NULL,
    description_famille text,
    continuite_service character varying(30),
    regulier_ponctuel character varying(20)
);

CREATE TABLE IF NOT EXISTS public.star_arrets
(
    id_arret integer PRIMARY KEY,
    nom_arret character varying(100),
    code_geo integer,
    latitude double precision,
    longitude double precision,
    tco_type character varying(10),
    CONSTRAINT star_arrets_code_geo_fk
        FOREIGN KEY (code_geo) REFERENCES public.gouv_communes (code_geo)
);

CREATE TABLE IF NOT EXISTS public.star_id
(
    id_ligne integer NOT NULL,
    id_arret integer NOT NULL,
    PRIMARY KEY (id_ligne, id_arret),
    CONSTRAINT star_id_ligne_fk
        FOREIGN KEY (id_ligne) REFERENCES public.star_lignes (id_ligne),
    CONSTRAINT star_id_arret_fk
        FOREIGN KEY (id_arret) REFERENCES public.star_arrets (id_arret)
);

CREATE TABLE IF NOT EXISTS public.star_gtfs
(
    id_ligne integer,
    id_arret integer,
    stop_name character varying(50),
    day_type character varying(20),
    first_passage interval,
    last_passage interval,
    avg_passage_per_day numeric(6,2),
    early_birds numeric(6,2),
    morning_commute numeric(6,2),
    late_morning numeric(6,2),
    lunch_time numeric(6,2),
    afternoon numeric(6,2),
    evening_commute numeric(6,2),
    evening numeric(6,2),
    night numeric(6,2),
    amplitude_horaire interval,
    amplitude_horaire_heures numeric(6,2),
    avg_passage_per_hour double precision,
    CONSTRAINT star_gtfs_ligne_fk
        FOREIGN KEY (id_ligne) REFERENCES public.star_lignes (id_ligne),
    CONSTRAINT star_gtfs_arret_fk
        FOREIGN KEY (id_arret) REFERENCES public.star_arrets (id_arret)
);

CREATE TABLE IF NOT EXISTS public.star_freq_details
(
    date date,
    tranche_horaire time,
    id_arret integer,
    nom_commune character varying(50),
    id_ligne integer,
    sens character varying(30),
    freq double precision,
    code_geo integer,
    CONSTRAINT star_freq_arret_fk
        FOREIGN KEY (id_arret) REFERENCES public.star_arrets (id_arret),
    CONSTRAINT star_freq_ligne_fk
        FOREIGN KEY (id_ligne) REFERENCES public.star_lignes (id_ligne)
);

CREATE TABLE IF NOT EXISTS public.covoit_aires
(
    covoit_id character varying(50) PRIMARY KEY,
    code_geo integer,
    nom text,
    places integer,
    commentaire text,
    latitude double precision NOT NULL,
    longitude double precision NOT NULL,
    CONSTRAINT covoit_aires_code_geo_fk
        FOREIGN KEY (code_geo) REFERENCES public.gouv_communes (code_geo)
);


/* ============================================================
   TABLE FINALE – INDICATEURS & SCORES (DATAVIZ)
   ============================================================ */

CREATE TABLE IF NOT EXISTS public.communes_indicateurs_mobilite
(
    code_geo integer PRIMARY KEY,

    -- Socio-économie
    rev_median double precision,
    rev_type character varying(30),
    taux_motorisation double precision,

    -- Démographie & surface
    superficie_km2 numeric(10,2),
    pop_total numeric(10,0),
    pop_densite double precision GENERATED ALWAYS AS
        (pop_total / superficie_km2) STORED,

    -- Mobilité & offre
    count_covoit_id integer,
    count_id_arret integer,
    arret_densite_km2 double precision,
    arret_densite_1000hab double precision,
    count_id_ligne integer,
    count_tco_type integer,
    part_passages_lignes_regulieres double precision,
    count_famille_ligne integer,
    part_service_continu double precision,
    freq_jour_reg double precision,

    -- Scores
    score_demande double precision,
    score_offre_service double precision,
    ratio_frequentation_norm double precision,
    score_potentiel_tad double precision,
    score_potentiel_tad_ajuste double precision,

    -- Confort dataviz
    nom_commune character varying(50),
    frequentation_relative_reg_continu double precision
);
