select * from DEPARTMENTS;
select * from JOB_HISTORY;
select * from LOCATIONS;
select * from JOBS;
select * from REGIONS;
select * from EMPLOYEES;
select * from COUNTRIES; 

-- Finding location under the postal code 98199 using WHERE clause
SELECT *
FROM LOCATIONS
WHERE POSTAL_CODE = '98199';

-- We got to know that location_id 1700 has the postal code 98199

-- Both of the below queries gives the same result with a little difference

-- Now, finding the department under the location id 1700 using WHERE clause and = operator
SELECT * FROM DEPARTMENTS WHERE LOCATION_ID = 1700;

-- Finding department name under the postal code 98199
SELECT DEPARTMENT_NAME
FROM DEPARTMENTS
WHERE LOCATION_ID = 1700;

-- Finding the departments which does not belong to postal code 98199 using WHERE clause and != operator
SELECT *
FROM DEPARTMENTS
WHERE LOCATION_ID != 1700;

-- Finding department name not under the postal code 98199
SELECT DEPARTMENT_NAME
FROM DEPARTMENTS
WHERE LOCATION_ID != 1700;

-- Finding details of employees who's salary is more than 10000 using > operator
SELECT *
FROM EMPLOYEES
WHERE SALARY > 10000;

-- Finding details with name, email and phone numbers of employees whose salary is > 10000
SELECT FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER
FROM EMPLOYEES
WHERE SALARY > 10000;

-- Finding employee details from marketing department whose salary is < 6000
SELECT * 
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME = 'Marketing';

SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = 20 AND SALARY < 6000;

-- Finding employees details where comission_pct is available using IS NOT NULL
SELECT *
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL;
-- Only 35 records have no null values for commission_pct

-- Now, finding employee details where manager_id is not available using IS NULL
SELECT * 
FROM EMPLOYEES
WHERE MANAGER_ID IS NULL;

-----------------------ORDER BY & HANDLING NULL VALUES--------------------------

-- Listing down employees in ascending order using ORDER BY clause
SELECT first_name||' '||last_name -- Pipe operator with blank space merges two columns with blank space
FROM EMPLOYEES
ORDER BY first_name, last_name;

-- Finding locations of UK country in descending order of postal code using DESC keyword
SELECT *
FROM LOCATIONS
WHERE COUNTRY_ID = 'UK'
ORDER BY POSTAL_CODE DESC;

-- Finding locations of UK country in ascending order of postal code but nulls should be at top using NULLS FIRST keyword
SELECT *
FROM LOCATIONS
WHERE COUNTRY_ID = 'UK'
ORDER BY POSTAL_CODE NULLS FIRST;

-- Finding all the locations and arrange country in ascending and city in descending order
SELECT * 
FROM LOCATIONS
ORDER BY COUNTRY_ID ASC, CITY DESC;

-- Finding all the locations and arrange country and city in ascending order
SELECT * 
FROM LOCATIONS
ORDER BY COUNTRY_ID, CITY;

----------------------SEARCHING FOR SPECIFIED PATTERNS--------------------------

-- Finding employees who work as President, Administration Vice President, and Administration Assistant
SELECT *
FROM JOBS
WHERE JOB_TITLE IN ('President', 'Administration Vice President', 'Administration Assistant'); --using IN clause with string values of job titles

SELECT FIRST_NAME, LAST_NAME, EMAIL, JOB_ID 
FROM EMPLOYEES
WHERE JOB_ID IN ('AD_PRES', 'AD_VP', 'AD_ASST');

-- Finding employees who does not work as Finance Manager, Shipping Clerk and Accountant using NOT IN clause
SELECT * 
FROM JOBS
WHERE JOB_TITLE IN ('Finance Manager', 'Shipping Clerk', 'Accountant');

SELECT FIRST_NAME, LAST_NAME, EMAIL, JOB_ID
FROM EMPLOYEES
WHERE JOB_ID NOT IN ('FI_MGR', 'SH_CLERK', 'FI_ACCOUNT');

-- Finding employees whose JOB ID starts with AD using LIKE operator
SELECT FIRST_NAME, LAST_NAME, EMAIL, JOB_ID
FROM EMPLOYEES
WHERE JOB_ID LIKE 'AD%';

-- Finding employees whose JOB ID does not starts with SA using NOT LIKE operator
SELECT FIRST_NAME, LAST_NAME, EMAIL, JOB_ID
FROM EMPLOYEES
WHERE JOB_ID NOT LIKE 'SA%';

-- Finding employees whose JOB ID does not starts with SA neither SH using NOT LIKE operator
SELECT FIRST_NAME, LAST_NAME, EMAIL, JOB_ID
FROM EMPLOYEES
WHERE JOB_ID NOT LIKE 'SA%'
AND JOB_ID NOT LIKE 'SH%';

-- Finding all locations that start with S
SELECT *
FROM LOCATIONS
WHERE CITY LIKE 'S%';

----------------------------USING DML COMMANDS----------------------------------

-- Adding new employee in the employee table
SELECT * FROM EMPLOYEES ORDER BY EMPLOYEE_ID DESC;

Insert into EMPLOYEES (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID)
Values (207, 'Harsh', 'Sharma', 'sharmaharsh780@gmail.com', '513.331.8964', TO_DATE('21-MAY-2022', 'dd-MON-yyyy'), 'HR_REP', 23000, NULL, 101, 40); 

-- Updating newly added record for email ID
Update EMPLOYEES
SET EMAIL = 'sh@gmail.com'
WHERE EMPLOYEE_ID = 207;

-- Updating commission pact as 0 for newly added employee
Update EMPLOYEES
SET COMMISSION_PCT = 0
WHERE EMPLOYEE_ID = 207;

-- Removing/Deleting the employee from the table
DELETE FROM EMPLOYEES
WHERE EMPLOYEE_ID = 207;

--------------------CREATING BACKUP OF EXISTING TABLE---------------------------

-- Backup table will be created using AS clause. This is auto-commit command.
-- We cannot rollback this command.
CREATE TABLE EMPLOYEES_BACKUP AS (SELECT * FROM EMPLOYEES);

SELECT * FROM EMPLOYEES_BACKUP;

-- Deleting all records from employee table
TRUNCATE TABLE EMPLOYEES_BACKUP;

-- Inserting all the records from employee table into backup table
INSERT INTO EMPLOYEES_BACKUP
SELECT * FROM EMPLOYEES;

ROLLBACK; --ROLLBACKS TILL THE PREVIOUS COMMIT

COMMIT; --COMMITS THE LATEST DATA

---------------------Using DISTINCT & Renaming a COLUMN-------------------------

-- Distinct keyword helps us remove the duplicate records
SELECT DISTINCT COUNTRY_ID FROM LOCATIONS ORDER BY COUNTRY_ID;

SELECT DISTINCT MANAGER_ID FROM DEPARTMENTS;
SELECT * FROM EMPLOYEES WHERE EMPLOYEE_ID IN (200,201,114,203,121,103,204,145,100,108,205);

--THIS LINE USES ALIAS TO COLUMN FIRST_NAME AND LAST_NAME AS EMPLOYEE NAME
SELECT FIRST_NAME ||' '|| LAST_NAME AS "EMPLOYEE NAME" FROM EMPLOYEES WHERE EMPLOYEE_ID IN (200,201,114,203,121,103,204,145,100,108,205);

COMMIT;

-- Now we give alias to table name employees as t_emp
SELECT t_emp.FIRST_NAME ||' '|| t_emp.LAST_NAME AS "EMPLOYEE NAME" 
FROM EMPLOYEES t_emp
WHERE EMPLOYEE_ID IN (200,201,114,203,121,103,204,145,100,108,205);

-----------------Using complex nested condition for analysis--------------------
-- Scenario
-- We will use above functionality to find the employee records where Job_id starts
-- with AD and salary is above 10000 or job id starts with IT and salary <= 6000
-- Department name should be Purchasing, IT, and Executive and manager id commission_pct = 0
-- Employee should be hired after 1st Jan 2000

SELECT *
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME IN ('Purchasing', 'IT', 'Executive');

SELECT *
FROM EMPLOYEES
WHERE ((
(JOB_ID LIKE 'AD%' AND SALARY > 10000)
OR (JOB_ID LIKE 'IT%' AND SALARY <= 6000)
)
OR (
DEPARTMENT_ID IN (90, 60, 30)
AND COMMISSION_PCT = 0
))
AND HIRE_DATE > TO_DATE('1-JAN-1990', 'dd-MON-yyyy');










