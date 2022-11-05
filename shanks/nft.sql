-- find the most recent trades on nft trades in the last 24 hours 
select * 
from nft.trades
WHERE block_time > now() - interval '24 hours' AND amount_usd IS NOT NULL
;