-- Average yearly salary per country and job type

SELECT
    job_country,
    COUNT(*) AS number_of_offerings,
    ROUND(AVG(salary_year_avg), 0) AS average_salary
FROM
    job_postings_fact
WHERE
    salary_year_avg IS NOT NULL
GROUP BY
    job_country
HAVING
    COUNT(*) > 10
ORDER BY
    average_salary DESC;