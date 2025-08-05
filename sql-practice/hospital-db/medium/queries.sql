-- 1. Show unique birth years from patients and order them by ascending.
SELECT DISTINCT EXTRACT(YEAR FROM birth_date) AS birth_year
FROM patients
ORDER BY birth_year;

-- Second solution
SELECT EXTRACT(YEAR FROM birth_date) AS birth_year
FROM patients
GROUP BY EXTRACT(YEAR FROM birth_date);

-- 2. Show unique first names from the patients table which only occurs once in the list.
-- For example, if two or more people are named 'John' in the first_name column then don't 
-- include their name in the output list. If only 1 person is named 'Leo' then include them in the output.
SELECT first_name
FROM patients
GROUP BY first_name
HAVING COUNT(first_name) = 1;

-- Second solution 
SELECT first_name
FROM (
  SELECT 
    first_name,
    COUNT(*) AS occurrencies
  FROM patients
  GROUP BY first_name
) AS first_name_occurrencies
WHERE occurrencies = 1;

-- 3. Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.
SELECT patient_id, first_name
FROM patients
WHERE first_name LIKE 's%s'
  AND LENGTH(first_name) >= 6;

-- Second solution
SELECT patient_id, first_name
FROM patients
WHERE first_name LIKE 's____%s';

-- 4. Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.
-- Primary diagnosis is stored in the admissions table.
SELECT
  p.patient_id,
  p.first_name,
  p.last_name
FROM patients p
INNER JOIN admissions a 
  ON p.patient_id = a.patient_id
WHERE a.diagnosis = 'Dementia';

-- Second solution
SELECT 
  patient_id,
  first_name,
  last_name
FROM patients
WHERE patient_id IN (
  SELECT patient_id
  FROM admissions
  WHERE diagnosis = 'Dementia'
);

-- Third solution
SELECT
  patient_id,
  first_name,
  last_name
FROM patients p
WHERE 'Dementia' IN (
    SELECT diagnosis
    FROM admissions
    WHERE admissions.patient_id = p.patient_id
);

-- 5. Display every patient's first_name. Order the list by the length of each name and then by alphabetically.
SELECT first_name
FROM patients
ORDER BY LENGTH(first_name), first_name;

-- 6. Show the total amount of male patients and the total amount of female patients in the patients table.
-- Display the two results in the same row.

-- Result in the same column
-- SELECT
--   total_male || " " || total_female
-- FROM (
--   SELECT
--     COUNT(CASE WHEN gender = 'M' THEN 1 ELSE NULL END) AS total_male,
--     COUNT(CASE WHEN gender = 'F' THEN 1 ELSE NULL END) AS total_female
--   FROM patients
-- ) AS total_amount_male_and_female_patients;

SELECT
  COUNT(CASE WHEN gender = 'M' THEN 1 ELSE NULL END) AS total_male,
  COUNT(CASE WHEN gender = 'F' THEN 1 ELSE NULL END) AS total_female
FROM patients;

-- Second solution
SELECT 
  SUM(Gender = 'M') as male_count, 
  SUM(Gender = 'F') AS female_count
FROM patients

-- Third solution
SELECT 
  (SELECT COUNT(*) FROM patients WHERE gender = 'M') AS male_count, 
  (SELECT COUNT(*) FROM patients WHERE gender = 'F') AS female_count;

-- Fourth solution
SELECT 
  SUM(CASE WHEN gender = 'M' THEN 1 else 0 END) AS male_count,
  SUM(CASE WHEN gender = 'F' THEN 1 else 0 END) AS female_count 
FROM patients;

-- 7. Show first and last name, allergies from patients which have allergies to either 
-- 'Penicillin' or 'Morphine'. Show results ordered ascending by allergies then by first_name then by last_name.
SELECT
  first_name,
  last_name,
  allergies
FROM patients  
WHERE allergies IN ('Penicillin', 'Morphine')
ORDER BY allergies, first_name, last_name;

-- 8. Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.
SELECT patient_id, diagnosis
FROM admissions
GROUP BY patient_id, diagnosis
HAVING COUNT(*) > 1;

-- 9. Show the city and the total number of patients in the city.
-- Order from most to least patients and then by city name ascending.
SELECT 
  city, 
  COUNT(patient_id) AS count_patients
FROM patients
GROUP BY city
ORDER BY count_patients DESC, city;

-- 10. Show first name, last name and role of every person that is either patient or doctor.
-- The roles are either "Patient" or "Doctor"
SELECT first_name, last_name, 'Patient' AS role FROM patients;
UNION ALL
SELECT first_name, last_name, 'Doctor' AS role FROM doctors;

-- 11. Show all allergies ordered by popularity. Remove NULL values from query.
SELECT 
	allergies,
   	COUNT(*) AS total_diagnosis
FROM patients
WHERE allergies IS NOT NULL
GROUP BY allergies
ORDER BY total_diagnosis DESC;

-- Second solution
SELECT
  allergies,
  count(allergies) AS total_diagnosis
FROM patients
GROUP BY allergies
HAVING allergies IS NOT NULL
ORDER BY total_diagnosis DESC;

-- 12. Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. 
-- Sort the list starting from the earliest birth_date.
SELECT
	first_name,
    last_name,
    birth_date
FROM patients
WHERE
	YEAR(birth_date) BETWEEN 1970 AND 1979
ORDER BY birth_date;

-- Second solution
SELECT
  first_name,
  last_name,
  birth_date
FROM patients
WHERE
  birth_date >= '1970-01-01'
  AND birth_date < '1980-01-01'
ORDER BY birth_date ASC;

-- Third solution
SELECT
  first_name,
  last_name,
  birth_date
FROM patients
WHERE year(birth_date) LIKE '197%'
ORDER BY birth_date ASC;

-- 13. We want to display each patient's full name in a single column. Their last_name in all 
-- upper letters must appear first, then first_name in all lower case letters. Separate the 
-- last_name and first_name with a comma. Order the list by the first_name in decending order
-- EX: SMITH,jane
SELECT 
	CONCAT(UPPER(last_name), ',', LOWER(first_name)) AS new_name_format
 FROM patients
ORDER BY first_name DESC;

-- Second solution
SELECT
  UPPER(last_name) || ',' || LOWER(first_name) AS new_name_format
FROM patients
ORDER BY first_name DESC;

-- 14. Show the province_id(s), sum of height; where the total sum of its patient's height 
-- is greater than or equal to 7,000.
SELECT 
	province_id,
    SUM(height) AS sum_height
FROM patients
GROUP BY province_id
HAVING SUM(height) >= 7000;


-- 15. Show the difference between the largest weight and smallest weight for patients with the 
-- last name 'Maroni'
SELECT
	MAX(weight) - MIN(weight) AS weight_delta
FROM patients
WHERE last_name = 'Maroni';