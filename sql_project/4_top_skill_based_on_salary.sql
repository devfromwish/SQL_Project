-- Top skills based on average yearly salary for Data Analyst positions
-- Ordered by average yearly salary for respective skill

SELECT 
    skills,
    COUNT(skills) AS times_required,
    ROUND(AVG(salary_year_avg), 2) AS average_salary_for_skill
FROM
    job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    salary_year_avg IS NOT NULL
    AND job_title_short = 'Data Analyst'
GROUP BY
    skills
ORDER BY
    average_salary_for_skill DESC, times_required DESC;