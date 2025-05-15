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
