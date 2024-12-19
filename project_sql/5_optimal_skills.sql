/*
Answer: What are the most optimal skills to learn (aka it's in high demand and a high-paying skill)?
--Identify skills in high demand and associated with high average salaries for Data Analyst roles
--Concentrates on remote positions with specified salaries
--Why? Targets skills that offer job security (high demand) and financial benefits (high salaries), 
    offering strategic insights for career development in data analysis1
*/

WITH skills_demand AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_location = 'India' AND
        salary_year_avg IS NOT NULL
    GROUP BY
        skills_dim.skill_id, skills_dim.skills
), average_salary AS (
    SELECT 
        skills_dim.skill_id,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_location = 'India' AND
        salary_year_avg IS NOT NULL
    GROUP BY
        skills_dim.skill_id
)
SELECT
    sd.skill_id,
    sd.skills,
    demand_count,
    avg_salary
FROM
    skills_demand sd
INNER JOIN average_salary sa ON sd.skill_id = sa.skill_id
ORDER BY  -- ORDER BY clause moved here
    demand_count DESC,
    avg_salary DESC
LIMIT 20;-- LIMIT clause moved here as well