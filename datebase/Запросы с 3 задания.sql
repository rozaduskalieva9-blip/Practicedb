--1 УРОВЕНЬ--
--Задание 1-2 выполнены в другом месте--

--3 ЗАДАНИЕ--
USE PracticeDB;
GO

-- 1. Сотрудники с зарплатой > 50000
SELECT EmployeeName, Salary FROM Employees WHERE Salary > 50000;

-- 2. Сотрудники, нанятые в 2023 году
SELECT EmployeeName, HireDate FROM Employees WHERE YEAR(HireDate) = 2023;

-- 3. Сотрудники, чьё имя начинается на «А»
SELECT EmployeeName FROM Employees WHERE EmployeeName LIKE N'А%';

-- 4. Сотрудники из отдела DepartmentId = 2
SELECT EmployeeName, DepartmentId FROM Employees WHERE DepartmentId = 2;

-- 5. Сотрудники с зарплатой в диапазоне 40000-60000
SELECT EmployeeName, Salary FROM Employees WHERE Salary BETWEEN 40000 AND 60000;


--4 ЗАДАНИЕ--
USE PracticeDB;
GO

-- 1. Топ-3 по зарплате (убывание)
SELECT TOP 3 EmployeeName, Salary 
FROM Employees 
ORDER BY Salary DESC;

-- 2. Топ-5 самых давних сотрудников по HireDate (возрастание)
SELECT TOP 5 EmployeeName, HireDate 
FROM Employees 
ORDER BY HireDate ASC;

-- 3. Сотрудники, отсортированные по отделу (возрастание), затем по зарплате (убывание)
SELECT EmployeeName, DepartmentId, Salary 
FROM Employees 
ORDER BY DepartmentId ASC, Salary DESC;


--5 ЗАДАНИЕ--
USE PracticeDB;
GO

-- 1. Общее количество сотрудников
SELECT COUNT(*) AS TotalEmployees 
FROM Employees;

-- 2. Сумма всех зарплат
SELECT SUM(Salary) AS TotalSalary 
FROM Employees;

-- 3. Средняя зарплата (округление до 2 знаков)
SELECT ROUND(AVG(Salary), 2) AS AverageSalary 
FROM Employees;

-- 4. Минимальная и максимальная зарплата
SELECT 
    MIN(Salary) AS MinSalary, 
    MAX(Salary) AS MaxSalary 
FROM Employees;

-- 5. Количество сотрудников с зарплатой > 50000
SELECT COUNT(*) AS HighSalaryEmployeesCount 
FROM Employees 
WHERE Salary > 50000;


--6 ЗАДАНИЕ--
USE PracticeDB;
GO

-- Статистика по отделам: количество сотрудников, средняя и суммарная зарплата
SELECT 
    DepartmentId,
    COUNT(*) AS EmployeesCount,
    ROUND(AVG(Salary), 2) AS AverageSalary,
    SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY DepartmentId
ORDER BY AverageSalary DESC;


--7 ЗАДАНИЕ--
USE PracticeDB;
GO

-- 1. Отделы, в которых больше 2 сотрудников
SELECT DepartmentId, COUNT(*) AS EmployeesCount 
FROM Employees 
GROUP BY DepartmentId 
HAVING COUNT(*) > 2;

-- 2. Отделы со средней зарплатой > 55000
SELECT DepartmentId, ROUND(AVG(Salary), 2) AS AverageSalary 
FROM Employees 
GROUP BY DepartmentId 
HAVING AVG(Salary) > 55000;

-- 3. Отделы, где суммарная зарплата > 150000
SELECT DepartmentId, SUM(Salary) AS TotalSalary 
FROM Employees 
GROUP BY DepartmentId 
HAVING SUM(Salary) > 150000;

--8 ЗАДАНИЕ--
SELECT 
    e.EmployeeName,
    d.DepartmentName,
    e.Salary
FROM Employees e
INNER JOIN Departments d ON e.DepartmentId = d.DepartmentId
ORDER BY d.DepartmentName ASC, e.Salary DESC;


-- Задание 9--

SELECT 
    e.EmployeeId,
    e.EmployeeName
FROM Employees e
LEFT JOIN EmployeeProjects ep ON e.EmployeeId = ep.EmployeeId
WHERE ep.EmployeeId IS NULL;

-- Задание 10--
SELECT 
    e.EmployeeName,
    d.DepartmentName,
    p.ProjectName,
    ep.Hours
FROM Employees e
INNER JOIN Departments d ON e.DepartmentId = d.DepartmentId
INNER JOIN EmployeeProjects ep ON e.EmployeeId = ep.EmployeeId
INNER JOIN Projects p ON ep.ProjectId = p.ProjectId
ORDER BY d.DepartmentName ASC, e.EmployeeName ASC, p.ProjectName ASC;
                                                        --2 УРОВЕНЬ--
-- Задание 11--
SELECT 
    emp.EmployeeName AS EmployeeName,
    mgr.EmployeeName AS ManagerName
FROM Employees emp
LEFT JOIN Employees mgr ON emp.ManagerId = mgr.EmployeeId;

-- Задание 12--
-- 1. Сотрудники с зарплатой выше средней
SELECT 
    EmployeeName, 
    Salary 
FROM Employees 
WHERE Salary > (SELECT AVG(Salary) FROM Employees);

-- 2. Сотрудники с максимальной зарплатой
SELECT 
    EmployeeName, 
    Salary 
FROM Employees 
WHERE Salary = (SELECT MAX(Salary) FROM Employees);

-- Задание 13--
SELECT 
    EmployeeName,
    Salary,
    DepartmentId,
    ROUND(
        Salary - (
            SELECT AVG(e2.Salary) 
            FROM Employees e2 
            WHERE e2.DepartmentId = e1.DepartmentId
        ), 
        2
    ) AS SalaryDiffFromDeptAvg
FROM Employees e1;

-- Задание 14--
-- 1. Сотрудники, у которых есть хотя бы один проект
SELECT EmployeeName 
FROM Employees e
WHERE EXISTS (
    SELECT 1 
    FROM EmployeeProjects ep 
    WHERE ep.EmployeeId = e.EmployeeId
);

-- 2. Сотрудники, у которых нет проектов
SELECT EmployeeName 
FROM Employees e
WHERE NOT EXISTS (
    SELECT 1 
    FROM EmployeeProjects ep 
    WHERE ep.EmployeeId = e.EmployeeId
);
-- Задание 15--
-- 1. UNION (без дубликатов, только уникальные строки)
SELECT EmployeeName, Salary, HireDate FROM Employees WHERE Salary > 60000
UNION
SELECT EmployeeName, Salary, HireDate FROM Employees WHERE YEAR(HireDate) < 2022;

-- 2. UNION ALL (сохраняет все дубликаты)
SELECT EmployeeName, Salary, HireDate FROM Employees WHERE Salary > 60000
UNION ALL
SELECT EmployeeName, Salary, HireDate FROM Employees WHERE YEAR(HireDate) < 2022;


-- Задание 16. UPDATE: изменение данных
-- 1. Увеличение зарплаты отдела 1 на 10%
SELECT EmployeeId, EmployeeName, DepartmentId, Salary FROM Employees WHERE DepartmentId = 1;
UPDATE Employees 
SET Salary = Salary * 1.10 
WHERE DepartmentId = 1;
SELECT EmployeeId, EmployeeName, DepartmentId, Salary FROM Employees WHERE DepartmentId = 1;

-- 2. Увеличение зарплаты сотрудников, нанятых до 2022 года, на 5000
SELECT EmployeeId, EmployeeName, HireDate, Salary FROM Employees WHERE YEAR(HireDate) < 2022;
UPDATE Employees 
SET Salary = Salary + 5000 
WHERE YEAR(HireDate) < 2022;
SELECT EmployeeId, EmployeeName, HireDate, Salary FROM Employees WHERE YEAR(HireDate) < 2022;

-- 3. Обновление HireDate одного сотрудника (например, с ID = 1)
SELECT EmployeeId, EmployeeName, HireDate FROM Employees WHERE EmployeeId = 1;

UPDATE Employees 
SET HireDate = '2020-01-10' 
WHERE EmployeeId = 1;

SELECT EmployeeId, EmployeeName, HireDate FROM Employees WHERE EmployeeId = 1;

-- Задание 17. DELETE: удаление данных
SELECT * FROM EmployeeProjects WHERE Hours = 0;
DELETE FROM EmployeeProjects WHERE Hours = 0;

-- 2. Удаление сотрудника по ID с предварительным удалением его зависимостей (FK)
DELETE FROM EmployeeProjects WHERE EmployeeId = 10;
DELETE FROM Employees WHERE EmployeeId = 10;

-- 3. Демонстрация DELETE с WHERE и без на временной копии таблицы
SELECT * INTO #TempEmployees FROM Employees;

SELECT COUNT(*) AS TotalRows FROM #TempEmployees;

-- DELETE с условием WHERE
DELETE FROM #TempEmployees WHERE Salary < 50000;
SELECT COUNT(*) AS RowsAfterWhere FROM #TempEmployees;

-- DELETE без WHERE (очищает всю таблицу)
DELETE FROM #TempEmployees;
SELECT COUNT(*) AS RowsAfterNoWhere FROM #TempEmployees;

-- Удаляем временную таблицу
DROP TABLE #TempEmployees;

-- Задание 18. Транзакции: BEGIN TRAN / COMMIT / ROLLBACK

-- 1. Проверка ROLLBACK (откат изменений)
BEGIN TRANSACTION;

SELECT EmployeeId, EmployeeName, Salary FROM Employees WHERE EmployeeId = 2;

UPDATE Employees SET Salary = 999999 WHERE EmployeeId = 2;

SELECT EmployeeId, EmployeeName, Salary FROM Employees WHERE EmployeeId = 2;

ROLLBACK TRANSACTION;

-- Убеждаемся, что значение вернулось к исходному
SELECT EmployeeId, EmployeeName, Salary FROM Employees WHERE EmployeeId = 2;

-- 2. Проверка COMMIT (сохранение изменений)
BEGIN TRANSACTION;

UPDATE Employees SET Salary = 888888 WHERE EmployeeId = 2;

COMMIT TRANSACTION; 

-- Убеждаемся, что изменение зафиксировано
SELECT EmployeeId, EmployeeName, Salary FROM Employees WHERE EmployeeId = 2;

-- Задание 19. Представления (VIEW)

-- 1. Создание VIEW
 CREATE VIEW vw_EmployeeDetails AS 
SELECT 
    e.EmployeeName,
    d.DepartmentName,
    p.ProjectName,
    ep.Hours
FROM Employees e
LEFT JOIN Departments d ON e.DepartmentId = d.DepartmentId
LEFT JOIN EmployeeProjects ep ON e.EmployeeId = ep.EmployeeId
LEFT JOIN Projects p ON ep.ProjectId = p.ProjectId;
GO

-- 2. Использование представления
SELECT * FROM vw_EmployeeDetails;

-- 3. Удаление представления
DROP VIEW vw_EmployeeDetails;
GO
-- Задание 20. Индексы: создание и анализ
SET STATISTICS IO ON;
GO

-- Запрос ДО создания индексов (можно нажать Ctrl+L для просмотра плана выполнения)
SELECT EmployeeName, DepartmentId, Salary 
FROM Employees 
WHERE DepartmentId = 1 AND Salary > 50000;
GO

-- Создание индексов
CREATE NONCLUSTERED INDEX IX_Employees_DepartmentId 
ON Employees(DepartmentId);

CREATE NONCLUSTERED INDEX IX_Employees_Salary 
ON Employees(Salary);
GO
-- Тот же запрос ПОСЛЕ создания индексов (сравни логические чтения вкладки "Сообщения")
SELECT EmployeeName, DepartmentId, Salary 
FROM Employees 
WHERE DepartmentId = 1 AND Salary > 50000;
GO
-- Выключаем статистику IO
SET STATISTICS IO OFF;
                                      --3 УРОВЕНЬ--
USE PracticeDB;
GO
-- Задание 21. Хранимые процедуры

-- 1. Процедура с входным параметром для получения сотрудников отдела
CREATE OR ALTER PROCEDURE sp_GetEmployeesByDepartment
    @DeptId INT
AS
BEGIN
    SELECT EmployeeId, EmployeeName, DepartmentId, Salary
    FROM Employees
    WHERE DepartmentId = @DeptId;
END;
GO

-- Вызов первой процедуры:
EXEC sp_GetEmployeesByDepartment @DeptId = 1;
GO

-- 2. Вторая процедура с OUTPUT-параметром (возвращает среднюю зарплату отдела)
CREATE OR ALTER PROCEDURE sp_GetAvgSalaryByDepartment
    @DeptId INT,
    @AvgSalary DECIMAL(18, 2) OUTPUT
AS
BEGIN
    SELECT @AvgSalary = AVG(Salary)
    FROM Employees
    WHERE DepartmentId = @DeptId;
END;
GO

-- Вызов второй процедуры с выводом результата:
DECLARE @ResultAvg DECIMAL(18, 2);
EXEC sp_GetAvgSalaryByDepartment @DeptId = 1, @AvgSalary = @ResultAvg OUTPUT;
SELECT @ResultAvg AS DepartmentAverageSalary;
GO
-- Задание 22. Функции: скалярная и табличная

-- 1. Скалярная функция: расчёт годовой зарплаты
CREATE OR ALTER FUNCTION fn_GetAnnualSalary (@MonthlySalary DECIMAL(18, 2))
RETURNS DECIMAL(18, 2)
AS
BEGIN
    RETURN @MonthlySalary * 12;
END;
GO

-- Использование скалярной функции в SELECT:
SELECT 
    EmployeeName, 
    Salary AS MonthlySalary, 
    dbo.fn_GetAnnualSalary(Salary) AS AnnualSalary
FROM Employees;
GO

-- 2. Табличная функция: сотрудники в заданном диапазоне зарплат
CREATE OR ALTER FUNCTION fn_GetEmployeesBySalaryRange (@MinSalary DECIMAL(18, 2), @MaxSalary DECIMAL(18, 2))
RETURNS TABLE
AS
RETURN (
    SELECT EmployeeId, EmployeeName, Salary, DepartmentId
    FROM Employees
    WHERE Salary BETWEEN @MinSalary AND @MaxSalary
);
GO

-- Использование табличной функции в FROM:
SELECT * 
FROM dbo.fn_GetEmployeesBySalaryRange(40000, 70000);
GO
-- Задание 23. Оконные функции: ROW_NUMBER, RANK, DENSE_RANK
SELECT 
    EmployeeName,
    DepartmentId,
    Salary,
    ROW_NUMBER() OVER (ORDER BY Salary DESC) AS RowNum,
    RANK() OVER (PARTITION BY DepartmentId ORDER BY Salary DESC) AS DeptRank,
    DENSE_RANK() OVER (PARTITION BY DepartmentId ORDER BY Salary DESC) AS DeptDenseRank
FROM Employees;
GO
-- Задание 24. Оконные агрегаты: SUM OVER, AVG OVER
SELECT 
    EmployeeName,
    DepartmentId,
    Salary,
    SUM(Salary) OVER (PARTITION BY DepartmentId) AS TotalDeptSalary,
    ROUND(AVG(Salary) OVER (PARTITION BY DepartmentId), 2) AS AvgDeptSalary,
    ROUND(Salary - AVG(Salary) OVER (PARTITION BY DepartmentId), 2) AS SalaryDiffFromAvg
FROM Employees;
GO

-- Задание 25. CTE (Common Table Expressions)

-- 1. Переписанный запрос из задания 12 (сотрудники с зарплатой выше средней) через WITH
WITH AvgSalaryCTE AS (
    SELECT AVG(Salary) AS AvgSal FROM Employees
)
SELECT 
    e.EmployeeName, 
    e.Salary 
FROM Employees e
CROSS JOIN AvgSalaryCTE c
WHERE e.Salary > c.AvgSal;
GO

-- 2. Дополнительно: CTE для поиска топ-3 отделов по средней зарплате
WITH DeptAvgSalary AS (
    SELECT 
        DepartmentId, 
        AVG(Salary) AS AvgSalary,
        ROW_NUMBER() OVER (ORDER BY AVG(Salary) DESC) AS rn
    FROM Employees
    GROUP BY DepartmentId
)
SELECT 
    DepartmentId, 
    ROUND(AvgSalary, 2) AS AvgSalary
FROM DeptAvgSalary
WHERE rn <= 3;
GO
USE PracticeDB;
GO
-- Задание 26. CASE: условная логика в SELECT
SELECT 
    EmployeeName,
    Salary,
    CASE 
        WHEN Salary > 60000 THEN 'High'
        WHEN Salary BETWEEN 40000 AND 60000 THEN 'Medium'
        ELSE 'Low'
    END AS SalaryLevel,
    HireDate,
    CASE 
        WHEN YEAR(HireDate) < 2020 THEN 'Senior'
        WHEN YEAR(HireDate) BETWEEN 2020 AND 2022 THEN 'Mid'
        ELSE 'Junior'
    END AS Tenure
FROM Employees;
GO
-- Задание 27. Работа с датами: DATEADD, DATEDIFF, FORMAT
SELECT 
    EmployeeName,
    HireDate,
   --Полных лет стажа
    DATEDIFF(YEAR, HireDate, GETDATE()) AS YearsOfService,
    -- Количество месяцев стажа
    DATEDIFF(MONTH, HireDate, GETDATE()) AS MonthsOfService,
    -- Дата ровно через 1 год после найма
    DATEADD(YEAR, 1, HireDate) AS OneYearAfterHire,
    -- Форматированная дата найма (дд.мм.гггг)
    FORMAT(HireDate, 'dd.MM.yyyy') AS FormattedHireDate
FROM Employees;
GO