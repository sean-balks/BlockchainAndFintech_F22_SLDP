-- Queries from multiple ethereum tables and returns all the relevant information in a table called ranked_summary
-- for our purposes we are only returning the information for user participation on the day of the ethereum merge, 
-- 2022-09-15. Unfortunately we could not query for data over time because we are limited in the computing resources 
-- to query on dune analytics. The amount of information being pulled is over millions of data rows and beyond the capabilities
-- of my macbook pro that has stickers on it.

with ethereum_txns as (
SELECT 
    block_time,
    "from" as initiator,
    "to" as receiver,
    hash
FROM ethereum.transactions 
WHERE block_time > now() - interval '1 day'
),

contracts as (
SELECT 
    CASE WHEN namespace like '%uniswap%' THEN 'uniswap' 
    ELSE namespace END as project,
    address as contract_address
FROM ethereum.contracts
),

matched_txns as (
SELECT 
    *
FROM ethereum_txns t
LEFT JOIN contracts c
ON t.receiver = c.contract_address
),

contract_creation_record as (
SELECT 
    distinct address
FROM ethereum.traces
WHERE type = 'create'
AND tx_success = 'true' AND success = 'true'
AND address in (
    SELECT
        distinct receiver
    FROM matched_txns
    WHERE project is NULL)
    ),
    

labels as (
SELECT 
    address as "labeled_address",
    name as "labeled_owner"
FROM labels.labels
WHERE type like 'owner'
),
categorized_txns as (
SELECT 
    *,
    CASE WHEN project is NOT NULL THEN project
         WHEN project is NULL AND labeled_address is NOT NULL THEN labeled_owner
         WHEN project is NULL AND address is NOT NULL THEN 'unknown contract'
         WHEN project is NULL AND labeled_address is NULL and address is NULL THEN 'EOA'
    END as contract_type
FROM matched_txns m
LEFT JOIN contract_creation_record c
ON m.receiver = c.address
LEFT JOIN labels l 
ON m.receiver = l.labeled_address
),

project_stats as (
SELECT 
    contract_type as txn_counterparty,
    count(distinct initiator) as number_of_active_users,
    count(distinct hash) as number_of_txns
FROM categorized_txns
GROUP BY txn_counterparty
),

total_stats as (
SELECT
    sum(number_of_txns) as total_txns,
    sum(number_of_active_users) as total_users,
    (SELECT count(distinct hash) FROM matched_txns) as total_distinct_txns,
    (SELECT count(distinct initiator) FROM matched_txns) as total_distinct_users
FROM project_stats 
),
summary_stats as (
SELECT 
    p.*,
    1.0 * p.number_of_txns / (SELECT total_txns FROM total_stats) as "txn_market_share",
    1.0 * p.number_of_active_users / (SELECT total_users FROM total_stats) as "user_market_share",
    1.0 * p.number_of_txns / (SELECT total_distinct_txns FROM total_stats) as "txn_participation_rate",
    1.0 * p.number_of_active_users / (SELECT total_distinct_users FROM total_stats) as "user_participation_rate",
    (SELECT total_distinct_users FROM total_stats) as "total active wallets",
    (SELECT total_distinct_txns FROM total_stats) as "total ethereum txns"
FROM project_stats p
ORDER BY user_market_share DESC 
),

ranked_summary as (
SELECT 
    *,
    rank() OVER (order by user_market_share desc) as "user market share rank",
    rank() OVER (order by txn_market_share desc) as "txn market share rank"
FROM summary_stats )

SELECT date_trunc('day',block_time) as day, txn_participation_rate, user_participation_rate
from ethereum.traces natural join ranked_summary
where block_time > '2022-09-15'
limit 100
;