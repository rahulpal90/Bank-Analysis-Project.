-- finance2 : id, delinq_2yrs, earliest_cr_line, inq_last_6mths, mths_since_last_delinq, 
-- mths_since_last_record, open_acc, pub_rec, revol_bal, revol_util, total_acc, initial_list_status, 
-- out_prncp, out_prncp_inv, total_pymnt, total_pymnt_inv, total_rec_prncp, total_rec_int, total_rec_late_fee, recoveries, collection_recovery_fee, 
-- last_pymnt_d, last_pymnt_amnt, next_pymnt_d, last_credit_pull_d


-- finance1: id, member_id, loan_amnt, funded_amnt, funded_amnt_inv, term, int_rate, installment,
-- grade, sub_grade, emp_title, emp_length, home_ownership, annual_inc, verification_status, 
-- issue_d, loan_status, pymnt_plan, desc, purpose, title, zip_code, addr_state, dti

-- 1. Year wise loan amount Stats

select * from f1;
select * from f2;

select year(issue_d) as Years, count(loan_amnt) as count_loan, sum(loan_amnt) as total_loan, 
max(loan_amnt) as max_loan, min(loan_amnt) as min_loan, round(avg(loan_amnt),2) as avg_loan, 
round(stddev(loan_amnt),2) as loan_deviation
from f1
group by year(issue_d)
order by years;

-- Grade and sub grade wise revol_bal

select * from f1;
select * from f2;

select grade, sub_grade, sum(revol_bal) total_revol, round(avg(revol_bal),2) avg_revol, 
round(max(revol_bal),2) max_revol
from f1 inner join f2
on f1.id = f2.id
group by grade, sub_grade
order by avg_revol desc;
 

-- 3. Total Payment for Verified Status Vs Total Payment for Non Verified Status

select verification_status, count(total_pymnt) as total_count, 
round(sum(total_pymnt),2) as total_payment 
from f1 inner join f2
on f1.id = f2.id
group by verification_status
order by total_payment desc;


-- 4. State wise and last_credit_pull_d wise loan status

select * from f1;
select * from f2;

select addr_state, loan_status, count(loan_status) as loan_count
from f1 inner join f2
on f1.id = f2.id
group by addr_state, loan_status
order by loan_count desc;

select year(last_credit_pull_d) as last_credit, loan_status, count(loan_status) as loan_count
from f1 inner join f2
on f1.id = f2.id
group by year(last_credit_pull_d), loan_status
order by loan_count desc;


-- 5. Home ownership Vs last payment date stats

select year(last_pymnt_d) last_payment, home_ownership, count(home_ownership) as home_count
from f1 inner join f2
on f1.id = f2.id
group by year(last_pymnt_d), home_ownership
order by home_count desc;

