SELECT 
    o.obs_id,
    pi.identifier AS patient_identifier,
    pn.given_name AS patient_given_name,
    pn.family_name AS patient_family_name,
    cn.name AS concept_name,
    o.value_numeric,
    o.value_text,
    o.value_coded,
    o.value_datetime,
    o.obs_datetime,
    o.date_created,
    o.comments
FROM 
    obs o
INNER JOIN 
    person pe ON o.person_id = pe.person_id
INNER JOIN 
    person_name pn ON pe.person_id = pn.person_id AND pn.preferred = 1 AND pn.voided = 0
INNER JOIN 
    patient pa ON pe.person_id = pa.patient_id AND pa.voided = 0
LEFT JOIN 
    patient_identifier pi ON pa.patient_id = pi.patient_id AND pi.preferred = 1 AND pi.voided = 0
INNER JOIN 
    concept c ON o.concept_id = c.concept_id
INNER JOIN 
    concept_name cn ON c.concept_id = cn.concept_id AND cn.locale = 'en' AND cn.concept_name_type = 'FULLY_SPECIFIED' AND cn.voided = 0
WHERE 
    o.voided = 0
    AND o.obs_datetime >= :dateFrom
    AND o.obs_datetime <= :dateTo
    AND ( :patientSearch = '' OR pn.given_name LIKE CONCAT('%', :patientSearch, '%') OR pn.family_name LIKE CONCAT('%', :patientSearch, '%') OR pn.middle_name LIKE CONCAT('%', :patientSearch, '%') )
    AND ( :conceptSearch = '' OR cn.name LIKE CONCAT('%', :conceptSearch, '%') )
    AND ( :valueFrom IS NULL OR o.value_numeric >= :valueFrom )
    AND ( :valueTo IS NULL OR o.value_numeric <= :valueTo )
    AND ( :valueFrom IS NOT NULL OR :valueTo IS NOT NULL )  -- Ensures value range is applied only if provided; remove if always filtering numerics
ORDER BY 
    o.obs_datetime DESC;
