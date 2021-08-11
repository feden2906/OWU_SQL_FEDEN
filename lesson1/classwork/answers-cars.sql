--найти все машины старше 2000 г
SELECT * FROM cars where year > 2000;

--найти все машины младше 2015 г
SELECT * FROM cars where year < 2015;

--найти все машины 2008, 2009, 2010 годов
SELECT * FROM cars where year in(2008,2009,2010);

--найти все машины не с этих годов 2008, 2009, 2010 годов
SELECT * FROM cars where year not in(2008,2009,2010);

--найти все машины год которых совпадает с ценой
SELECT * FROM cars where year = price;

--найти все машины bmw старше 2014 года
SELECT * FROM cars where model = 'bmw' and year > 2014;

--найти все машины audi младше 2014 года
SELECT * FROM cars where model = 'audi' and year < 2014;

--найти первые 5 машин
SELECT * FROM cars order by id limit 5;

--найти последние 5 машин
SELECT * FROM cars order by id desc limit 5;

--найти среднее арифметическое цен машин модели KIA
SELECT avg(price) from cars where model = 'kia';

--найти среднее арифметическое цен каждой машины
SELECT avg(price), model from cars group by model;

--посчитать количество каждой марки машин
SELECT count(model), model from cars group by model;

--найти марку машины количество которых больше всего
SELECT count(model) as count, model from cars group by model order by count desc limit 1;

--найти все машины в модели которых вторая и предпоследняя буква "а"
SELECT * FROM cars where model like '_a%' and '%a_';
--SELECT * FROM cars where model like '_a%a_';

--найти все машины модели которых больше 8 символов
SELECT * FROM cars where length(model) > 8;

--***найти машины цена которых больше чем цена среднего арифметического всех машин
SELECT * FROM cars where price > (select avg(price) from cars);





найти все машины старше 2000 г
найти все машины младше 2015 г
найти все машины 2008, 2009, 2010 годов
найти все машины не с этих годов 2008, 2009, 2010 годов
найти все машины год которых совпадает с ценой
найти все машины bmw старше 2014 года
найти все машины audi младше 2014 года
найти первые 5 машин
найти последние 5 машин
найти среднее арифметическое цен машин модели KIA
найти среднее арифметическое цен каждой машины
посчитать количество каждой марки машин
найти марку машины количество которых больше всего
найти все машины в модели которых вторая и предпоследняя буква "а"
найти все машины модели которых больше 8 символов
***найти машины цена которых больше чем цена среднего арифметического всех машин
