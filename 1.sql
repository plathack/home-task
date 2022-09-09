select c.tin,
sum 
(
	case 
	when t.type = 'loan' then t.amount 
	when t.type = 'loan_repayment' then -t.amount
	when t.type = 'interest' then t.amount
	when t.type = 'interes_repayment' then -t.amount 
	else 0 end
) as portfolio,
(sum 
(
	case 
	when t.type = 'loan' then t.amount 
	when t.type = 'loan_repayment' then -t.amount
	when t.type = 'interest' then t.amount
	when t.type = 'interes_repayment' then -t.amount 
	else 0 end
) 
/ 
sum(sum 
(
	case 
	when t.type = 'loan' then t.amount 
	when t.type = 'loan_repayment' then -t.amount
	when t.type = 'interest' then t.amount
	when t.type = 'interes_repayment' then -t.amount 
	else 0 end
)) over() * 100) as percent
from tbl_customer c
inner join tbl_loan_transaction t 
on t.customer_id = c.id
group by  c.tin
order by portfolio desc







