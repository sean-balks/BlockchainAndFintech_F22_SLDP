-- Query 1, staked eth post merge. Takes about 15 seconds to run

with deposit as (
    select sum(value)/1e18 as total_deposit_eth ,
           count( distinct `from`) as total_depositors
    from ethereum.traces
    where block_time >= '2022-09-15'
    and `to`=lower('0x00000000219ab540356cBB839Cbe05303d7705Fa')
)
select * from deposit


-- nvm, there was no eth staked pre merge lol
-- Query 2, staked eth pre merge. Takes about 4 minutes to run
SELECT (SUM(value)/1e18) AS staked_eth
FROM ethereum.traces
WHERE block_time <= '2022-09-15 00:00'
AND `to`=lower('0x00000000219ab540356cBB839Cbe05303d7705Fa')
AND success
