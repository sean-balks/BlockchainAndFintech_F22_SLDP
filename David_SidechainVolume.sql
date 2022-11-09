with 
tx_daily_gnosis as (
  select
    'Before Merge - Gnosis' as merged_type,
    date_trunc('day', block_time) as time,
    count(*) as tx_count
  from
    gnosis.transactions
  where
    block_time >= '2022-08-15 00:00'
    and block_time <= '2022-09-15 00:00' --and block_number <= 15537392 -- Merge block number
  group by
    1,
    2
  union all
  select
    'After Merge - Gnosis' as merged_type,
    date_trunc('day', block_time) as time,
    count(*) as tx_count
  from
    gnosis.transactions
  where
    block_time <= '2022-10-15 11:59'
    and block_time >= '2022-09-14 00:00' --and block_number >= 15537392 -- Merge block number
  group by
    1,
    2
), tx_daily_polygon as (
    select
      'Before Merge - Polygon' as merged_type,
      date_trunc('day', block_time) as time,
      count(*) as tx_count
    from
      polygon.transactions
    where
      block_time >= '2022-08-15 00:00'
      and block_time <= '2022-09-15 00:00' --and block_number <= 15537392 -- Merge block number
    group by
      1,
      2
    union all
    select
      'After Merge - Polygon' as merged_type,
      date_trunc('day', block_time) as time,
      count(*) as tx_count
    from
      polygon.transactions
    where
      block_time <= '2022-10-15 11:59'
      and block_time >= '2022-09-14 00:00' --and block_number >= 15537392 -- Merge block number
    group by
      1,
      2
  )
select * from tx_daily_gnosis 
union all 
select * from tx_daily_polygon
  
