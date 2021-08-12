# 1. +Вибрати усіх клієнтів, чиє ім'я має менше ніж 6 символів.
SELECT *
FROM client
WHERE LENGTH(FirstName) < 6;

# 2. +Вибрати львівські відділення банку.+
SELECT *
FROM department
WHERE DepartmentCity = 'Lviv';

# 3. +Вибрати клієнтів з вищою освітою та посортувати по прізвищу.
SELECT *
FROM client
WHERE Education = 'high'
ORDER BY LastName;

# 4. +Виконати сортування у зворотньому порядку над таблицею Заявка і вивести 5 останніх елементів.  ?????
SELECT *
FROM application
ORDER BY idApplication DESC
LIMIT 5 OFFSET 10;

# 5. +Вивести усіх клієнтів, чиє прізвище закінчується на OV чи OVA.
SELECT *
FROM client
WHERE LastName LIKE '%IV'
   OR LastName LIKE '%A';

# 6. +Вивести клієнтів банку, які обслуговуються київськими відділеннями.
SELECT c.LastName, c.FirstName, d.DepartmentCity
FROM client c
         JOIN department d ON c.Department_idDepartment = d.idDepartment
WHERE d.DepartmentCity = 'Kyiv';

# 7. +Вивести імена клієнтів та їхні номера телефону, погрупувавши їх за іменами.
SELECT c.FirstName, c.Passport
FROM client c
ORDER BY FirstName;

# 8. +Вивести дані про клієнтів, які мають кредит більше ніж на 5000 тисяч гривень.
SELECT c.LastName, c.FirstName, a.CreditState, a.Sum, a.Currency
FROM client c
         JOIN application a ON c.idClient = a.Client_idClient
WHERE Sum > 5000
  AND CreditState = 'Not returned'
  AND Currency = 'Gryvnia';

# 9. +Порахувати кількість клієнтів усіх відділень та лише львівських відділень.  ?????
SELECT COUNT(idClient) AS allClients
FROM client
UNION
SELECT COUNT(FirstName) AS LvivClients
FROM client c
         JOIN department d ON c.Department_idDepartment = d.idDepartment
WHERE d.DepartmentCity = 'Lviv';

# 10. Знайти кредити, які мають найбільшу суму для кожного клієнта окремо.
SELECT FirstName, LastName, MAX(Sum) maxSum
FROM application
         JOIN client ON idClient = application.Client_idClient
GROUP BY idClient;

# 11. Визначити кількість заявок на крдеит для кожного клієнта.
SELECT COUNT(idClient), FirstName, LastName
FROM client c
         JOIN application a ON c.idClient = a.Client_idClient
GROUP BY idClient;

# 12. Визначити найбільший та найменший кредити.
SELECT MAX(Sum) AS max, MIN(Sum) AS min
FROM application;

# 13. Порахувати кількість кредитів для клієнтів,які мають вищу освіту.
SELECT SUM(Client_idClient) AS creditNum, FirstName, LastName, Education
FROM application a
         JOIN client c ON c.idClient = a.Client_idClient
         JOIN department d ON d.idDepartment = c.idClient
WHERE Education = 'high'
GROUP BY idClient;

# 14. Вивести дані про клієнта, в якого середня сума кредитів найвища.
SELECT AVG(Sum) AS AVGsum, FirstName, LastName, Education, Passport, City, Age, DepartmentCity
FROM client c
         JOIN application a ON c.idClient = a.Client_idClient
         JOIN department d ON d.idDepartment = c.Department_idDepartment
GROUP BY idClient
ORDER BY AVGsum DESC
LIMIT 1;

# 15. Вивести відділення, яке видало в кредити найбільше грошей
SELECT SUM(Sum) AS borrowSum, DepartmentCity
FROM application a
         JOIN client c ON c.idClient = a.Client_idClient
         JOIN department d ON d.idDepartment = c.Department_idDepartment
GROUP BY idDepartment
ORDER BY borrowSum DESC
LIMIT 1;

# 16. Вивести відділення, яке видало найбільший кредит.
SELECT MAX(Sum) AS maxCredit, idDepartment, DepartmentCity
FROM application a
         JOIN client c ON a.Client_idClient = c.idClient
         JOIN department d on d.idDepartment = c.Department_idDepartment
# GROUP BY idDepartment
# ORDER BY maxCredit DESC
# LIMIT 1;

# 17. Усім клієнтам, які мають вищу освіту, встановити усі їхні кредити у розмірі 6000 грн.
UPDATE application a
    JOIN client c on a.Client_idClient = c.idClient
SET Sum = 6000
WHERE c.Education = 'high';

# 18. Усіх клієнтів київських відділень пересилити до Києва.
UPDATE client c
    JOIN department d on d.idDepartment = c.Department_idDepartment
    JOIN application a on c.idClient = a.Client_idClient
SET City = 'Kyiv'
WHERE Department_idDepartment IN (SELECT idDepartment FROM department WHERE DepartmentCity = 'Kyiv');

# 19. Видалити усі кредити, які є повернені.
DELETE
FROM application
WHERE CreditState = 'Returned';

# 20. Видалити кредити клієнтів, в яких друга літера прізвища є голосною.
DELETE
FROM application
WHERE Client_idClient IN (
    SELECT idClient
    FROM client
    WHERE LastName LIKE '_a%'
       OR LastName LIKE '_e%'
       OR LastName LIKE '_o%'
       OR LastName LIKE '_y%'
       OR LastName LIKE '_i%'
       OR LastName LIKE '_u%');






# Знайти львівські відділення, які видали кредитів на загальну суму більше ніж 5000
SELECT SUM(Sum) AS creditSum
FROM application
         JOIN client c on c.idClient = application.Client_idClient
         JOIN department d on d.idDepartment = c.Department_idDepartment
WHERE DepartmentCity = 'Lviv'
  AND Sum > 5000
GROUP BY idDepartment;

# Знайти клієнтів, які повністю погасили кредити на суму більше ніж 5000
SELECT SUM(Sum) AS creditSum, idClient, FirstName, LastName, Passport
FROM application a
         JOIN client c ON c.idClient = a.Client_idClient
WHERE a.CreditState = 'Returned'
GROUP BY c.idClient
HAVING creditSum > 5000;

# Знайти максимальний неповернений кредит.
SELECT MAX(Sum) AS creditSum
FROM application
WHERE CreditState = 'Not returned';

# Знайти клієнта, сума кредиту якого найменша
SELECT SUM(Sum) AS creditSum, FirstName, LastName, Passport, City
FROM application
         JOIN client c ON c.idClient = application.Client_idClient
GROUP BY idClient
ORDER BY creditSum
LIMIT 1;

# Знайти кредити, сума яких більша за середнє значення усіх кредитів
SELECT idApplication, CreditState, Sum, Currency
FROM application
WHERE Sum > (SELECT AVG(Sum) FROM application);

# Знайти клієнтів, які є з того самого міста, що і клієнт, який взяв найбільшу кількість кредитів
SELECT DISTINCT idClient, LastName, FirstName, Passport
FROM client c
         JOIN application a ON a.Client_idClient = c.idClient
WHERE c.City = (SELECT City
                FROM client c2
                         JOIN application a2 ON a2.Client_idClient = c2.idClient
                GROUP BY idClient
                ORDER BY COUNT(a2.Client_idClient) DESC
                LIMIT 1);

# місто чувака який набрав найбільше кредитів
SELECT COUNT(Client_idClient) AS creditCount, c.City, c.idClient, c.FirstName, c.LastName
FROM application a
         JOIN client c ON c.idClient = a.Client_idClient
GROUP BY c.idClient
ORDER BY creditCount DESC
LIMIT 1;





1. +Вибрати усіх клієнтів, чиє ім'я має менше ніж 6 символів.
2. +Вибрати львівські відділення банку.+
3. +Вибрати клієнтів з вищою освітою та посортувати по прізвищу.
4. +Виконати сортування у зворотньому порядку над таблицею Заявка і вивести 5 останніх елементів.
5. +Вивести усіх клієнтів, чиє прізвище закінчується на OV чи OVA.
6. +Вивести клієнтів банку, які обслуговуються київськими відділеннями.
7. +Вивести імена клієнтів та їхні номера телефону, погрупувавши їх за іменами.
8. +Вивести дані про клієнтів, які мають кредит більше ніж на 5000 тисяч гривень.
9. +Порахувати кількість клієнтів усіх відділень та лише львівських відділень.
10. Знайти кредити, які мають найбільшу суму для кожного клієнта окремо.
11. Визначити кількість заявок на крдеит для кожного клієнта.
12. Визначити найбільший та найменший кредити.
13. Порахувати кількість кредитів для клієнтів,які мають вищу освіту.
14. Вивести дані про клієнта, в якого середня сума кредитів найвища.
15. Вивести відділення, яке видало в кредити найбільше грошей
16. Вивести відділення, яке видало найбільший кредит.
17. Усім клієнтам, які мають вищу освіту, встановити усі їхні кредити у розмірі 6000 грн.
18. Усіх клієнтів київських відділень пересилити до Києва.
19. Видалити усі кредити, які є повернені.
20. Видалити кредити клієнтів, в яких друга літера прізвища є голосною.

***
Знайти львівські відділення, які видали кредитів на загальну суму більше ніж 5000
Знайти клієнтів, які повністю погасили кредити на суму більше ніж 5000
Знайти максимальний неповернений кредит
Знайти клієнта, сума кредиту якого найменша
Знайти кредити, сума яких більша за середнє значення усіх кредитів
Знайти клієнтів, які є з того самого міста, що і клієнт, який взяв найбільшу кількість кредитівмісто чувака який набрав найбільше кредитів
