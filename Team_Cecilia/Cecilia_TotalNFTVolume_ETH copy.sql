-- Run in Ethereum engine
-- from 2022/06/15 to now
WITH nft_vol_eth as (
SELECT 
'Before ETH Merge' as merged_type,
date_trunc('day', block_time) as day,
    SUM(usd_amount) as usd_amount
FROM 
(SELECT * FROM nft.trades where original_currency= 'ETH' OR original_currency= 'WETH') as eth
WHERE block_time  >= '2022-08-26 00:00'
        and block_time <= '2022-09-15 00:00'
AND buyer != seller
GROUP BY day 

union all

SELECT 
'After ETH Merge' as merged_type,
date_trunc('day', block_time) as day,
    SUM(usd_amount) as usd_amount
FROM 
(SELECT * FROM nft.trades where original_currency= 'ETH' OR original_currency= 'WETH') as eth
WHERE block_time  >= '2022-09-14 00:00'
AND buyer != seller
GROUP BY day 

ORDER BY day

)
select * from nft_vol_eth

