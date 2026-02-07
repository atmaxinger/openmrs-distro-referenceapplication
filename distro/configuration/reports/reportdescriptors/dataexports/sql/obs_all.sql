SELECT 
    o.obs_id,
    pi.identifier AS patient_identifier,
    pn.given_name AS patient_given_name,
    pn.family_name AS patient_family_name,
    c.uuid AS concept_id,
    cn.name AS concept_name,
    o.value_numeric,
    o.value_text,
    o.value_coded,
    cvn.name AS value_coded_name,          -- NEW: readable name for coded value
    o.value_datetime,
    o.obs_datetime,
    o.date_created,
    o.comments,
    prov.name AS provider_name   -- NEW: provider name
FROM 
    obs o
INNER JOIN 
    person pe ON o.person_id = pe.person_id
INNER JOIN 
    person_name pn ON pe.person_id = pn.person_id 
                  AND pn.preferred = 1 
                  AND pn.voided = 0
INNER JOIN 
    patient pa ON pe.person_id = pa.patient_id 
              AND pa.voided = 0
LEFT JOIN 
    patient_identifier pi ON pa.patient_id = pi.patient_id 
                         AND pi.preferred = 1 
                         AND pi.voided = 0
INNER JOIN 
    concept c ON o.concept_id = c.concept_id
INNER JOIN 
    concept_name cn ON c.concept_id = cn.concept_id 
                   AND cn.locale = 'en' 
                   AND cn.concept_name_type = 'FULLY_SPECIFIED' 
                   AND cn.voided = 0

-- NEW: Join for value_coded name (LEFT because value_coded can be NULL)
LEFT JOIN 
    concept_name cvn ON o.value_coded = cvn.concept_id 
                    AND cvn.locale = 'en' 
                    AND cvn.concept_name_type = 'FULLY_SPECIFIED' 
                    AND cvn.voided = 0

-- NEW: Join path to get the provider who recorded the obs via encounter
LEFT JOIN 
    encounter e ON o.encounter_id = e.encounter_id 
               AND e.voided = 0
LEFT JOIN 
    encounter_provider ep ON e.encounter_id = ep.encounter_id 
                         AND ep.voided = 0
LEFT JOIN 
    provider prov ON ep.provider_id = prov.provider_id 
                 AND prov.retired = 0
WHERE 
    o.voided = 0
    AND (@dateFrom IS NULL
	  OR o.obs_datetime >= @dateFrom)
    AND (@dateTo IS NULL
          OR o.obs_datetime <= @dateTo)
    AND ( @patientID IS NULL 
          OR pa.patient_id = @patientID) 
    AND ( @conceptID IS NULL 
          OR cn.concept_id = @conceptID )
ORDER BY 
    o.obs_datetime DESC;
