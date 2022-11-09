select
  date_trunc('day', time) as time_,
  count(distinct number) as block_count,
  86400 / count(distinct number) as avg_block_time
from
  ethereum.blocks
where
  time >= '2022-06-15 00:00'
group by
  time_
