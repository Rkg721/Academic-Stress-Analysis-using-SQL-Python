
-- Academic Stress Data Analysis SQL Script

-- 1. Create table
CREATE TABLE AcademicStress (
    StudentID INT PRIMARY KEY,
    Gender VARCHAR(10),
    Age INT,
    StudyHoursPerDay FLOAT,
    SleepHoursPerDay FLOAT,
    StressLevel INT,
    Major VARCHAR(50),
    YearOfStudy INT,
    ExtracurricularActivities VARCHAR(3),
    GPA FLOAT,
    PartTimeJob VARCHAR(3),
    FamilyIncome FLOAT,
    SocialSupport VARCHAR(10)
);

-- 2. Sample data insertion (dummy, add real dataset via ETL)
INSERT INTO AcademicStress (StudentID, Gender, Age, StudyHoursPerDay, SleepHoursPerDay, StressLevel, Major, YearOfStudy, ExtracurricularActivities, GPA, PartTimeJob, FamilyIncome, SocialSupport)
VALUES (1, 'Male', 20, 5.0, 6.5, 7, 'Engineering', 2, 'Yes', 3.2, 'No', 45000, 'High');

-- 3. Basic Analysis Queries

-- Total students
SELECT COUNT(*) AS TotalStudents FROM AcademicStress;

-- Average stress level
SELECT AVG(StressLevel) AS AvgStressLevel FROM AcademicStress;

-- Stress level distribution by gender
SELECT Gender, AVG(StressLevel) AS AvgStress
FROM AcademicStress
GROUP BY Gender;

-- Stress vs study hours
SELECT StudyHoursPerDay, AVG(StressLevel) AS AvgStress
FROM AcademicStress
GROUP BY StudyHoursPerDay
ORDER BY StudyHoursPerDay;

-- Stress vs sleep hours
SELECT SleepHoursPerDay, AVG(StressLevel) AS AvgStress
FROM AcademicStress
GROUP BY SleepHoursPerDay
ORDER BY SleepHoursPerDay;

-- Stress level by major
SELECT Major, AVG(StressLevel) AS AvgStress, COUNT(*) AS StudentCount
FROM AcademicStress
GROUP BY Major
ORDER BY AvgStress DESC;

-- Stress vs extracurricular activities
SELECT ExtracurricularActivities, AVG(StressLevel) AS AvgStress, COUNT(*) AS StudentCount
FROM AcademicStress
GROUP BY ExtracurricularActivities;

-- GPA correlation (bucketed)
SELECT CASE
           WHEN GPA >= 3.5 THEN 'High GPA'
           WHEN GPA BETWEEN 2.5 AND 3.49 THEN 'Medium GPA'
           ELSE 'Low GPA'
       END AS GPABucket,
       AVG(StressLevel) AS AvgStress,
       COUNT(*) AS StudentCount
FROM AcademicStress
GROUP BY GPABucket;

-- Stress vs part-time job
SELECT PartTimeJob, AVG(StressLevel) AS AvgStress, COUNT(*) AS StudentCount
FROM AcademicStress
GROUP BY PartTimeJob;

-- Stress vs social support
SELECT SocialSupport, AVG(StressLevel) AS AvgStress, COUNT(*) AS StudentCount
FROM AcademicStress
GROUP BY SocialSupport;

-- Income impact (bucketed)
SELECT CASE
           WHEN FamilyIncome < 20000 THEN 'Low Income'
           WHEN FamilyIncome BETWEEN 20000 AND 60000 THEN 'Middle Income'
           ELSE 'High Income'
       END AS IncomeBucket,
       AVG(StressLevel) AS AvgStress,
       COUNT(*) AS StudentCount
FROM AcademicStress
GROUP BY IncomeBucket;

-- Top 5 most stressed students
SELECT StudentID, StressLevel, StudyHoursPerDay, SleepHoursPerDay, GPA
FROM AcademicStress
ORDER BY StressLevel DESC
LIMIT 5;
