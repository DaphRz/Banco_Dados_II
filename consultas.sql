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

# Exercício 3
SELECT CONCAT(fname, ' ', lname) NOME
FROM individual
WHERE lname REGEXP '[^ry]$';   # WHERE lname NOT LIKE '%r' AND lname NOT LIKE '%y';

# Exercício 4 - a
SELECT dept_id, fname, lname, MIN(start_date)
FROM employee
GROUP BY dept_id;

# Exercício 4 - b
SELECT CONCAT(fname, ' ',lname) NOME, DATA.POSSE, e.dept_id
FROM employee e, (SELECT dept_id, MIN(start_date) POSSE
			     FROM employee
                 GROUP BY dept_id) DATA
WHERE e.start_date = DATA.POSSE AND e.dept_id = DATA.dept_id;
# GROUP BY e.dept_id; - ordem CRESC

# Exercício 5
SELECT 
	CONCAT(fname, ' ',lname) NOME, 
	DATA.MIN, 
    city
FROM customer c, individual i, 
								(SELECT cust_id, MIN(birth_date) MIN
								FROM individual
								GROUP BY cust_id) DATA
WHERE i.birth_date = DATA.MIN AND i.cust_id = DATA.cust_id
GROUP BY city;

# Exercício 5
/* SELECT CONCAT(fname, ' ',lname) NOME, MIN(birth_date), city
FROM individual i, (SELECT cust_id, MIN(birth_date) MIN
			     FROM individual i
                 GROUP BY cust_id) DATA, customer c
WHERE i.birth_date = DATA.MIN AND i.cust_id = DATA.cust_id
ORDER BY birth_date; */

# Exercício 6
SELECT name
FROM product
ORDER BY SUBSTRING_INDEX(name, ' ', -1);
