with address_age as (
    select `to` as wallet_address,
        cast(datediff(getdate(), min(block_time))/365.25 as int) as wallet_age
    from ethereum.transactions
    group by 1
    order by 2
)

select count(*) as wallet_number,
    wallet_age as age
from address_age
group by 2
order by 2 asc