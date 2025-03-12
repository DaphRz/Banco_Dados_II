USE bank_cc3mc;

# ? 
SELECT fname NOME, lname SOBRENOME, name EMPRESA  # não precisa de f. e b. pois não há ambiguidade
FROM officer f, business b
WHERE f.cust_id = b.cust_id;

SELECT account_id, cust_id, avail_balance
FROM account
WHERE status = 'ACTIVE'
AND avail_balance > 2500;

SELECT account_id, city, CONCAT(fname,' ', lname) NOME, ac.cust_id, avail_balance
FROM account ac, customer c, individual i
WHERE status = 'ACTIVE' AND avail_balance > 2500
AND ac.cust_id = c.cust_id AND c.cust_id = i.cust_id;

SELECT CONCAT(fname,' ', lname) NOME
FROM employee
WHERE superior_emp_id IS NULL;

SELECT CONCAT(fname,' ', lname) NOME, name DEPARTAMENTO
FROM employee e, department d
WHERE d.dept_id = e.dept_id AND superior_emp_id IS NOT NULL;

SELECT CONCAT(fname, ' ', lname) NOME
FROM customer
WHERE lname REGEXP '[^ry]$';
