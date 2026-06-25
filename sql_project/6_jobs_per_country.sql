-- Number of Jobs per Country

SELECT
    job_country,
    COUNT(*) AS job_count
FROM
    job_postings_fact
GROUP BY
    job_country
ORDER BY
    job_count DESC;