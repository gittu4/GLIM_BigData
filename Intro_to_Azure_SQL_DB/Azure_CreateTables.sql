-- create a schema
CREATE SCHEMA Performance;

-- create required tables (discuss the decision of selecting INT data type in cases where BINARY could be used, ex. school and sex)
CREATE TABLE Students.Performance.School
(LabelID INT PRIMARY KEY,
Category VARCHAR(255) NOT NULL);

CREATE TABLE Students.Performance.Sex
(LabelID INT PRIMARY KEY,
Category VARCHAR(255) NOT NULL);

CREATE TABLE Students.Performance.AddressType
(LabelID INT PRIMARY KEY,
Category VARCHAR(255) NOT NULL);

CREATE TABLE Students.Performance.FamSize
(LabelID INT PRIMARY KEY,
Category VARCHAR(255) NOT NULL);

CREATE TABLE Students.Performance.Pstatus
(LabelID INT PRIMARY KEY,
Category VARCHAR(255) NOT NULL);

CREATE TABLE Students.Performance.ParentEducation
(LabelID INT PRIMARY KEY,
Category VARCHAR(255) NOT NULL);

CREATE TABLE Students.Performance.ParentJob
(LabelID INT PRIMARY KEY,
Category VARCHAR(255) NOT NULL);

CREATE TABLE Students.Performance.Reason
(LabelID INT PRIMARY KEY,
Category VARCHAR(255) NOT NULL);

CREATE TABLE Students.Performance.Guardian
(LabelID INT PRIMARY KEY,
Category VARCHAR(255) NOT NULL);

CREATE TABLE Students.Performance.TravelTime
(LabelID INT PRIMARY KEY,
Category VARCHAR(255) NOT NULL);

CREATE TABLE Students.Performance.StudyTime
(LabelID INT PRIMARY KEY,
Category VARCHAR(255) NOT NULL);

CREATE TABLE Students.Performance.Failures
(LabelID INT PRIMARY KEY,
Category VARCHAR(255) NOT NULL);

CREATE TABLE Students.Performance.BadtoExcellent
(LabelID INT PRIMARY KEY,
Category VARCHAR(255) NOT NULL);

CREATE TABLE Students.Performance.LowtoHigh
(LabelID INT PRIMARY KEY,
Category VARCHAR(255) NOT NULL);

CREATE TABLE Students.Performance.SmoteClass
(LabelID INT PRIMARY KEY,
Category VARCHAR(255) NOT NULL);

CREATE TABLE Students.Performance.StudentMaster
(StudentID INT PRIMARY KEY,
School INT NOT NULL,
Sex INT NOT NULL,
Age INT NOT NULL,
AddressType INT NOT NULL,
FamSize INT NOT NULL,
Pstatus INT NOT NULL,
Medu INT NOT NULL,
Fedu INT NOT NULL,
Mjob INT NOT NULL,
Fjob INT NOT NULL,
Reason INT NOT NULL,
Guardian INT NOT NULL,
Traveltime INT NOT NULL,
Studytime INT NOT NULL,
Failures INT NOT NULL,
Schoolsup BINARY NOT NULL,
Famsup BINARY NOT NULL,
Paid BINARY NOT NULL,
Activities BINARY NOT NULL,
Nursery BINARY NOT NULL,
Higher BINARY NOT NULL,
Internet BINARY NOT NULL,
Romantic BINARY NOT NULL,
FamRel INT NOT NULL,
FreeTime INT NOT NULL,
GoOut INT NOT NULL,
Dalc INT NOT NULL,
Walc INT NOT NULL,
Health INT NOT NULL,
Absences INT NOT NULL,
G1 INT NOT NULL,
G2 INT NOT NULL,
G3 INT NOT NULL,
SmoteClass INT NOT NULL,
);

-- list tables in the Students database
SELECT * FROM information_schema.tables WHERE TABLE_TYPE='BASE TABLE';
