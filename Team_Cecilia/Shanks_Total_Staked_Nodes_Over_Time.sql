
-- Deposit is the total_staking_nodes over the time period post merge
-- avg price is the average price of ethereum over the time period post merge
with staking_nodes as (
    select date_trunc('day', block_time) as day, (sum(value)/1e18)/32 as total_staking_nodes
    from ethereum.traces
    where block_time >= '2022-09-15'
    and `to`=lower('0x00000000219ab540356cBB839Cbe05303d7705Fa')
    group by day
),
eth_price as (
    SELECT date_trunc('day', minute) as day
    , AVG(price)
    FROM prices.usd
    WHERE symbol='ETH'
    AND minute > '2022-09-15'
    GROUP BY day
    )
select * from staking_nodes natural join eth_price