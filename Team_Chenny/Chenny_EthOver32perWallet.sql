WITH
  transfers AS (
    SELECT
      DAY,
      address,
      token_address,
      sum(amount) AS amount
    FROM
      (
        SELECT
          date_trunc('day', evt_block_time) AS DAY,
          "to" AS address,
          tr.contract_address AS token_address,
          value AS amount
        FROM
          erc20."ERC20_evt_Transfer" tr 
        WHERE
          contract_address = REPLACE(LOWER('0xE5a3229CCb22b6484594973A03a3851dCd948756'), '0x', '\x') :: bytea
        UNION ALL
        SELECT
          date_trunc('day', evt_block_time) AS DAY,
          "from" AS address,
          tr.contract_address AS token_address,
          - value AS amount
        FROM
          erc20."ERC20_evt_Transfer" tr 
        WHERE
          contract_address = REPLACE(LOWER('0xE5a3229CCb22b6484594973A03a3851dCd948756'), '0x', '\x') :: bytea
      ) t
    GROUP BY
      1,
      2,
      3
  ),
  balances_with_gap_days AS (
    SELECT
      t.day,
      address,
      SUM(amount) OVER (
        PARTITION BY address
        ORDER BY
          t.day
      ) AS balance,
      lead(DAY, 1, now()) OVER (
        PARTITION BY address
        ORDER BY
          t.day
      ) AS next_day 
    FROM
      transfers t
  ),
  days AS (
    SELECT
      generate_series(
        '2016-05-01' :: TIMESTAMP,
        date_trunc('month', NOW()),
        '1 month'
      ) AS DAY 
  ),
  balance_all_days AS (
    SELECT
      d.day,
      address,
      SUM(balance / 10 ^ 0) AS balance
    FROM
      balances_with_gap_days b
      INNER JOIN days d ON b.day <= d.day
      AND d.day < b.next_day 
    GROUP BY
      1,
      2
    ORDER BY
      1,
      2
  )
SELECT
  b.day AS "Date",
  case
    when balance / 1e18 < 32 then ' < 32 eth'
    when balance / 1e18 >= 32 then '>= 32 eth'
  end as balance_cat,
  COUNT(distinct address) AS "Holders",
  COUNT(address) - lag(COUNT(address)) OVER (
    ORDER BY
      b.day
  ) AS CHANGE
FROM
  balance_all_days b
WHERE
  balance > 0
GROUP BY
  1,
  2
ORDER BY
  2;
--credit to @rokfinsql for logic behind query https://dune.com/queries/110207