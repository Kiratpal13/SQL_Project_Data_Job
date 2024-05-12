# Introduction
📊 Embark on a journey into the realm of data jobs! This project, with a spotlight on data analyst positions, delves into 💰 high-paying roles, 🔥 sought-after skills, and 📈 the intersection of high demand and high remuneration in the field of data analytics.

🔍 Interested in SQL queries? You can find them in the following location: [project_sql folder](/project_sql/)

# Background
Motivated by the ambition to efficiently navigate the data analyst job market, this project was conceived with the aim of identifying highly remunerated and in-demand skills, thereby facilitating others in their quest for the ideal job.

The data originates from the [SQL Course](/https://www.lukebarousse.com/sql) and is brimming with valuable insights on job titles, salaries, locations, and indispensable skills.

### The questions I sought to answer through my SQL queries were:

1. What are the highest-paying data analyst jobs?
2. What skills are necessary for these high-paying roles?
3. Which skills are most sought-after for data analysts?
4. Which skills correlate with higher salaries?
5. What are the most beneficial skills to acquire?
# Tools I Used
 In my comprehensive exploration of the data analyst job market, I employed a variety of crucial tools:

- **SQL**: The foundation of my analysis, enabling me to interrogate the database and discover vital insights.
- **PostgreSQL**: The selected database management system, perfectly suited for managing the job posting data.
- **Visual Studio Code**: My preferred choice for database management and executing SQL queries.
- **Git & GitHub**: Indispensable for version control and disseminating my SQL scripts and analysis, fostering collaboration and project monitoring.

# The Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market. Here’s how I approached each question:

### 1. What are the highest-paying data analyst jobs?
To pinpoint the top-paying roles, I sifted through data analyst positions based on average annual salary and location, with a particular emphasis on remote jobs. This query underscores the lucrative opportunities in the field.

```sql
SELECT	
	job_id,
	job_title,
	job_location,
	job_schedule_type,
	salary_year_avg,
	job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND 
    job_location = 'Anywhere' AND 
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```
Here’s an overview of the top data analyst jobs in 2023:

- **Wide Salary Range**: The top 10 paying data analyst roles range from $184,000 to $650,000, demonstrating substantial earning potential in the field.
- **Diverse Employers**: Firms like SmartAsset, Meta, and AT&T are among those offering high salaries, indicating a wide-ranging interest across diverse industries.
- **Job Title Variety**:There’s a significant variety in job titles, from Data Analyst to Director of Analytics, mirroring the array of roles and specializations within data analytics.

![Top Paying Jobs](photo\data_top_jobs.png)

*Bar graph visualizing the count of skills for the top 10 paying jobs for data analysts; this graph was generated from my SQL query results by ChatGPT.*

### 2. What skills are necessary for these high-paying roles?
To comprehend the skills necessary for the highest-paying roles, I merged the job postings with the skills data, offering insights into what employers deem valuable for well-remunerated positions.

```sql
WITH top_paying_jobs AS (
    SELECT	
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND 
        job_location = 'Anywhere' AND 
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;
```    

Here’s an overview of the most sought-after skills for the top 10 highest-paying data analyst jobs in 2023:

- **SQL** takes the lead with a significant count of 8.
- **Python** is a close second with a count of 7.
- **Tableau**  is also in high demand, with a count of 6. Other skills like **R, Snowflake, Pandas, and Excel** show varying degrees of demand.
![Top skills](photo\Data_analyst_skill_2023_graph.png)
*Bar graph visualizing the count of skills for the top 10 paying jobs for data analysts; ChatGPT generated this graph from my SQL query results*

### 3. Which skills are most sought-after for data analysts?
This query 🕵️‍♂️ pinpointed the competencies 🎯 most commonly sought in job listings, thereby guiding attention 👀 towards sectors experiencing significant demand 📈.
 ```sql
 SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' 
    AND job_work_from_home = True 
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;
 ```

Here’s an overview of the top skills sought after for data analysts in 2023:

- 📊 **SQL** and **Excel** continue to be the cornerstone 🧱, highlighting the importance of solid foundational skills in data manipulation 🔄 and spreadsheet wizardry 📈.
- 💻**Programming and Visualization Tools** like like **Python**, **Tableau** 📊, and **Power BI**  are indispensable, signaling an increased focus on technical prowess in data storytelling 📖 and support in decision-making 🤔.

| **Skills** | **Demand Count** |
|------------|------------------|
|SQL         |7291              |
|Excel       |4611              |
|Python      |4330              |
|Tableau     |3745              |
|Power BI    |2609              |
*Table of the demand for the top 5 skills in data analyst job postings*

### 4. Which skills correlate with higher salaries?
Investigating the average earnings 💰 linked to various abilities showed which competencies command the top dollar 💸.
```sql
SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True 
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;
```
Here's a breakdown of the results for top paying skills for Data Analysts:

- **High Demand for Big Data & ML Skills**: Analysts adept in big data technologies (PySpark, Couchbase) and machine learning tools (DataRobot, Jupyter), along with Python libraries (Pandas, NumPy), are seeing the highest paychecks 💰, mirroring the industry’s high regard for data processing and predictive modeling prowess 🤖.
- **Software Development & Deployment Proficiency**:  Expertise in development and deployment tools (GitLab, Kubernetes, Airflow) is proving to be financially rewarding 💵, marking a profitable intersection between data analysis and engineering, with a focus on skills that streamline automation and data pipeline management 🚀.
- **Cloud Computing Expertise**: Acquaintance with cloud and data engineering tools (Elasticsearch, Databricks, GCP) is increasingly vital, highlighting the shift towards cloud-based analytics platforms and indicating that cloud savvy is a major plus for a data analyst’s earning potential 📊.

|Skills         | Average Salary ($)|
|----------     |-------------------|
|pyspark        |    208,172        |
|bitbucket      |    189,155        |
|couchbase      |	 160,515        |
|watson         |    160,515        |
|datarobot      |    155,486        |
|gitlab         |    154,500        |
|swift          |    153,750        |
|jupyter        |    152,777        |
|pandas	        |    151,821        |
|elasticsearch	|    145,000        |
*Table of the average salary for the top 10 paying skills for data analysts*

### 5. What are the most beneficial skills to acquire?
This analysis synthesized information from market demand and compensation figures to identify skills that are not only sought-after but also well-paid, providing a targeted direction for cultivating expertise.

```sql
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True 
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```
| Skill ID | Skills     | Demand Count | Average Salary ($) |
|----------|------------|--------------|--------------------|
| 8	       | go 	    | 27	       |    115,320         |
| 234	   | confluence	| 11	       |    114,210         |
| 97	   | hadoop	    | 22	       |    113,193         |
| 80	   | snowflake	| 37	       |    112,948         |
| 74	   | azure	    | 34	       |    111,225         |
| 77	   | bigquery	| 13	       |    109,654         |
| 76	   | aws	    | 32	       |    108,317         |
| 4        | java	    | 17	       |    106,906         |
| 194	   | ssis	    | 12	       |    106,683         |
| 233	   | jira	    | 20	       |    104,918         |
*Table of the most optimal skills for data analyst sorted by salary*
### Here's a breakdown of the most optimal skills for Data Analysts in 2023:

- **High-Demand Programming Languages**: Python and R are in the spotlight with demand counts of 236 and 148, respectively. Despite being highly sought after, their average salaries of $101,397 for Python and $100,499 for R suggest that these skills are highly valued yet widely held.
- ☁️**Cloud Tools and Technologies**: Expertise in specialized tech like Snowflake, Azure, AWS, and BigQuery is in high demand, with relatively lofty average salaries, signaling the escalating significance of cloud platforms and big data tech in data analysis.
- 📊**Business Intelligence and Visualization Tools**: Tableau and Looker, boasting demand counts of 230 and 49, and average salaries of approximately $99,288 and $103,795, respectively, underscore the pivotal role of data visualization and business intelligence in gleaning actionable insights.
- 💾**Database Technologies**: The need for proficiency in traditional and NoSQL databases (Oracle, SQL Server, NoSQL), with average salaries spanning $97,786 to $104,534, mirrors the ongoing necessity for expertise in data storage, retrieval, and management.

# What I Learned
Throughout this adventure, I've turbocharged my SQL toolkit with some serious firepower:

- 🧩 **Complex Query Crafting**: I’ve become adept at sophisticated SQL, seamlessly joining tables and skillfully employing WITH clauses for expert temporary table strategies. 
- 📊 **Data Aggregation**: I’ve befriended GROUP BY and harnessed aggregate functions such as COUNT() and AVG() to become champions of data consolidation. 
- 💡 **Analytical Wizardry**:  I’ve advanced my problem-solving abilities, transforming complex questions into practical, perceptive SQL queries.
# Conclusions
### Insights
From the analysis, several general insights emerged:

- **Top-Paying Data Analyst Jobs**: The cream of the crop in data analyst positions that offer remote work boast a salary spectrum reaching up to a whopping $650,000! 💸
- **Skills for Top-Paying Jobs**: Advanced SQL mastery is a non-negotiable for the fattest paychecks, marking it as an essential skill for those aiming high. 🎯 
- **Most In-Demand Skills**: SQL not only tops the charts in demand but is also a must-have for job hunters in the data realm. 🌟
- **Skills with Higher Salaries**: Niche skills like SVN and Solidity come with a hefty price tag, reflecting the value placed on specialized knowledge.
- **Optimal Skills for Job Market Value**: SQL is not just in vogue; it’s also linked to generous average salaries, making it a strategic skill for data analysts to enhance their market worth. 🚀
### 🤔Closing Thoughts
This venture has sharpened my SQL capabilities and shed light on the data analyst job landscape. The insights gleaned act as a compass for skill enhancement and job-seeking strategies. Budding data analysts can carve a niche for themselves in a bustling job market by zeroing in on skills that promise both demand and dollars. This journey underscores the vitality of perpetual learning and staying attuned to the evolving currents in data analytics. 🌐