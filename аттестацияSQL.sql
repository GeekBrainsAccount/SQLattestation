/*1. Создайте функцию, которая принимает кол-во сек и формат их в кол-во дней часов.
Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '*/

/*Путь решения: идем справа налево, сначала находим количество секунд, меньшее минуты, записываем,
оставшееся приводим к целому количеству минут и т.д.*/

DROP FUNCTION IF EXISTS SecToDateTime;

DELIMITER $$
CREATE FUNCTION SecToDateTime(num INT)
RETURNS VARCHAR(400)
DETERMINISTIC
BEGIN
	DECLARE temp INT DEFAULT 0;
	DECLARE res VARCHAR(400) DEFAULT '';
    
    SET temp = num % 60;
    SET res = CONCAT(temp, ' seconds.',  res);
    SET num = (num - temp) / 60; -- minutes left
    SET temp = num % 60;
    SET res = CONCAT(temp, ' minutes ',  res);
    SET num = (num - temp) / 60; -- hours left
	SET temp = num % 24;
    SET res = CONCAT(temp, ' hours ',  res);
    SET num = (num - temp) / 24; -- days left
    SET res = CONCAT(num, ' days ',  res);
    SET num = num - temp;

	RETURN res;
END
$$ DELIMITER ;

SELECT SecToDateTime(1234567890);

SELECT SecToDateTime(0);

SELECT SecToDateTime(25673);

SELECT SecToDateTime(2582);

/*2. Выведите только чётные числа от 1 до 10.
Пример: 2,4,6,8,10. Решать через процедуру.*/

/*Путь решения: проверяем на четность и выводим. Если чило не последнее, тогда после пишем запятиую.
Это лишняя проверка, но если нужно точно как в примере, то так.*/

DROP PROCEDURE IF EXISTS OutputEven;

DELIMITER $$
CREATE PROCEDURE OutputEven()
BEGIN
DECLARE num INT DEFAULT 1;
DECLARE res VARCHAR(100) DEFAULT '';
	WHILE num <= 10 DO
		IF num % 2 = 0 THEN
			SET res = CONCAT(res, num);
			IF num < 10 THEN SET res = CONCAT(res, ',');
			END IF;
		END IF;
        SET num = num + 1;
	END WHILE;
    SELECT res;
	END
$$ DELIMITER ;

CALL OutputEven();
