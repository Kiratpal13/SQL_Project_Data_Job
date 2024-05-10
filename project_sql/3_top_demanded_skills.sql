/*
Question: What are the most in-demand skills for Data Analyst?
- Join job postings to inner join table similar to query of top paying job skills
- Identgy the top 5 In-Demand skills for a Data Analyst
- Focus on all job postings
- Why? Retrieves the top 5 skills with the highest demand in the job market,
    providing insihts into the most valuable skills for job seekers.
*/

SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS skills_demand_count

FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_country = 'Canada'
GROUP BY
    skills
ORDER BY
    skills_demand_count DESC    
LIMIT 5
