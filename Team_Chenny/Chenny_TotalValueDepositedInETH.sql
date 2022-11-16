with deposit as (
    select sum(value)/1e18 as total_deposit_eth ,
           count( distinct `from`) as total_depositors
    from ethereum.traces
    where block_time > '2020-10-14'
    and `to`=lower('0x00000000219ab540356cBB839Cbe05303d7705Fa')
)
select * from deposit
