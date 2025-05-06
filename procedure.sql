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