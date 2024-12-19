# Introduction
📊 Dive into the data job market! Focusing on data analyst roles, this project explores 💰 top-paying jobs, 🔥 in-demand skills, and 📈 where high demand meets high salary in data analytics.

🔍 SQL queries? Check them out here: [project_sql folder](/project_sql/)



# Background

Driven by a quest to navigate the data analyst job market more effectively, this project was born from a desire to pinpoint top-paid and in-demand skills, streamlining others work to find optimal jobs.

This dataset is of real-world data science job postings from 2023 and is hosted freely via sqliteviz.It's packed with insights on job titles, salaries, locations, and essential skills.

### The questions I wanted to answer through my SQL queries were:

1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?
# Tools I used

For my deep dive into the data analyst job market, I harnessed the power of several key tools:

- **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code:** My go-to for database management and executing SQL queries.
- **Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis

Each query for this project aimed at investigating specific aspects of the data analyst job market. Here’s how I approached each question:

### 1. Top Paying Data Analyst Jobs
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location. This query highlights the high paying opportunities in the field.
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
    job_location = 'India' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 20
```
![Top Paying Jobs](assets\data_analysis_bar_chart.png)
*Bar graph visualizing the salary for the top 10 salaries for data analysts; ChatGPT generated this graph from my SQL query results*

### 2. Skills for Top Paying Jobs
To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.
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
        job_location = 'India' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 20
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC
```

### 3. In-Demand Skills for Data Analysts

This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.
```sql
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'India'
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 10;
```
| Skills   | Demand Count |
|----------|--------------|
| SQL      | 1016         |
| Excel    | 717          |
| Python   | 687          |
| Tableau  | 545          |
| Power BI | 402          |

*Table of the demand for the top 5 skills in data analyst job postings*

### 4. Skills Based on Salary
Exploring the average salaries associated with different skills revealed which skills are the highest paying.
```sql 
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

```
Here are some quick insights into trends from the provided list of top-paying skills for data analysts:

-  **Collaboration and Project Management Tools are Highly Valued:** Visio, Confluence, and Jira all command very high average salaries ($119,250). This suggests that employers are willing to pay a premium for data analysts who can effectively collaborate with teams, document processes, and manage projects. These skills are not strictly analytical but are crucial for integrating data analysis into broader business operations.
-  **Cloud and Business Intelligence Platforms are in Demand:** Azure and Power BI also show strong salaries ($118,140). This reflects the increasing importance of cloud computing and data visualization in the field. Analysts with experience in these platforms are highly sought after.
-  **Office Suite Proficiency is Still Important, but Less Rewarding:** PowerPoint, Flow (likely Microsoft Power Automate), Sheets (Google Sheets), and Word, while still relevant, have lower average salaries. This indicates that these skills are often considered foundational or expected, rather than specialized, and therefore don't command the same premium.
-  **SQL, a Core Analytical Skill, is Surprisingly Lower:** SQL, a fundamental skill for data analysis, has the lowest average salary on this list. This is a bit counterintuitive. It could be due to a few factors:
-  *High Supply:* SQL is a widely taught and learned skill, leading to a larger pool of candidates.
-  *Entry-Level Association:* Many entry-level data analyst positions require SQL, which may pull down the average salary.
-  *Specialized SQL Skills Not Captured:* This data might not differentiate between basic SQL and more advanced skills like query optimization, data warehousing, or database administration, which can command higher salaries.
-  **The Data Suggests a Focus on Business Application:** The high value placed on tools like Jira, Confluence, Visio, and Power BI suggests that employers are looking for data analysts who can not only analyze data but also effectively communicate insights, manage projects, and integrate their work into the broader business context.
It's important to note that this data represents averages and may not reflect the full complexity of the job market. Factors like location, experience level, and specific industry can also significantly impact salaries.

| Skills        | Average Salary ($) |
|---------------|-------------------:|
| visio       |            119250 |
| confluence    |            119250 |
| jira     |            119250 |
| azure       |            118140 |
| power bi     |           118140 |
| powerpoint        |            104550 |
| flow         |            96604 |
| sheets       |            93600 |
| word        |            89579 |
| sql |            85397 |

*Table of the average salary for the top 10 paying skills for data analysts*


### 5. Most Optimal Skills to Learn

Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.

```sql
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
```
| Skill ID | Skills     | Demand Count | Average Salary ($) |
|----------|------------|--------------|-------------------:|
| 0        | sql        | 9            |            85397   |
| 181      | excel      | 8            |            84366   |
| 1        | python     | 6            |            77186   |
| 188      | word       | 3            |            89579   |

*Table of the most optimal skills for data analyst sorted by salary*

# What I learned

Throughout this adventure, I've turbocharged my SQL toolkit with some serious firepower:

- **🧩 Complex Query Crafting:** Mastered the art of advanced SQL, merging tables like a pro and wielding WITH clauses for ninja-level temp table maneuvers.
- **📊 Data Aggregation:** Got cozy with GROUP BY and turned aggregate functions like COUNT() and AVG() into my data-summarizing sidekicks.
- **💡 Analytical Wizardry:** Leveled up my real-world puzzle-solving skills, turning questions into actionable, insightful SQL queries.

# Conclusions

### Insights
From the analysis, several general insights emerged:

1. **Top-Paying Data Analyst Jobs**: The highest-paying jobs for data analysts in india offer a wide range of salaries, highest salary is 119250.0.
2. **Skills for Top-Paying Jobs**: High-paying data analyst jobs require advanced proficiency in SQL, suggesting it’s a critical skill for earning a top salary.
3. **Most In-Demand Skills**: SQL is also the most demanded skill in the data analyst job market, thus making it essential for job seekers.
4. **Skills with Higher Salaries**: Specialized skills, such as  visio and confluence, are associated with the highest average salaries, indicating a premium on niche expertise.
5. **Optimal Skills for Job Market Value**: SQL leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data analysts to learn to maximize their market value.

### Closing thoughts

This project enhanced my SQL skills and provided valuable insights into the data analyst job market. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics.