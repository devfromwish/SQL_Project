/*
    The 10 top paying remote Data Analyst jobs, ordered by yearly salary,
    including the respective company associated with the job offering
*/

SELECT 
    job_postings_fact.job_id,
    job_postings_fact.job_title_short,
    job_postings_fact.salary_year_avg AS average_yearly_salary,
    job_postings_fact.job_location,
    job_postings_fact.job_posted_date,
    company_dim.name AS company_name
FROM
    job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst'
    AND job_work_from_home = True
    AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
