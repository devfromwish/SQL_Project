/*
The optimal skills to learn for data science based on average yearly salary
and skill demand
*/

SELECT
    skills,
    COUNT(skills) AS demand_for_skill,
    ROUND(AVG(salary_year_avg), 2) AS average_skill_salary
FROM
    job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    salary_year_avg IS NOT NULL
    AND job_title_short = 'Data Analyst'
    AND job_work_from_home = True
GROUP BY
    skills
ORDER BY
    demand_for_skill DESC, average_skill_salary DESC
LIMIT 25


-- More complicated version using a CTE (for practice) (slightly different)

WITH skills_demand AS (
    SELECT
        skills_dim.skill_id,
        skills,
        COUNT(skills) AS skill_count
    FROM
        job_postings_fact
        INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = True
    GROUP BY
        skills_dim.skill_id
),
skills_salary_avg AS (
    SELECT
        skills_dim.skill_id,
        skills,
        ROUND(AVG(salary_year_avg),2) AS avg_yearly_salary
    FROM
        job_postings_fact
        INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim On skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = True
    GROUP BY
        skills_dim.skill_id
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    skill_count,
    avg_yearly_salary
FROM
    skills_demand
    INNER JOIN skills_salary_avg ON skills_demand.skill_id = skills_salary_avg.skill_id
WHERE
    skill_count > 10
ORDER BY
    avg_yearly_salary DESC,
    skill_count DESC;
