-- Q1: Please write a query to produce total delivered, total opens, total clicks, AND open rate by Campaign ID. Open Rate is defined as Total Opens/Total Delivered.
-- The following code provides performance metrics (total delivered, total opened, total click-throughs, and the open rate) for the four email campaigns documented in this dataset, using GROUP BY to organize by campaign ID.
-- While not requested, I chose to order these campaigns by open rate in descending order, as this is likely the most relevant metric. The ordering metric can be changed by modifying the final line of code, or removing it entirely.
-- The ROUND function could be used to shorten the open_rate value, however this is a step I would typically take once the data has been exported to Excel. Additionally, the open rate could be turned into a percentage within SQL by adding *100, however this was not done because I will typically perform this step on the data extract in Excel.

SELECT
  Campaign_ID,
  SUM(Delivered) AS total_delivered,
  SUM(Opened) AS total_opened,
  SUM(Clicked) AS total_clicked,
  (SUM(Opened) / SUM(Delivered)) AS open_rate
FROM
  `haymarket-sql.test_data.engagements`
GROUP BY
  Campaign_ID
ORDER BY
  open_rate DESC;

-- Q2: Write a query that gives the same results as Question 1, but instead of campaign ID, have the first column be subject line.

-- The following code provides the same metrics and ordering as query 1, however this groups the results by subject line, thus reducing the total number of rows from 4 to 2.
-- Similar rounding and formatting changes could be made to this query as outlined in query 1, and were not used for the same reasons.
SELECT
  campaigns.Subject_Line AS subject_line,
  SUM(Delivered) AS total_delivered,
  SUM(Opened) AS total_opened,
  SUM(Clicked) AS total_clicked,
  (SUM(Opened) / SUM(Delivered)) AS open_rate
FROM
  `haymarket-sql.test_data.engagements` AS engagements
LEFT JOIN
  `haymarket-sql.test_data.campaigns` AS campaigns ON engagements.Campaign_ID = campaigns.ID
GROUP BY
  campaigns.Subject_Line
ORDER BY
  open_rate DESC;

-- Q3: Write a query that gives the same results as Question 2, but filtered only for users from New York and California, and sorted by greatest opens to least opens

-- The following code uses a third join referencing the "contacts" table to allow filtering by state. For a more granular analysis, the "State" field could be added to the GROUP BY clause to see how these subject lines performed in each state.
SELECT
  campaigns.Subject_Line AS subject_line,
  SUM(Delivered) AS total_delivered,
  SUM(Opened) AS total_opened,
  SUM(Clicked) AS total_clicked,
  (SUM(Opened) / SUM(Delivered)) AS open_rate
FROM
  `haymarket-sql.test_data.engagements` AS engagements
LEFT JOIN
  `haymarket-sql.test_data.campaigns` AS campaigns ON engagements.Campaign_ID = campaigns.ID
LEFT JOIN
  `haymarket-sql.test_data.contacts` AS contacts ON engagements.Contact_ID = contacts.ID
WHERE
  LOWER(contacts.State) IN ('ny', 'ca')
GROUP BY
  campaigns.Subject_Line
ORDER BY
  total_opened DESC;

-- Q4: Write a query that gives open rates by Profession and Specialty. For specialty, please ensure you use the mapped specialty column from the mapped specialty table.

-- The following code uses case/when to replace null values with the string 'unknown.'
-- I used lower on all strings in the query to lower the risk of poor grouping due to capitalization. While mapped_specialty does not need this function now, I included it in the event this table is ever updated with incorrect capitalization as a nod to reusability.
-- Depending on the stakeholder request, the join between 'contacts' and 'mapped_specialty' could be turned into an inner join to exclude contacts with self-submitted specialties that do not have a corresponding entry. I chose to use a left join to ensure completenes of data.
SELECT
  CASE WHEN contacts.Profession IS NULL THEN 'unknown'
       ELSE LOWER(contacts.Profession)
  END AS profession,
  CASE WHEN specialty.mapped_specialty IS NULL THEN 'unknown'
       ELSE LOWER(specialty.mapped_specialty)
  END AS specialty_mapped,
  (SUM(engagements.Opened) / SUM(engagements.Delivered)) AS open_rate
FROM
  `haymarket-sql.test_data.engagements` AS engagements
LEFT JOIN
  `haymarket-sql.test_data.contacts` AS contacts ON engagements.Contact_ID = contacts.ID
LEFT JOIN
  `haymarket-sql.test_data.mapped_specialty` AS specialty ON LOWER(contacts.Specialty) = LOWER(specialty.specialty)
GROUP BY
  profession, specialty_mapped
ORDER BY
  specialty_mapped, profession;
