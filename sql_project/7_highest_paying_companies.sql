-- 25 highest paying companies (average yearly salary across all job offerings)
-- at least 5 job offerings needed for inclusion
SELECT
    name AS company_name,
    average_yearly_salary,
    job_offerings_count

FROM (
    SELECT
        company_id,
        ROUND(AVG(salary_year_avg), 2) AS average_yearly_salary,
        COUNT(*) AS job_offerings_count
    FROM
        job_postings_fact
    WHERE
        salary_year_avg IS NOT NULL
    GROUP BY
        company_id
    HAVING
        COUNT(*) >= 5
    ORDER BY 
        average_yearly_salary DESC
) AS highest_paying_companies
INNER JOIN company_dim ON highest_paying_companies.company_id = company_dim.company_id
ORDER BY
    average_yearly_salary DESC
LIMIT 25;

