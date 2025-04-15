USE bank_cc3mc;

# Índices e Restrições

# Exercício 1
SELECT account_id, amount, txn_type_cd
FROM transaction
WHERE txn_date = '2000-01-15';

CREATE INDEX txn_01                  -- CREATE INDEX dept_name_idx    
ON transaction(txn_date);            -- ON department(name);            