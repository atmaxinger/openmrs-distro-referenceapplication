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
