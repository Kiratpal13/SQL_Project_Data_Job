/*
Answer: What are the most optimal skills to learn (aka it's in high demand and a high-paying skill)?
- Identify skills in high demand and assiciated woth high average salaries for Data Analyst roles
- COncntrates on remote positions with specified salaries
- Why? Targets skils that offer job security (high demand) and finanacial benefis (high salaries),
    offering strategic insights for career development in data analysis
*/


WITH skills_demand AS (
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS skills_demand_count

FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_country = 'Canada'
GROUP BY
    skills_dim.skill_id

), average_salary AS (
    SELECT 
    skills_job_dim.skill_id,
    ROUND ( AVG(salary_year_avg), 0 )AS avg_salary 
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_country = 'Canada' AND
    salary_year_avg IS NOT NULL
GROUP BY
    skills_job_dim.skill_id   
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    skills_demand_count,
    average_salary
FROM
    skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id    

ORDER BY
    
        avg_salary DESC,
        skills_demand_count DESC
LIMIT 25     