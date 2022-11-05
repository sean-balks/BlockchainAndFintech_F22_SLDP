-- find the most recent trades on opensea in the last 7 days 
select * 
from opensea.trades
WHERE block_time > now() - interval '7 days' AND amount_usd IS NOT NULL
;

