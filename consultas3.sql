USE bank_cc3mc;

# Índices e Restrições

# Exercício 1
SELECT account_id, amount, txn_type_cd
FROM transaction
WHERE txn_date = '2000-01-15';

CREATE INDEX txn_01                  -- CREATE INDEX dept_name_idx    
ON transaction(txn_date);            -- ON department(name);            

# Exercício 2
ALTER TABLE customer
ADD UNIQUE fed_id_unq (fed_id);

INSERT INTO customer(fed_id) VALUES(1);
INSERT INTO customer(fed_id) VALUES(1);     -- Error Code: 1062. Duplicate entry '1' for key 'customer.fed_id_unq'	0.000 sec

# Exercício 3
ALTER TABLE account
ADD UNIQUE cust_product_unq (cust_id,product_cd);

INSERT INTO account(cust_id,product_cd,open_date) VALUES(1,"carro",now());
INSERT INTO account(cust_id,product_cd) VALUES(1,"carro",now());

# Exercício 4
ALTER TABLE employee
ADD UNIQUE superior_dept_unq (superior_emp_id,dept_id);    -- Error Code: 1062. Duplicate entry '1-3' for key 'employee.superior_dept_unq'	0.031 sec
