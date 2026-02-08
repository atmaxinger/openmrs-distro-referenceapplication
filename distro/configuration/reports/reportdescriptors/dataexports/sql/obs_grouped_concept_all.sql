SELECT 
    pi.identifier AS patient_identifier,
    pn.given_name AS patient_given_name,
    pn.family_name AS patient_family_name,
    
    c.uuid AS concept_uuid,               
    cn.name AS concept_name,
    cdt.name AS concept_datatype,          -- Numeric, Text, Coded, Datetime, Date, Boolean, ...
    cc.name AS concept_class,              -- ← NEW: Finding, Diagnosis, Symptom, LabSet, Drug, Test, Procedure, etc.

    -- Most recent values
    latest.value_numeric,
    REPLACE(REPLACE(REPLACE(REPLACE(latest.value_text,
        CHAR(13) + CHAR(10), ' '),    -- CRLF
        CHAR(10), ' '),               -- LF
        CHAR(13), ' '),               -- lone CR
        CHAR(9), ' ')                 AS value_text,              
    latest.value_coded,
    cvn.name AS value_coded_name,
    
    -- Split value_datetime (useful when concept_datatype is Date / Datetime / Time)
    CAST(latest.value_datetime AS DATE)     AS value_date,
    CAST(latest.value_datetime AS TIME)     AS value_time,
    latest.value_datetime,                  -- kept original for convenience

    -- Key metadata — split into date + time
    CAST(latest.obs_datetime AS DATE)       AS last_obs_date,
    CAST(latest.obs_datetime AS TIME)       AS last_obs_time,
    latest.obs_datetime                     AS last_obs_datetime,  -- original

    CAST(latest.date_created AS DATE)       AS last_obs_created_date,
    CAST(latest.date_created AS TIME)       AS last_obs_created_time,
    latest.date_created                     AS last_obs_date_created,  -- original

    latest.comments,
    prov.name AS provider_name,
    prov.identifier AS provider_identifier

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

-- Datatype
INNER JOIN concept_datatype cdt ON c.datatype_id = cdt.concept_datatype_id

-- ← NEW: Concept Class join
INNER JOIN concept_class cc ON cc.concept_class_id = c.class_id

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
) latest ON latest.person_id = pa.patient_id 
        AND latest.concept_id = c.concept_id
        AND latest.rn = 1

LEFT JOIN concept_name cvn ON latest.value_coded = cvn.concept_id 
                          AND cvn.locale = 'en' 
                          AND cvn.concept_name_type = 'FULLY_SPECIFIED' 
                          AND cvn.voided = 0

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
