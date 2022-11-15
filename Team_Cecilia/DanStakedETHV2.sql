-- Query 1, staked eth post merge

SELECT (SUM(value)/1e18) AS staked_eth
FROM ethereum.traces
WHERE block_time >= '2022-09-15 00:00'
AND `to`=lower('0x00000000219ab540356cBB839Cbe05303d7705Fa')
AND success


-- Query 2, staked eth pre merge
SELECT (SUM(value)/1e18) AS staked_eth
FROM ethereum.traces
WHERE block_time <= '2022-09-15 00:00'
AND `to`=lower('0x00000000219ab540356cBB839Cbe05303d7705Fa')
AND success
