SELECT SUM(value)/1e18 AS total_deposited_eth
FROM ethereum.traces
WHERE "to" = '\x00000000219ab540356cBB839Cbe05303d7705Fa'
AND success
AND value > 0