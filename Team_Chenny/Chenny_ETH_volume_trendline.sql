with txs AS
(
    SELECT 
        block_time, 
        value
    FROM ethereum.transactions 
    WHERE ethereum.transactions.block_time > now() - interval '3 months'
)
SELECT 
    date_trunc('day', block_time) AS Date, 
    SUM(value/ 1e18) AS Value 
FROM txs
GROUP by 1 order by 1
