# Q5 
Please explain the difference between a left, right and inner join in your own words

## Defining Joins
Joins are used to combine rows from different tables based on a related column. This allows users to present data from multiple sources in a single query.

A **Left Join** is the most common join, and will return all rows from the “left” (first) table, and all corresponding rows from the “right” (second) table. 
If the right table does not have a matching row based on the join condition, then you will receive a NULL value instead.

Generally, it is best to use your most complete table as your first (left) table in the FROM statement, as this will preserve the integrity of the dataset.

An **Inner Join** only returns rows that have matching values in each table. Any rows that do not satisfy the join condition in both the left and right tables will be excluded from the affected query.

This join can be quite useful when working with incomplete data that cannot be repaired, or for rapidly presenting cleaner-looking findings.

A **Right Join** functions in the opposite “direction” as a left join, including all rows from the right (second) table and returning NULL values from the left table 
if it does not have a matching row based on the join condition.

This join is not used frequently, but has niche applications. I try to avoid using this join unless absolutely necessary, as other viewers/users of the code may not 
catch that a right join is being used due to their rarity and can present confusing results.

*Please see below for a visual representation of the three types of join discussed in this answer.*
![join visualization](https://github.com/Pat-T1/SQL-Scripts-Medical-Marketing/assets/126030503/f0d2cd65-7e67-474c-a591-542b53daba66)
