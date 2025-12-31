/* ============================================================
   Injection du score de demande (version 1)
   ============================================================ */

UPDATE communes_indicateurs_mobilite cim
SET score_demande = v.score_demande
FROM v_score_demande v
WHERE cim.code_geo = v.code_geo;


/* ============================================================
   Injection du score d'offre de service
   ============================================================ */

UPDATE communes_indicateurs_mobilite cim
SET score_offre_service = v.score_offre_service
FROM v_score_offre_service v
WHERE cim.code_geo = v.code_geo;


/* ============================================================
   Injection du score potentiel TAD (version standard)
   ============================================================ */

UPDATE communes_indicateurs_mobilite cim
SET score_potentiel_tad = v.score_potentiel_tad
FROM v_score_potentiel_tad v
WHERE cim.code_geo = v.code_geo;


/* ============================================================
   Injection du score potentiel TAD ajusté (avec fréquentation)
   ============================================================ */

UPDATE communes_indicateurs_mobilite cim
SET score_potentiel_tad_ajuste = v.score_potentiel_tad_ajuste
FROM v_score_potentiel_tad_ajuste v
WHERE cim.code_geo = v.code_geo;


/* ============================================================
   Vérification
   ============================================================ */

-- Vérification post-injection
SELECT
    code_geo,
    score_demande,
    score_offre_service,
    score_potentiel_tad,
    score_potentiel_tad_ajuste
FROM communes_indicateurs_mobilite
ORDER BY code_geo
LIMIT 10;
