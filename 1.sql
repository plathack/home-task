select distinct c.tin,
sum
(
	case when t.type = 'loan' then t.amount else 0 end 
	- case when t.type = 'loan_repayment' then t.amount else 0 end
	+ case when t.type = 'interest' then t.amount else 0 end
	- case when t.type = 'interes_repayment' then t.amount else 0 end
) over(partition by t.customer_id) as portfolio,
sum
(
	case when t.type = 'loan' then t.amount else 0 end 
	- case when t.type = 'loan_repayment' then t.amount else 0 end
	+ case when t.type = 'interest' then t.amount else 0 end
	- case when t.type = 'interes_repayment' then t.amount else 0 end
) over(partition by t.customer_id) 
/ 
(select 
  sum(
	case when t.type = 'loan' then t.amount else 0 end 
	- case when t.type = 'loan_repayment' then t.amount else 0 end
	+ case when t.type = 'interest' then t.amount else 0 end
	- case when t.type = 'interes_repayment' then t.amount else 0 end
) from tbl_loan_transaction t) * 100 as percent
from tbl_customer c
inner join tbl_loan_transaction t 
on t.customer_id = c.id
group by c.tin, t.type, t.amount, t.customer_id
order by portfolio desc






