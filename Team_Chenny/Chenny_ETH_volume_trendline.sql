with txs AS
(
    SELECT 
        block_time, 
        value, 
        price
    FROM ethereum."transactions" eTX
    JOIN prices."layer1_usd" P
    ON P.minute = date_trunc('minute', eTX.block_time)
    WHERE block_time > now() - interval '3 months'
    and symbol = 'ETH'
)
SELECT 
    date_trunc('day', block_time) AS "Date", 
    SUM(value * price / 1e18) AS "Value" 
FROM txs
GROUP by 1 order by 1
