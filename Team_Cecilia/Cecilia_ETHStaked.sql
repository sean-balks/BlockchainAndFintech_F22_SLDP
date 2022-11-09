-- Run in Dune Engine v2
with staked as (
    select
    'Before Merge' as merged_type,
        date_trunc('day', block_time) as day,
        sum(value)/1e18 as staked_eth,
        count( distinct `from`) as depositors
    from ethereum.traces
    where block_time > '2022-06-15'
     and block_time <= '2022-09-15 00:00'
        and `to`=lower('0x00000000219ab540356cBB839Cbe05303d7705Fa')
    group by day
    
    union all 
    
       select 
       'After Merge' as merged_type,
        date_trunc('day', block_time) as day,
        sum(value)/1e18 as staked_eth ,
        count( distinct `from`) as depositors
    from ethereum.traces
    where block_time  >= '2022-09-14 00:00'
        and `to`=lower('0x00000000219ab540356cBB839Cbe05303d7705Fa')
    group by day
)
select 
    day,merged_type, staked_eth,depositors,
    sum(staked_eth) over (order by day) as cumulate_staked_eth,
    sum(depositors) over (order by day) as cumulate_depositors
from staked