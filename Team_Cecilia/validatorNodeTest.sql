-- SELECT date_trunc('day',block_time) AS day, ( SUM(value) ) AS total_staking_nodes
-- FROM ethereum.traces 
-- WHERE "to" = '\x00000000219ab540356cBB839Cbe05303d7705Fa'
-- AND success
-- AND value > 0
-- AND block_time > '2022-09-15'
-- group by day
-- ;

select date_trunc('day', block_time) AS day, ( SUM(value) / 1e18 )/32 AS total_staking_nodes
from ethereum.traces
-- where "to" = '\x00000000219ab540356cBB839Cbe05303d7705Fa'
where success
AND value > 0
AND block_time > '2022-09-15'
group by day
;