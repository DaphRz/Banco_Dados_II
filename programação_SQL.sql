USE bank;

DELIMITER $$
CREATE PROCEDURE
transferir (IN valor DECIMAL(7, 2), IN remetante INT, IN destinatario INT)
BEGIN
INSERT INTO transaction
(txn_id ,txn_date, account_id, txn_type_cd, amount, funds_avail_date)
VALUES (null,now(),remetante, 'DBT', valor,now());
UPDATE account
SET avail_balance = avail_balance - valor, last_activity_date = now()
WHERE account_id = remetante;
INSERT INTO transaction
(txn_id ,txn_date, account_id, txn_type_cd, amount, funds_avail_date)
VALUES (null,now(),destinatario, 'CDT', valor, now());
UPDATE account
SET avail_balance = avail_balance + valor, last_activity_date = now()
WHERE account_id = destinatario;
END $$
DELIMITER ;

-- ? CALL transferir(500.00,11,10);
-- ? SELECT account_id, avail_balance FROM account WHERE account_id IN (10,11);

DELIMITER $$
CREATE PROCEDURE render (IN taxa DECIMAL(3,2))
BEGIN
UPDATE account
SET avail_balance = avail_balance + avail_balance*0.01*taxa;
END $$
DELIMITER ;

-- terminar aqui em bx
SELECT avail_balance FROM 
CALL (render

  -- Triggers
  
# Exercício 5

DELIMITER $$
CREATE TRIGGER t AFTER INSERT ON transaction FOR EACH ROW
BEGIN
UPDATE account SET
avail_balance = IF(NEW.txn_type_cd = 'DBT', avail_balance - (NEW.amount * 1.01), 
avail_balance + NEW.amount)
WHERE account_id = NEW.account_id;
END $$

SELECT avail_balance FROM account WHERE account_id = 23;

INSERT INTO transaction
(txn_id ,txn_date, account_id, txn_type_cd, amount, funds_avail_date)
VALUES (null,now(),23, 'DBT', 1, now());

SELECT avail_balance, account_id FROM account;
# show triggers;
# DROP TRIGGER CHK;

# Exercício 6

DELIMITER $$
CREATE TRIGGER CHK 
AFTER INSERT ON customer 
FOR EACH ROW
BEGIN
    INSERT INTO account (cust_id, product_cd, open_date)
    VALUES (NEW.cust_id, 'CHK', now());
END $$

INSERT INTO customer (fed_id) -- identificador federal
VALUES ("857");

SELECT account_id, product_cd, cust_id, open_date
FROM account
ORDER BY 1 DESC
LIMIT 1;

# Exercício 7

-- Gatilho disparado quando um registro de employee é modificado

USE bank;
SHOW triggers;
DROP TRIGGER t_DBT;

CREATE TABLE log_employee_1 (
log_id SMALLINT AUTO_INCREMENT,
user VARCHAR(100) NOT NULL,
fname VARCHAR(100) NOT NULL,
lname VARCHAR(100) NOT NULL,
date_log DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
emp_id SMALLINT(5),
old_sup SMALLINT(5),
new_sup SMALLINT(5),
CONSTRAINT pk_log_employee PRIMARY KEY (log_id)
);

DELIMITER $$
CREATE TRIGGER trg_emp_1 
AFTER UPDATE ON employee 
FOR EACH ROW
BEGIN
INSERT INTO log_employee_1(user, fname, lname, emp_id, old_sup, new_sup)
VALUES(USER(), CONCAT(NEW.fname, " ",NEW.lname), NEW.emp_id, OLD.superior_emp_id,NEW.superior_emp_id);
END $$

UPDATE employee
SET superior_emp_id = 2
WHERE emp_id = 3;

UPDATE employee
SET superior_emp_id = 3
WHERE emp_id = 1;

SELECT *
FROM log_employee_1;

# Exercício 8

DELIMITER $$

CREATE TRIGGER t_DBT 
BEFORE INSERT ON transaction 
FOR EACH ROW
BEGIN
	DECLARE saldo_atual DOUBLE;
		SELECT avail_balance 
        INTO saldo_atual
		FROM account
		WHERE account_id = NEW.account_id;
        
	IF (NEW.txn_type_cd = 'DBT' AND saldo_atual < NEW.amount)
		THEN
		SIGNAL SQLSTATE '02000'
		SET MESSAGE_TEXT = "Retire um valor menor que seu saldo!";
	END IF;

END $$

DELIMITER ;

SELECT avail_balance 
FROM account
WHERE account_id = 23;

INSERT INTO transaction
(txn_id ,txn_date, account_id, txn_type_cd, amount, funds_avail_date)
VALUES (null,now(),23, 'DBT', 1600, now());
