-- find the most recent trades on opensea in the last 24 hours 
select * 
from opensea.trades
WHERE block_time > now() - interval '24 hours' AND amount_usd IS NOT NULL
;

