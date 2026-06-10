WITH base AS (
       	SELECT id,
              	CONCAT_WS (' ', first_name,last_name) AS patient,
              	DATEDIFF('YEAR', CAST(date_of_birth AS DATE), '2026-05-10') AS age, 
             		insurance_provider
       	FROM PATIENTS P
       	),
  
age_group AS（
       	SELECT *,
                     CASE
                  	     WHEN age <= 20 THEN '0-20'
                  	     WHEN age BETWEEN 21 AND 40 THEN '21-40'
                  	     WHEN age BETWEEN 41 AND 60 THEN '41-60'
                  	     ELSE '61+'
              	END AS age_group
       	FROM base
       	),
  
grouped AS ( 
            SELECT age_group,
                   insurance_provider,
                   COUNT(id) AS num_of_patients
            FROM age_group
            GROUP BY age_group, insurance_provider
       )
  
SELECT * 
FROM grouped
ORDER BY num_of_patients DESC
