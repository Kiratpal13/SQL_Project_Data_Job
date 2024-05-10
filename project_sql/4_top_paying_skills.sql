/*
Question: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions
- Fovuses on roles with specifies skills impact salary levels for Data Analysts and 
    helps identify the most finanacially rewarding skills to acquire or improve
*/
SELECT 
    skills,
    ROUND ( AVG(salary_year_avg), 0 )AS average_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_country = 'Canada' AND
    salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    average_salary DESC    
LIMIT 20    