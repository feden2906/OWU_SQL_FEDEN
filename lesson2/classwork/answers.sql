#  найти самого старого клиента
select * from client order by Age desc limit 1;

# посчитать количество кредитов каждой валюты
select count(idApplication), Currency from application group by Currency;

# Найти клиентов которые проживают в том же городе что и отделение банка
select * from client join department on client.City = department.DepartmentCity;

# Найти клиентов которые проживают в том же городе что и отделение банка но исключить из поиска Киев
select client.*, department.* from client
    join department on department.idDepartment = client.Department_idDepartment
    where client.city = department.departmentcity and client.city not in ('kyiv');

# найти прошлого запроса, клиента с самый больший долларовым кредитом
--select client.*, department.*, application.sum from client
--	join department on department.idDepartment = client.Department_idDepartment
--	join application on application.client_Idclient = client.idClient
--	where client.city = department.departmentcity and client.city not in ('kyiv') and application.currency = 'dollar'
--	group by application.sum
--	order by application.sum desc limit 1;

select * from client
	join application on client.idClient = application.Client_idClient
    where application.Sum = (select max(sum) from application) and Currency = 'Dollar';
