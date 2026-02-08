SELECT 
    pi.identifier AS patient_identifier,
    pn.given_name AS patient_given_name,
    pn.family_name AS patient_family_name,
    c.uuid AS concept_uuid,               -- or c.concept_id if you prefer numeric ID
    cn.name AS concept_name,
    
    -- Most recent values (from the latest obs for this patient + concept)
    latest.value_numeric,
    latest.value_text,
    latest.value_coded,
    cvn.name AS value_coded_name,
    latest.value_datetime,
    
    -- Key metadata from the most recent obs
    latest.obs_datetime AS last_obs_datetime,
    latest.date_created AS last_obs_date_created,
    latest.comments,
    prov.name AS provider_name            -- provider who recorded the latest obs

FROM 
    patient pa
INNER JOIN 
    person pe ON pa.patient_id = pe.person_id
INNER JOIN 
    person_name pn ON pe.person_id = pn.person_id 
                  AND pn.preferred = 1 
                  AND pn.voided = 0
LEFT JOIN 
    patient_identifier pi ON pa.patient_id = pi.patient_id 
                         AND pi.preferred = 1 
                         AND pi.voided = 0

-- Cross join with the concepts that actually have data in the filtered period
-- (this ensures we only get concepts that were observed)
INNER JOIN (
    SELECT DISTINCT o.person_id, o.concept_id
    FROM obs o
    WHERE o.voided = 0
      AND (@dateFrom IS NULL OR o.obs_datetime >= @dateFrom)
      AND (@dateTo   IS NULL OR o.obs_datetime <= @dateTo)
      AND (@conceptID IS NULL OR o.concept_id = @conceptID)
) has_obs ON has_obs.person_id = pa.patient_id

INNER JOIN concept c ON has_obs.concept_id = c.concept_id
INNER JOIN concept_name cn ON c.concept_id = cn.concept_id 
                          AND cn.locale = 'en' 
                          AND cn.concept_name_type = 'FULLY_SPECIFIED' 
                          AND cn.voided = 0

-- Subquery to get only the latest obs per patient per concept
INNER JOIN (
    SELECT 
        o.person_id,
        o.concept_id,
        o.obs_id,
        o.value_numeric,
        o.value_text,
        o.value_coded,
        o.value_datetime,
        o.obs_datetime,
        o.date_created,
        o.comments,
        o.encounter_id,
        ROW_NUMBER() OVER (
            PARTITION BY o.person_id, o.concept_id 
            ORDER BY o.obs_datetime DESC, o.date_created DESC, o.obs_id DESC
        ) AS rn
    FROM obs o
    WHERE o.voided = 0
      AND (@dateFrom IS NULL OR o.obs_datetime >= @dateFrom)
      AND (@dateTo   IS NULL OR o.obs_datetime <= @dateTo)
      -- AND (@conceptID IS NULL OR o.concept_id = @conceptID)   -- already filtered above, but can keep
) latest ON latest.person_id = pa.patient_id 
        AND latest.concept_id = c.concept_id
        AND latest.rn = 1   -- only the most recent row

-- Value coded name (for the latest obs)
LEFT JOIN concept_name cvn ON latest.value_coded = cvn.concept_id 
                          AND cvn.locale = 'en' 
                          AND cvn.concept_name_type = 'FULLY_SPECIFIED' 
                          AND cvn.voided = 0

-- Provider from the latest encounter/obs
LEFT JOIN encounter e ON latest.encounter_id = e.encounter_id 
                     AND e.voided = 0
LEFT JOIN encounter_provider ep ON e.encounter_id = ep.encounter_id 
                               AND ep.voided = 0
LEFT JOIN provider prov ON ep.provider_id = prov.provider_id 
                       AND prov.retired = 0

WHERE 
    pa.voided = 0
    AND (@patientID IS NULL OR pa.patient_id = @patientID)

ORDER BY 
    patient_identifier,
    cn.name;
