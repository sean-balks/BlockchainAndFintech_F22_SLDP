-- Only works if you are on the Ethereum engine
SELECT date_trunc('day',block_time) AS day, ( SUM(value) / 1e18 )/32 AS total_staking_nodes 
FROM ethereum.traces
WHERE "to" = '\x00000000219ab540356cBB839Cbe05303d7705Fa'
AND success
AND value > 0
AND block_time > '2022-09-15'
group by day
;