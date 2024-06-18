With acc_info as (
select * 
, value AS acc_holder_id
FROM pd2023_wk07_account_information, LATERAL SPLIT_TO_TABLE(account_holder_id,', ') AS acc_holder_id
)
SELEct 
 ai.account_number
, acc_holder_id
, tp.transaction_id
, account_to
, transaction_date
, td.value as transaction_value
, ai.account_type
, balance_date
, balance
, name
, date_of_birth
, contact_number
, first_line_of_address
from pd2023_wk07_transaction_path as tp
join pd2023_wk07_transaction_detail as td on tp.TRANSACTION_ID = td.TRANSACTION_ID
left join acc_info AS ai on tp.account_from = ai.account_number
join pd2023_wk07_account_holders as ah on ah.account_holder_id = acc_holder_id
where cancelled_ = 'N' AND ai.ACCOUNT_TYPE != 'Platinum'
having td.value > 1000