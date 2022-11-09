-- find the most recent nft trades in the last 44 days (time since Sept 22nd) that is ethereum 
select * 
from nft.trades
WHERE block_time > now() - interval '44 days'
AND amount_usd is NOT NULL
AND blockchain == 'ethereum'
limit 100
;