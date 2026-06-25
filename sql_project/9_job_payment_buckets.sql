-- Amount of jobs in 5 payment buckets using average yearly salary

SELECT
    CASE
        WHEN salary_year_avg <= 30000 THEN 'Very Low'
        WHEN salary_year_avg <= 50000 THEN 'Low'
        WHEN salary_year_avg <= 70000 THEN 'Average'
        WHEN salary_year_avg <= 90000 THEN 'High'
        ELSE 'Very High'
    END AS salary_category,
    COUNT(*) AS number_of_jobs
FROM
    job_postings_fact
WHERE
    salary_year_avg IS NOT NULL
GROUP BY
    salary_category
ORDER BY
    number_of_jobs DESC;

-- Checking query
SELECT
    AVG(salary_year_avg)
FROM
    job_postings_fact

SELECT
    COUNT(*)
FROM
    job_postings_fact
WHERE
    salary_year_avg IS NOT NULL;