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