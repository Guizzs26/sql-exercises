-- 1. Show first name, last name, and gender of patients whose gender is 'M'
SELECT
  first_name,
  last_name,
  gender
FROM patients
WHERE gender = 'M';

-- 2. Show first name and last name of patients who does not have allergies. (null)
SELECT first_name, last_name
FROM patients
WHERE allergies IS NULL;

-- 3. Show first name of patients that start with the letter 'C'
SELECT first_name
FROM patients
WHERE first_name LIKE 'C%';

-- Second solution 
SELECT first_name
FROM patients
WHERE SUBSTRING(first_name, 1, 1) = 'C';

-- 4. Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)
SELECT first_name, last_name
FROM patients
WHERE weight >= 100 AND weight <= 120;

-- Second solution
SELECT first_name, last_name
FROM patients
WHERE weight BETWEEN 100 AND 120;

-- 5. Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'
UPDATE patients
SET allergies = 'NKA'
WHERE allergies IS null;

-- 6. Show first name and last name concatinated into one column to show their full name.
SELECT first_name || " " || last_name AS full_name
FROM patients;

-- Second solution
SELECT CONCAT(first_name, " ", last_name) AS full_name
FROM patients;

-- 7. Show first name, last name, and the full province name of each patient.
-- Example: 'Ontario' instead of 'ON'
SELECT
  p.first_name, 
  p.last_name,
  pn.province_name
FROM patients p
INNER JOIN province_names pn ON pn.province_id = p.province_id;

-- 8. Show how many patients have a birth_date with 2010 as the birth year.
SELECT 
  COUNT(*) AS total_patients
FROM patients
WHERE EXTRACT(YEAR FROM birth_date) = 2010; 

-- Second solution
SELECT 
  COUNT(*) AS total_patients
FROM patients
WHERE DATE_PART('year', birth_date) = 2010; 

-- Third solution
SELECT 
  COUNT(first_name) AS total_patients -- it can be "first_name" in the count function
FROM patients
WHERE birth_date >= '2010-01-01'
  AND birth_date <= '2010-12-31';

-- Fourth solution
SELECT 
  COUNT(first_name) AS total_patients
FROM patients
WHERE birst_date BETWEEN '2010-01-31' AND '2010-12-31';

-- 9. Show the first_name, last_name, and height of the patient with the greatest height.
SELECT 
  first_name, 
  last_name,
  height
FROM patients
WHERE height = (
  SELECT MAX(height)
  FROM patients
);

-- 10. Show all columns for patients who have one of the following patient_ids:
-- 1,45,534,879,1000
SELECT * 
FROM patients
WHERE patient_id IN (1, 45, 534, 879, 1000);

-- 11. Show the total number of admissions
SELECT COUNT(*) AS total_admissions
FROM admissions;

-- 12. Show all the columns from admissions where the patient was admitted and discharged on the same day.
SELECT *
FROM admissions
WHERE admission_date = discharge_date;

-- 13. Show the patient id and the total number of admissions for patient_id 579.
SELECT 
  patient_id,
  COUNT(*) AS total_admissions
FROM admissions
WHERE patient_id = 579;

-- 14. Based on the cities that our patients live in, show unique cities that are in province_id 'NS'.
SELECT DISTINCT city AS unique_city
FROM patients
WHERE province_id = 'NS';

-- Second solution
SELECT city
FROM patients
GROUP BY city
HAVING province_id = 'NS';

-- 15. Write a query to find the first_name, last name and birth date of patients who has height greater than 160 and weight greater than 70
SELECT 
  first_name,
  last_name,
  birth_date
FROM patients
WHERE height > 160
  AND weight > 70;

-- 16. Write a query to find list of patients first_name, last_name, and allergies where allergies are not null and are from the city of 'Hamilton'
SELECT
  first_name, 
  last_name,
  allergies
FROM patients
WHERE allergies IS NOT NULL
  AND city = 'Hamilton';