# Data overview and cleaning 
*Time spent: 45 minutes*

I first made a copy of each excel sheet so I could preserve the integrity of the data while still checking overall completion and consistency. 
The following outlines the steps I took to check the overall quality of this data.

**Engagements**: There are 4 unique campaigns that align with the campaign tab. All 10903 contacts are represented within this sheet. 
These were found using UNIQUE and COUNT. Excel’s ‘remove duplicates’ function found no duplicate values when searching for a combination of contact_ID and campaign_ID. No further cleaning or removal required. 

*Note*: there are three single-digit contact_ID’s, however these were also found in the contacts tab. They are likely long-time users - a quick clarification of these ID’s as 
legitimate with a subject matter expert would normally be performed, however I will keep these entries for the purpose of this project.

**Campaigns**: The sent_date column is consistently formatted. Campaign names are not unique, so the campaign ID will be primary key for this table.

**Contacts**: No duplicate records were found, however there are some issues that would benefit from clarification:
State abbreviations: PR, VI, and AE are potentially typos, however they could also represent Puerto Rico, the U.S. Virgin Islands, and Armed Forces, Europe, respectively. Clarification with SME would resolve this question.

*State*: COUNTIF reveals there are 467 (4.28%) blank entries in the state column. These will be classified as “unknown” using a case statement for applicable queries.

*Specialty*: COUNTIF reveals 260 (2.38%) blank entries in the specialty column. These will be classified as “unknown” using a case statement for applicable queries.

**MappedSpecialty** : There are no duplicates in this sheet, with 69 unique values for specialty (user-input) and 34 mapped specialties.
Cleaning summary: Overall, the dataset appears clean and reliable. No records were deleted, no duplicate records were found, and blank entries represent a small minority of the full dataset. 
Rather than removing these entries, I will classify blank state/specialty/mapped specialty values as “unknown” while writing my queries. The non-standard state abbreviations are worth investigating with a subject matter expert, however there are reasonable explanations for these abbreviations and will be kept within the dataset.

# Data Upload 
*Time spent: 10 minutes*

A fresh copy of the dataset was uploaded to BigQuery. There was a slight issue in recognizing the schema for the mapped_specialty table, 
however this was resolved by querying the table and using ‘AS’ to properly name each field. When this query was run, I used the export feature to create a new table.

Each table was checked for completeness after upload by using count on each table’s primary key and checked against totals from the provided spreadsheet.
