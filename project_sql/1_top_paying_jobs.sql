/*
Question: What are the top-paying data analyst jobs in Calgary?
    - Identigy the top 10 highest-paying Data Analyst roles that are available in Calgary, AB, Canada
    - Focuses on job posting with specified salaries (removes nulls)
    - BONUS: Include company names of top 10 roles
    - Why? Highlight the top-paying opportunities for Data Analyst, offering insights into employment opportunities.
*/

SELECT
    job_id,
    job_title,
    job_location,
    name AS company_name,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM
    job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND job_location = 'Calgary, AB, Canada' AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC    
LIMIT 10;