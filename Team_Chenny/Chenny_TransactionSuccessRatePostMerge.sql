with success as (
    select count(*) as success_count
    from ethereum.transactions
    where success
        and block_number >= 15537393
),

total as (
    select count(*) as total_count
    from ethereum.transactions
    where block_number >= 15537393
)

select success.success_count / total.total_count * 100 as success_rate
from success, total
