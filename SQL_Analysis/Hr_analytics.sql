DROP TABLE IF EXISTS employee_data;
CREATE TABLE employee_data (
    EmpID VARCHAR(20),
    Age INT,
    AgeGroup VARCHAR(20),
    Attrition VARCHAR(10),
    BusinessTravel VARCHAR(50),
    DailyRate INT,
    Department VARCHAR(50),
    DistanceFromHome INT,
    Education INT,
    EducationField VARCHAR(50),
    EmployeeNumber INT,
    EnvironmentSatisfaction INT,
    Gender VARCHAR(10),
    HourlyRate INT,
    JobInvolvement INT,
    JobLevel INT,
    JobRole VARCHAR(50),
    JobSatisfaction INT,
    MaritalStatus VARCHAR(20),
    MonthlyIncome INT,
    SalarySlab VARCHAR(20),
    MonthlyRate INT,
    NumCompaniesWorked INT,
    OverTime VARCHAR(10),
    PercentSalaryHike INT,
    PerformanceRating INT,
    RelationshipSatisfaction INT,
    StockOptionLevel INT,
    TotalWorkingYears INT,
    TrainingTimesLastYear INT,
    WorkLifeBalance INT,
    YearsAtCompany INT,
    YearsInCurrentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager DOUBLE PRECISION
);
--import HR_dataset
COPY employee_data(EmpID, Age , 	AgeGroup, 	Attrition,	BusinessTravel,	DailyRate,	Department,	DistanceFromHome,	Education,	EducationField,	EmployeeNumber,	EnvironmentSatisfaction,	Gender,	HourlyRate,	JobInvolvement,	JobLevel,	JobRole,	JobSatisfaction,	MaritalStatus,	MonthlyIncome,	SalarySlab,	MonthlyRate,	NumCompaniesWorked,	OverTime,	PercentSalaryHike,	PerformanceRating,	RelationshipSatisfaction,	StockOptionLevel,	TotalWorkingYears,	TrainingTimesLastYear,	WorkLifeBalance,	YearsAtCompany,	YearsInCurrentRole,	YearsSinceLastPromotion,	YearsWithCurrManager)
FROM 'C:\Program Files\PostgreSQL\18\cleaned_hr_data.csv'
CSV HEADER;

SELECT*FROM employee_data;

---How many employees are there in the organization?
SELECT COUNT(*) AS total_employees
FROM employee_data;

---HR manager wants to see only the basic details of employees instead of the entire table.
SELECT EmpID,Age,Department,JobRole
FROM employee_data;

---How many different departments are there in the organization?
SELECT COUNT (DISTINCT Department) AS total_dept
FROM employee_data;

--List the names of all departments in the organization
SELECT DISTINCT Department AS dept_name
FROM employee_data;

---How many employees are there in each department?
SELECT Department AS dept_name, COUNT(*) AS dept_wise_employee
FROM employee_data
GROUP BY Department;

---How many employees are there in each Job Role?
SELECT JobRole,COUNT(*) AS jobrole_wise_emp
FROM employee_data
GROUP BY JobRole;

---How many male and female employees are there in the organization?
SELECT Gender,COUNT(*) AS Gender_wise_emp
FROM employee_data
GROUP BY Gender;

---Business Question 1---
---What is the overall employee attrition rate in the organization?
SELECT
ROUND(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*),2) AS attrition_rate
FROM employee_data;

---Business Question 2---
---Which department has the highest employee attrition rate?
SELECT Department ,COUNT(*) AS total_emp , COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS emp_left,
ROUND(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*),2) AS attrition_rate
FROM employee_data
GROUP BY Department
ORDER BY attrition_rate DESC;

---Business Question 3---
---Does overtime increase employee attrition?
SELECT OverTime , COUNT(*) AS total_emp , COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS emp_left,
ROUND(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END)*100.0 / COUNT(*),2) AS attrition_rate
FROM employee_data
GROUP BY OverTime
ORDER BY attrition_rate DESC;

---Business Question 4---
---Does Job Satisfaction influence employee attrition?
SELECT JobSatisfaction , COUNT(*) AS total_emp, COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END)AS emp_left,
ROUND(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END)*100.0/COUNT(*),2) AS attrition_rate
FROM employee_data
GROUP BY JobSatisfaction
ORDER BY attrition_rate DESC;

---Business Question 5---
---Does Work-Life Balance influence employee attrition?
SELECT WorkLifeBalance , COUNT(*) AS total_emp , COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS emp_left,
ROUND(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END)*100.0/COUNT(*),2) AS attrition_rate
FROM employee_data
GROUP BY WorkLifeBalance
ORDER BY attrition_rate DESC;

---Business Question 6---
---Does Gender influence employee attrition?
SELECT Gender , COUNT(*) AS total_emp , COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS emp_left,
ROUND(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END)*100.0 / COUNT(*),2) AS Attrition_rate
FROM employee_data
GROUP BY Gender
ORDER BY Attrition_rate DESC;

---Business Question 7---
---Which Age Group has the highest employee attrition rate?
SELECT AgeGroup , COUNT(*) AS total_emp , COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS emp_left,
ROUND(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END)*100.0 / COUNT(*),2) AS Attrition_rate
FROM employee_data
GROUP BY AgeGroup
ORDER BY Attrition_rate DESC;

---Business Question 8---
---Which Salary Slab has the highest employee attrition rate?
SELECT SalarySlab , COUNT(*) AS total_emp , COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS emp_left,
ROUND(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END)*100.0 / COUNT(*),2) AS Attrition_rate
FROM employee_data
GROUP BY SalarySlab
ORDER BY Attrition_rate DESC;

---Business Question 9---
---Does Business Travel influence employee attrition?
SELECT BusinessTravel , COUNT(*) AS total_emp , COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS emp_left,
ROUND(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END)*100.0 / COUNT(*),2) AS Attrition_rate
FROM employee_data
GROUP BY BusinessTravel
ORDER BY Attrition_rate DESC;

---Business Question 10---
---Does Monthly Income affect employee attrition?
SELECT Attrition , ROUND(AVG(MonthlyIncome),2) AS avg_monthly_sal
FROM employee_data
GROUP BY Attrition 
ORDER BY Attrition DESC;

---Business Question 11---
---Which department has the highest average monthly income?
SELECT Department , ROUND(AVG(MonthlyIncome),2) AS avg_mon_inc
FROM employee_data
GROUP BY Department
ORDER BY avg_mon_inc DESC;

---Business Question 12---
---Which department contributes the highest total payroll?
SELECT Department ,SUM(MonthlyIncome) AS total_payroll
FROM employee_data
GROUP BY Department
ORDER BY total_payroll DESC;

---Business Question 13---
---Find the Top 5 highest-paid employees in the company
SELECT EmpID , Department , JobRole , MonthlyIncome
FROM employee_data
ORDER BY MonthlyIncome DESC LIMIT 5;

---Business Question 14---
---Find employees whose monthly income is higher than the company's average monthly income.
SELECT EmpID , Department , JobRole , MonthlyIncome  
FROM employee_data
WHERE MonthlyIncome >(
SELECT ROUND(AVG(MonthlyIncome),2)
FROM employee_data);

---Business Question Q15---
--Find the departments whose average monthly income is greater than the company's average monthly income.
SELECT Department,
       ROUND(AVG(MonthlyIncome),2) AS avg_salary
FROM employee_data
GROUP BY Department
HAVING AVG(MonthlyIncome) > (
    SELECT AVG(MonthlyIncome)
    FROM employee_data
)
ORDER BY avg_salary DESC;

SELECT EmpID, COUNT(*)
FROM employee_data
GROUP BY EmpID
HAVING COUNT(*) > 1;

SELECT *
FROM employee_data
WHERE EmpID IN ('RM1465','RM1466','RM1467');