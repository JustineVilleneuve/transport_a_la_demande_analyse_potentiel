/* ============================================================
   
   Vues de calcul des indicateurs normalisés et des scores
   
   ============================================================ */


/* ============================================================
   Score de demande (version 1)
   ============================================================ */

CREATE OR REPLACE VIEW v_score_demande AS
WITH norm AS (
    SELECT
        code_geo,

        (rev_median - MIN(rev_median) OVER ())
        / NULLIF(MAX(rev_median) OVER () - MIN(rev_median) OVER (), 0)
        AS rev_median_norm,

        (taux_motorisation - MIN(taux_motorisation) OVER ())
        / NULLIF(MAX(taux_motorisation) OVER () - MIN(taux_motorisation) OVER (), 0)
        AS taux_motorisation_norm

    FROM communes_indicateurs_mobilite
)
SELECT
    code_geo,
    0.6 * rev_median_norm
  + 0.4 * taux_motorisation_norm
    AS score_demande
FROM norm;


/* ============================================================
   Score de demande (version 2, avec fréquentation)
   ============================================================ */

CREATE OR REPLACE VIEW v_score_demande_2 AS
WITH norm AS (
    SELECT
        code_geo,

        (rev_median - MIN(rev_median) OVER ())
        / NULLIF(MAX(rev_median) OVER () - MIN(rev_median) OVER (), 0)
        AS rev_median_norm,

        (taux_motorisation - MIN(taux_motorisation) OVER ())
        / NULLIF(MAX(taux_motorisation) OVER () - MIN(taux_motorisation) OVER (), 0)
        AS taux_motorisation_norm,

        ratio_frequentation_norm

    FROM communes_indicateurs_mobilite
)
SELECT
    code_geo,
    0.3 * rev_median_norm
  + 0.2 * taux_motorisation_norm
  + 0.5 * ratio_frequentation_norm
    AS score_demande_2
FROM norm;


/* ============================================================
   Normalisation des composantes de l’offre de service
   ============================================================ */

CREATE OR REPLACE VIEW v_norm_offre_service AS
WITH stats AS (
    SELECT
        MIN(arret_densite_km2) AS min_arrets,
        MAX(arret_densite_km2) AS max_arrets,
        MIN(count_tco_type)    AS min_modes,
        MAX(count_tco_type)    AS max_modes,
        MIN(freq_jour_reg)     AS min_freq,
        MAX(freq_jour_reg)     AS max_freq
    FROM communes_indicateurs_mobilite
)
SELECT
    c.code_geo,

    1 - c.part_service_continu
        AS part_service_continu_norm,

    1 - (
        (c.arret_densite_km2 - s.min_arrets)
        / NULLIF(s.max_arrets - s.min_arrets, 0)
    ) AS arret_densite_norm,

    1 - (
        (c.count_tco_type - s.min_modes)
        / NULLIF(s.max_modes - s.min_modes, 0)
    ) AS count_tco_type_norm,

    1 - (
        (c.freq_jour_reg - s.min_freq)
        / NULLIF(s.max_freq - s.min_freq, 0)
    ) AS freq_jour_reg_norm,

    1 - c.part_passages_lignes_regulieres
        AS part_passages_lignes_reg_norm

FROM communes_indicateurs_mobilite c
CROSS JOIN stats s;


/* ============================================================
   Score d’offre de service
   ============================================================ */

CREATE OR REPLACE VIEW v_score_offre_service AS
SELECT
    code_geo,

    0.33 * arret_densite_norm
  + 0.18 * count_tco_type_norm
  + 0.24 * freq_jour_reg_norm
  + 0.10 * part_passages_lignes_reg_norm
  + 0.15 * part_service_continu_norm
    AS score_offre_service

FROM v_norm_offre_service;


/* ============================================================
   Score potentiel TAD (version standard)
   ============================================================ */

CREATE OR REPLACE VIEW v_score_potentiel_tad AS
SELECT
    o.code_geo,
    0.6 * o.score_offre_service
  + 0.4 * d.score_demande
    AS score_potentiel_tad
FROM v_score_offre_service o
JOIN v_score_demande d USING (code_geo);


/* ============================================================
   Score potentiel TAD ajusté (fréquentation intégrée)
   ============================================================ */

CREATE OR REPLACE VIEW v_score_potentiel_tad_ajuste AS
SELECT
    c.code_geo,

    0.55 * o.score_offre_service
  + 0.35 * d.score_demande
  + 0.10 * c.ratio_frequentation_norm
    AS score_potentiel_tad_ajuste

FROM communes_indicateurs_mobilite c
JOIN v_score_offre_service o USING (code_geo)
JOIN v_score_demande d USING (code_geo);
