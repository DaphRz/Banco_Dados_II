USE bank_si3n;

# Junções

# 01
SELECT fname, lname, branch_id, name
FROM employee JOIN branch
ON assigned_branch_id = branch_id;

# 02
SELECT emp_id, fname, lname, name department
FROM employee JOIN department
USING(dept_id)
ORDER BY emp_id; 

# 03
SELECT account_id
FROM account, employee WHERE CONCAT(fname, ' ', lname) = 'Michael Smith'
AND open_date > start_date ;

# 03.1
SELECT account_id, CONCAT(i.fname, ' ', i.lname) name
FROM account 
JOIN employee e ON open_date > start_date
JOIN individual i USING(cust_id)
WHERE CONCAT(e.fname, ' ', e.lname) = 'Michael Smith';

# 04
SELECT name branch, CONCAT(fname, ' ', lname) name
FROM branch b JOIN customer c
ON b.city != c.city
JOIN individual USING(cust_id);

# Junções Internas

SELECT account_id, name, fed_id, birth_date
FROM product 
JOIN account USING (product_cd)
JOIN customer USING (cust_id)
JOIN individual USING(cust_id);

# 5
SELECT e.emp_id, e.fname, e.lname
FROM employee e
JOIN employee em ON e.superior_emp_id = em.emp_id
WHERE e.dept_id != em.dept_id;

# 5.1
SELECT fname, lname, b.name, city, avail_balance, p.name
FROM officer NATURAL JOIN business b NATURAL JOIN customer NATURAL JOIN account
JOIN product p USING (product_cd);
