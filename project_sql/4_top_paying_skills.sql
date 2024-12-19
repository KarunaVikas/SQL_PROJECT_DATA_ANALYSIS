/*
Answer: What are the top skills based on salary?
--Look at the average salary associated with each skill for Data Analyst positions
--Focuses on roles with specified salaries.
--Why? It reveals how different skills impact salary levels for Data Analysts and 
    helps identify the most financially rewarding skills to acquire or improve
*/

SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'India' AND
    salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 10;

/*
Here are some quick insights into trends from the provided list of top-paying skills for data analysts:

--Collaboration and Project Management Tools are Highly Valued: Visio, Confluence, and Jira all command very high average salaries ($119,250). This suggests that employers are willing to pay a premium for data analysts who can effectively collaborate with teams, document processes, and manage projects. These skills are not strictly analytical but are crucial for integrating data analysis into broader business operations.
--Cloud and Business Intelligence Platforms are in Demand: Azure and Power BI also show strong salaries ($118,140). This reflects the increasing importance of cloud computing and data visualization in the field. Analysts with experience in these platforms are highly sought after.
--Office Suite Proficiency is Still Important, but Less Rewarding: PowerPoint, Flow (likely Microsoft Power Automate), Sheets (Google Sheets), and Word, while still relevant, have lower average salaries. This indicates that these skills are often considered foundational or expected, rather than specialized, and therefore don't command the same premium.
--SQL, a Core Analytical Skill, is Surprisingly Lower: SQL, a fundamental skill for data analysis, has the lowest average salary on this list. This is a bit counterintuitive. It could be due to a few factors:
--High Supply: SQL is a widely taught and learned skill, leading to a larger pool of candidates.
--Entry-Level Association: Many entry-level data analyst positions require SQL, which may pull down the average salary.
--Specialized SQL Skills Not Captured: This data might not differentiate between basic SQL and more advanced skills like query optimization, data warehousing, or database administration, which can command higher salaries.
--The Data Suggests a Focus on Business Application: The high value placed on tools like Jira, Confluence, Visio, and Power BI suggests that employers are looking for data analysts who can not only analyze data but also effectively communicate insights, manage projects, and integrate their work into the broader business context.
It's important to note that this data represents averages and may not reflect the full complexity of the job market. Factors like location, experience level, and specific industry can also significantly impact salaries.


[
  {
    "skills": "visio",
    "avg_salary": "119250"
  },
  {
    "skills": "confluence",
    "avg_salary": "119250"
  },
  {
    "skills": "jira",
    "avg_salary": "119250"
  },
  {
    "skills": "azure",
    "avg_salary": "118140"
  },
  {
    "skills": "power bi",
    "avg_salary": "118140"
  },
  {
    "skills": "powerpoint",
    "avg_salary": "104550"
  },
  {
    "skills": "flow",
    "avg_salary": "96604"
  },
  {
    "skills": "sheets",
    "avg_salary": "93600"
  },
  {
    "skills": "word",
    "avg_salary": "89579"
  },
  {
    "skills": "sql",
    "avg_salary": "85397"
  }
]
*/