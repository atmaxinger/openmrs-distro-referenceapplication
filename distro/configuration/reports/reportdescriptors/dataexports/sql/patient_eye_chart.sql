SELECT
  pi.identifier AS patient_id,
  
(SELECT COALESCE(o.value_numeric, o.value_text) FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-T-004-R'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS sph_od_ar,
  
(SELECT COALESCE(o.value_numeric, o.value_text) FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-T-005-R'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS cyl_od_ar,
  
(SELECT COALESCE(o.value_numeric, o.value_text) FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-T-006-R'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS axis_od_ar,
  
(SELECT o.value_text FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-T-007-R'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS va_cc_od_ar,
  
(SELECT COALESCE(o.value_numeric, o.value_text) FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-T-004-L'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS sph_os_ar,
  
(SELECT COALESCE(o.value_numeric, o.value_text) FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-T-005-L'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS cyl_os_ar,
  
(SELECT COALESCE(o.value_numeric, o.value_text) FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-T-006-L'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS axis_os_ar,

(SELECT o.value_text FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-T-007-L'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS va_cc_os_ar,
  
(SELECT o.value_text FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-T-001-R'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS va_sc_od,
  
(SELECT o.value_text FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-D-015-R'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS glasses_od,
  
(SELECT COALESCE(o.value_numeric, o.value_text) FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-T-008-R'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS sph_od_sr,
  
(SELECT COALESCE(o.value_numeric, o.value_text) FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-T-009-R'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS cyl_od_sr,
  
(SELECT COALESCE(o.value_numeric, o.value_text) FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-T-010-R'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS axis_od_sr,
  
(SELECT o.value_text FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-T-002-R'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS va_cc_od,
  
(SELECT o.value_text FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-T-001-L'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS va_sc_os,
  
(SELECT o.value_text FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-D-015-L'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS glasses_os,
  
(SELECT COALESCE(o.value_numeric, o.value_text) FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-T-008-L'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS sph_os_sr,
  
(SELECT COALESCE(o.value_numeric, o.value_text) FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-T-009-L'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS cyl_os_sr,
  
(SELECT COALESCE(o.value_numeric, o.value_text) FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-T-010-L'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS axis_os_sr,
  
(SELECT o.value_text FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-T-002-L'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS va_cc_os,
  
(SELECT IF(COUNT(*) > 0, 'checked', '') FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-D-001-R'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS presbyopia_od_checked,
  
(SELECT IF(COUNT(*) > 0, 'checked', '') FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-D-002-R'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS amblyopia_od_checked,
  
(SELECT IF(COUNT(*) > 0, 'checked', '') FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-D-003-R'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS strabismus_od_checked,
  
(SELECT IF(COUNT(*) > 0, 'checked', '') FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-D-004-R'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS corneal_dystrophy_od_checked,
  
(SELECT IF(COUNT(*) > 0, 'checked', '') FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-D-016-R'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS corneal_scar_od_checked,
  
(SELECT IF(COUNT(*) > 0, 'checked', '') FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-D-005-R'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS dry_eye_od_checked,
  
(SELECT IF(COUNT(*) > 0, 'checked', '') FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-D-006-R'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS pterygium_od_checked,
  
(SELECT IF(COUNT(*) > 0, 'checked', '') FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-D-007-R'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS cataract_od_checked,
  
(SELECT IF(COUNT(*) > 0, 'checked', '') FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-D-008-R'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS pseudophakia_od_checked,
  
(SELECT IF(COUNT(*) > 0, 'checked', '') FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-D-009-R'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS sp_uveitis_od_checked,
  
(SELECT o.value_text FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-D-013-R'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS other_ant_od,
  
(SELECT IF(COUNT(*) > 0, 'checked', '') FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-D-001-L'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS presbyopia_os_checked,
  
(SELECT IF(COUNT(*) > 0, 'checked', '') FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-D-002-L'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS amblyopia_os_checked,
  
(SELECT IF(COUNT(*) > 0, 'checked', '') FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-D-003-L'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS strabismus_os_checked,
  
(SELECT IF(COUNT(*) > 0, 'checked', '') FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-D-004-L'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS corneal_dystrophy_os_checked,
  
(SELECT IF(COUNT(*) > 0, 'checked', '') FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-D-016-L'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS corneal_scar_os_checked,
  
(SELECT IF(COUNT(*) > 0, 'checked', '') FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-D-005-L'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS dry_eye_os_checked,
  
(SELECT IF(COUNT(*) > 0, 'checked', '') FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-D-006-L'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS pterygium_os_checked,
  
(SELECT IF(COUNT(*) > 0, 'checked', '') FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-D-007-L'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS cataract_os_checked,
  
(SELECT IF(COUNT(*) > 0, 'checked', '') FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-D-008-L'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS pseudophakia_os_checked,
  
(SELECT IF(COUNT(*) > 0, 'checked', '') FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-D-009-L'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS sp_uveitis_os_checked,
  
(SELECT o.value_text FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-D-013-L'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS other_ant_os,
  
(SELECT IF(COUNT(*) > 0, 'checked', '') FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-D-010-R'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS glaucoma_od_checked,
  
(SELECT IF(COUNT(*) > 0, 'checked', '') FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-D-011-R'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS dr_od_checked,
  
(SELECT IF(COUNT(*) > 0, 'checked', '') FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-D-012-R'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS amd_od_checked,
  
(SELECT IF(COUNT(*) > 0, 'checked', '') FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-D-017-R'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS retinal_scar_od_checked,
  
(SELECT o.value_text FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-D-014-R'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS other_post_od,
  
(SELECT IF(COUNT(*) > 0, 'checked', '') FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-D-010-L'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS glaucoma_os_checked,
  
(SELECT IF(COUNT(*) > 0, 'checked', '') FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-D-011-L'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS dr_os_checked,
  
(SELECT IF(COUNT(*) > 0, 'checked', '') FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-D-012-L'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS amd_os_checked,
  
(SELECT IF(COUNT(*) > 0, 'checked', '') FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-D-017-L'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS retinal_scar_os_checked,
  
(SELECT o.value_text FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-D-014-L'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS other_post_os,
  
(SELECT o.value_numeric FROM obs o
   INNER JOIN concept c ON o.concept_id = c.concept_id
   WHERE o.person_id = @person AND c.uuid = 'AUA-T-003-R' AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS iop_od,
  
(SELECT o.value_numeric FROM obs o
   INNER JOIN concept c ON o.concept_id = c.concept_id
   WHERE o.person_id = @person AND c.uuid = 'AUA-T-003-L' AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS iop_os,
  
(SELECT IF(COUNT(*) > 0, 'checked', '') FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-P-004'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS glasses_donated_checked,
  
(SELECT IF(COUNT(*) > 0, 'checked', '') FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-P-012'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS glasses_prescribed_checked,
  
(SELECT IF(COUNT(*) > 0, 'checked', '') FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-P-013'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS operation_checked,
  
(SELECT IF(COUNT(*) > 0, 'checked', '') FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-M-001-R'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS art_tears_od_checked,
  
(SELECT IF(COUNT(*) > 0, 'checked', '') FROM obs o
   INNER JOIN concept co ON o.concept_id = co.concept_id
   WHERE o.person_id = @person AND co.uuid = 'AUA-M-001-L'  AND o.voided = 0
   ORDER BY o.obs_datetime DESC LIMIT 1) AS art_tears_os_checked
FROM patient_identifier pi
WHERE pi.patient_id = @person AND pi.voided = 0
LIMIT 1;

-- My First Report
-- Lists patients registered in date range

SELECT
    p.patient_id AS 'Patient ID',
    pi.identifier AS 'Identifier',
    pn.given_name AS 'First Name',
    pn.family_name AS 'Last Name',
    per.gender AS 'Gender',
    per.birthdate AS 'Birth Date'
FROM patient p
INNER JOIN person per ON p.patient_id = per.person_id
INNER JOIN patient_identifier pi ON p.patient_id = pi.patient_id AND pi.preferred = 1
INNER JOIN person_name pn ON p.patient_id = pn.person_id AND pn.preferred = 1
WHERE DATE(p.date_created) BETWEEN @startDate AND @endDate
  AND p.voided = 0
ORDER BY p.date_created DESC;

