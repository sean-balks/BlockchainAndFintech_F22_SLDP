-- find the most recent trades on nft trades in the last 24 hours 
select * 
from nft.trades
WHERE block_time > now() - interval '24 hours' AND amount_usd IS NOT NULL
;

-- find the most recent nft trades in the last 44 days (time since Sept 22nd) that is ethereum 
select * 
from nft.trades
WHERE block_time > now() - interval '44 days'
AND amount_usd is NOT NULL
AND blockchain == 'ethereum'
limit 100
;