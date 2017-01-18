-- Return count of students in each school
SELECT b.category as SchoolName,
COUNT(a.School) as TotalStudents
FROM studentmaster a JOIN school b
ON (a.School = b.LabelID)
GROUP BY b.category;

-- Highest Level of Education in the Family
SELECT HighestQualifiedParent, AVG(G3) AS AvgScore
FROM
    (SELECT CASE
                WHEN Medu > Fedu THEN "Mother"
                WHEN Medu < Fedu THEN "Father"
                ELSE "Equal"
            END AS HighestQualifiedParent,
    G3
    FROM studentmaster) AS a
GROUP BY HighestQualifiedParent;

--making life easier by creating a view for highest qualified parent
CREATE VIEW vHighestQualifiedParent
AS
SELECT b.HighestQualifiedParent, c.Qualification, a.G3 AS Score
    --create highest qualifaction column
    FROM StudentMaster AS a JOIN
                (SELECT StudentID,
                    CASE 
                        WHEN Medu > Fedu THEN 'Mother'
                        WHEN Medu < Fedu THEN 'Father'
                        ELSE 'Equal'
                    END AS HighestQualifiedParent
                FROM StudentMaster) AS b
    ON a.StudentID = b.StudentID 
    JOIN
    --select the name of the highest qualification 
        (SELECT d.StudentID, e.Category AS Qualification
            FROM (SELECT StudentID,
                    CASE 
                        WHEN Medu > Fedu THEN Medu
                        ELSE Fedu
                    END AS Qualification
                        FROM StudentMaster) AS d JOIN 
                        ParentEducation AS e
                        ON d.Qualification = e.LabelID) AS c
    ON a.StudentID = c.StudentID;

--returning the first 5 rows from the view created
SELECT * FROM vHighestQualifiedParent
LIMIT 5;


--use the view to  create another view for summary stats
CREATE VIEW vSummaryStats
AS
SELECT a.HighestQualifiedParent, a.Qualification,
    a.MinScore, a.AvgScore,
    b.MedianScore as MedianScore, a.MaxScore,
    a.StdDev
FROM
--group by required to return summarized rows
    (SELECT c.HighestQualifiedParent, c.Qualification,
    MIN(c.Score) AS MinScore, AVG(c.Score) AS AvgScore,
    MAX(c.Score) AS MaxScore,
    STDDEV(c.Score) as StdDev
    FROM vHighestQualifiedParent AS c
    GROUP BY c.HighestQualifiedParent, c.Qualification) AS a
JOIN
--calculate median
(SELECT HighestQualifiedParent, Qualification, percentile_approx(Score, 0.5, 10000) as MedianScore
FROM vHighestQualifiedParent
GROUP BY HighestQualifiedParent, Qualification) AS b
ON a.HighestQualifiedParent = b.HighestQualifiedParent AND
a.Qualification = b.Qualification;

--return results from the view
--order by cannot be used to create a view but can be used in SELECT
SELECT * FROM vSummaryStats
ORDER BY HighestQualifiedParent, Qualification;