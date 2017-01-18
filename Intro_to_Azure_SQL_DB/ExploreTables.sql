--Computing the avg scores by parent having the highest qualification
SELECT AVG(a.G3) AS AvgScore, b.HighestQualifiedParent
FROM Performance.StudentMaster a JOIN
            (SELECT StudentID, "HighestQualifiedParent" =
                CASE 
                    WHEN Medu > Fedu THEN 'Mother'
                    WHEN Medu < Fedu THEN 'Father'
                    ELSE 'Equal'
                END
            FROM Performance.StudentMaster) AS b
ON a.StudentID = b.StudentID
GROUP BY b.HighestQualifiedParent;

--Calculate Median Score
SELECT DISTINCT c.HighestQualifiedParent,
PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY c.Score)   
        OVER (PARTITION BY c.HighestQualifiedParent) AS MedianScore
FROM
    (SELECT a.G3 AS Score, b.HighestQualifiedParent
    FROM Performance.StudentMaster a JOIN
                (SELECT StudentID, "HighestQualifiedParent" =
                    CASE 
                        WHEN Medu > Fedu THEN 'Mother'
                        WHEN Medu < Fedu THEN 'Father'
                        ELSE 'Equal'
                    END
                FROM Performance.StudentMaster) AS b
    ON a.StudentID = b.StudentID) AS c;

--making life easier by creating a view for highest qualified parent
CREATE VIEW Performance.vHighestQualifiedParent
AS
SELECT a.G3 AS Score, b.HighestQualifiedParent, c.Qualification
    --create highest qualifaction column
    FROM Performance.StudentMaster AS a JOIN
                (SELECT StudentID, "HighestQualifiedParent" =
                    CASE 
                        WHEN Medu > Fedu THEN 'Mother'
                        WHEN Medu < Fedu THEN 'Father'
                        ELSE 'Equal'
                    END
                FROM Performance.StudentMaster) AS b
    ON a.StudentID = b.StudentID 
    JOIN
    --select the name of the highest qualification 
        (SELECT d.StudentID, e.Category AS Qualification
            FROM (SELECT StudentID, "Qualification" =
                    CASE 
                        WHEN Medu > Fedu THEN Medu
                        ELSE Fedu
                    END
                        FROM Performance.StudentMaster) AS d JOIN 
                        Performance.ParentEducation AS e
                        ON d.Qualification = e.LabelID) AS c
    ON a.StudentID = c.StudentID;

--returning the first 5 rows from the view created
SELECT TOP 5 * FROM Performance.vHighestQualifiedParent;

--use the view to  create another view for summary stats
CREATE VIEW Performance.vSummaryStats
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
    STDEV(c.Score) as StdDev
    FROM Performance.vHighestQualifiedParent AS c
    GROUP BY c.HighestQualifiedParent, c.Qualification) AS a
JOIN
--calcuating the median
    (SELECT DISTINCT HighestQualifiedParent, Qualification,
        PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY Score)   
                OVER (PARTITION BY HighestQualifiedParent, 
                Qualification) AS MedianScore
        FROM Performance.vHighestQualifiedParent) AS b
ON a.HighestQualifiedParent = b.HighestQualifiedParent AND
a.Qualification = b.Qualification;

--return results from the view
--order by cannot be used to create a view but can be used in SELECT
SELECT * FROM Performance.vSummaryStats
ORDER BY HighestQualifiedParent, Qualification;

--cartesian join the results of which we will use to demonstrate
--hive partitioned tables
--be prepared to wait while this runs
SELECT a.StudentID, a.SmoteClass 
FROM Performance.StudentMaster AS a
CROSS JOIN
(SELECT b.SmoteClass,
b.School,
b.Sex,
b.Age,
b.AddressType,
b.FamSize,
b.Pstatus,
b.Medu,
b.Fedu,
b.Mjob,
b.Fjob,
b.Reason,
b.Guardian,
b.Traveltime,
b.Studytime,
b.Failures,
b.Schoolsup,
b.Famsup,
b.Paid,
b.Activities,
b.Nursery,
b.Higher,
b.Internet,
b.Romantic,
b.FamRel,
b.FreeTime,
b.GoOut,
b.Dalc,
b.Walc,
b.Health,
b.Absences,
b.G1,
b.G2,
b.G3
FROM Performance.StudentMaster as b) as c;

