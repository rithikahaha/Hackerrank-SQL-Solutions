# 11. New Companies

[HackerRank link](https://www.hackerrank.com/challenges/the-company/problem)

## What it's asking
Five tables describe a company hierarchy: `Company` (company_code,
founder), `Lead_Manager` (lead_manager_code, company_code),
`Senior_Manager` (senior_manager_code, lead_manager_code, company_code),
`Manager` (manager_code, senior_manager_code, lead_manager_code,
company_code), and `Employee` (employee_code, manager_code,
senior_manager_code, lead_manager_code, company_code).

For each company, print its code, founder, and the count of *distinct*
lead managers, senior managers, managers, and employees. Order by company
code (as plain text, not as a number — so `C_10` sorts after `C_1` but
before `C_2`).

## Steps
1. Join all five tables together on `company_code`.
2. Because a company can have many lead managers, and each lead manager
   can have many senior managers, and so on, joining everything together
   multiplies the rows — a single employee might get repeated once for
   every combination further up the chain. Counting naively would
   overcount.
3. Use `COUNT(DISTINCT column)` for each count, so repeated codes (caused
   by the join fan-out) only get counted once.
4. Group by company, and let the default text sort on `company_code`
   handle the ordering — text sorting already compares character by
   character, which is what the problem wants.

## Code
```sql
SELECT
  c.company_code,
  c.founder,
  COUNT(DISTINCT lm.lead_manager_code),
  COUNT(DISTINCT sm.senior_manager_code),
  COUNT(DISTINCT m.manager_code),
  COUNT(DISTINCT e.employee_code)
FROM Company c
JOIN Lead_Manager lm ON c.company_code = lm.company_code
JOIN Senior_Manager sm ON c.company_code = sm.company_code
JOIN Manager m ON c.company_code = m.company_code
JOIN Employee e ON c.company_code = e.company_code
GROUP BY c.company_code, c.founder
ORDER BY c.company_code;
```

## Walkthrough
- Joining five tables on a shared `company_code` produces a wide,
  repetitive table — every lead manager row gets matched against every
  senior manager row for the same company, and so on. This is why plain
  `COUNT(*)` would give wildly inflated numbers here.
- `COUNT(DISTINCT lm.lead_manager_code)` only counts each *unique* lead
  manager code once, no matter how many times it got duplicated by the
  join — this is the key fix that makes the multi-table join usable.
- Text columns sort character by character by default, which is exactly
  why `C_10` naturally lands between `C_1` and `C_2` without any special
  handling — the note in the problem statement is really just confirming
  that default behavior, not asking for something extra.
