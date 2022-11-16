with tx_daily as (
    select 'Before Merge' as merged_type,
        date_trunc('day', block_time) as time
        , count(*) as tx_count
    from ethereum.transactions
    where block_time >= '2022-08-15 00:00'
        and block_time <= '2022-09-15 00:00'
        -- and block_number <= 15537392 -- Merge block number
    group by 1, 2

    union all

    select 'After Merge' as merged_type,
        date_trunc('day', block_time) as time
        , count(*) as tx_count
    from ethereum.transactions
    where block_time >= '2022-09-14 00:00'
        -- and block_number >= 15537392 -- Merge block number
    group by 1, 2
)

select * from tx_daily
