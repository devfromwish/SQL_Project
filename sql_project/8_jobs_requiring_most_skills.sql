-- The 25 job offerings that require the most amount of skills

WITH skills_per_job AS (
    SELECT
        job_title,
        job_postings_fact.job_id,
        company_id,
        COUNT(*) AS required_skill_count
    FROM
        job_postings_fact
        INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    GROUP BY
        job_postings_fact.job_id
    ORDER BY
        required_skill_count DESC
    LIMIT 25
)

SELECT 
    skills_per_job.*,
    name AS company_name
FROM
    skills_per_job
LEFT JOIN company_dim ON skills_per_job.company_id = company_dim.company_id;

--Checking query for job offering with highest skill count
SELECT *
FROM skills_job_dim
WHERE job_id = 231519;