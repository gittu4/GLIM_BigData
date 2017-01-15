-- Return count of students in each school
SELECT b.category as SchoolName,
COUNT(a.School) as TotalStudents
FROM studentmaster a JOIN school b
ON (a.School = b.LabelID)
GROUP BY b.category;

-- Highest Level of Education in the Family
SELECT CASE
            WHEN Medu > Fedu THEN "Mother"
            WHEN Medu < Fedu THEN "Father"
            ELSE "Equal"
        END AS HighestQualifiedParent,
AVG(G3) as AvgScore
FROM studentmaster
GROUP BY HighestQualifiedParent;