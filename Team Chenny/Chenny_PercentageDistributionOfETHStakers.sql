WITH staker_names AS (SELECT *
    FROM 
        VALUES (lower('0xae7ab96520de3a18e5e111b5eaab095312d7fe84'), 'Lido')
        , (lower('0x39dc6a99209b5e6b81dc85addressaddress40c86ff10981ebda29'), 'Staked.us')
        , (lower('0x0194512e77d798e4871973d9cb9d7ddfc0ffd801'), 'stakefish')
        , (lower('0xd4039ecc40aeda0582036437cf3ec02845da4c13'), 'Kraken')
        , (lower('0xa40dfee99e1c85dc97fdc594b16a460717838703'), 'Kraken')
        , (lower('0x622de9bb9ff8907414785a633097db438f9a2d86'), 'Bitcoin Suisse')
        , (lower('0xdd9663bd979f1ab1bada85e1bc7d7f13cafe71f8'), 'Bitcoin Suisse')
        , (lower('0xec70e3c8afe212039c3f6a2df1c798003bf7cfe9'), 'Bitcoin Suisse')
        , (lower('0x3837eA2279b8E5c260A78F5F4181B783BbE76a8B'), 'Bitcoin Suisse')
        , (lower('0x2a7077399b3e90f5392d55a1dc7046ad8d152348'), 'Bitcoin Suisse')
        , (lower('0xc2288b408dc872a1546f13e6ebfa9c94998316a2'), 'Bitcoin Suisse')
        , (lower('0xf2be95116845252a28bd43661651917dc183dab1'), 'Figment')
        , (lower('0x37ab162ab59e106d6072eb7a7bd4c4c2973455a7'), 'Figment')
        , (lower('0xc874b064f465bdd6411d45734b56fac750cda29a'), 'Stakewise')
        , (lower('0x84db6ee82b7cf3b47e8f19270abde5718b936670'), 'Stkr (Ankr)')
        , (lower('0x194bd70b59491ce1310ea0bceabdb6c23ac9d5b2'), 'Huobi')
        , (lower('0xb73f4d4e99f65ec4b16b684e44f81aeca5ba2b7c'), 'Huobi')
        , (lower('0xbf1556a7d625654e3d64d1f0466a60a697fac178'), 'InfStones')
        , (lower('0xbca3b7b87dcb15f0efa66136bc0e4684a3e5da4d'), 'SharedStake')
        , (lower('0xeadcba8bf9aca93f627f31fb05470f5a0686ceca'), 'StakeWise Solos')
        , (lower('0xfa5f9eaa65ffb2a75de092eb7f3fc84fc86b5b18'), 'Abyss Finance')
        , (lower('0x66827bcd635f2bb1779d68c46aeb16541bca6ba8'), 'PieDAO')
        , (lower('0xd6216fc19db775df9774a6e33526131da7d19a2c'), 'KuCoin')
        , (lower('0x1692e170361cefd1eb7240ec13d048fd9af6d667'), 'KuCoin')
        , (lower('0x7b915c27a0Ed48E2Ce726Ee40F20B2bF8a88a1b3'), 'KuCoin')
        , (lower('0xcbc1065255cbc3ab41a6868c22d1f1c573ab89fd'), 'CREAM')
        , (lower('0x808e7133C700cF3a66E6A25AAdB1fBEF6be468b4'), 'Bitstamp')
        , (lower('0x12ec5befa9166fa327d4c345a93f0ac99dd2a7d8'), 'Blox Staking')
        , (lower('0x24B2F1AECED4B34133152Bb20cFd6a206A0EA33C'), 'staked.finance')
        , (lower('0x0038598EcB3B308EBc6c6e2c635BaCaA3c5298a3'), 'Poloniex')
        , (lower('0xD39aEeb73983e5fbc52B77A3957a48c1EeAC8eD7'), 'MintDice.com')
        , (lower('0x7ebf05749faf7eb78eff153e40c15890bb4578a4'), 'neukind.com')
        , (lower('0xa54be2edaa143e969a63fc744bbd2d511b50cbc3'), 'neukind.com')
        , (lower('0xac29ef7a7f4325ffa564de9abf67e5ace46c88f8'), 'neukind.com')
        , (lower('0xc3003f8b89f35a7bf3cb3a6ec3d8e4c3c8ce7cce'), 'neukind.com')
        , (lower('0x1db3439a222c519ab44bb1144fc28167b4fa6ee6'), 'Vitalik Buterin')
        , (lower('0x5a0036bcab4501e70f086c634e2958a8beae3a11'), 'OKX')
        , (lower('0x607ebC82329D0CAc3027B83d15e4b4E816F131b7'), 'StakeHound')
        , (lower('0xc236c3ec83351b07f148afbadc252cce2c07972e'), 'Bitfinex')
        , (lower('0xe733455faddf4999176e99a0ec084e978f5552ed'), 'Bitfinex')
        , (lower('0x4c2f150fc90fed3d8281114c2349f1906cde5346'), 'Gemini')
        , (lower('0xbb84d966c09264ce9a2104a4a20bb378369986db'), 'WEX Exchange')
        , (lower('0xD33526068D116cE69F19A9ee46F0bd304F21A51f'), 'RocketPool')
        as (address,name)
        UNION 
        SELECT coinbase.address
        , 'Coinbase' AS name
        FROM (
            SELECT distinct et.`from` AS address
            , MIN(et.block_time) AS block_time
            FROM ethereum.traces et
            INNER JOIN ethereum.traces et2 ON et2.`from`=et.`from` AND et2.value > 0 AND et2.`to`=lower('0xA090e606E30bD747d4E6245a1517EbE430F0057e')
            WHERE et.`to` =lower('0x00000000219ab540356cBB839Cbe05303d7705Fa')
            AND et.success
            AND et.value > 0
            GROUP BY et.`from`
            ) coinbase
        GROUP BY coinbase.address
        UNION
        SELECT binance.address
        , 'Binance' AS name
        FROM (
            SELECT lower('0xF17ACEd3c7A8DAA29ebb90Db8D1b6efD8C364a18') AS address
            UNION
            SELECT lower('0x2f47a1c2db4a3b78cda44eade915c3b19107ddcc') AS address
            UNION
            SELECT distinct `to` AS address
            FROM ethereum.transactions
            WHERE `from`=lower('0xF17ACEd3c7A8DAA29ebb90Db8D1b6efD8C364a18')
            AND `to` !=lower('0x00000000219ab540356cbb839cbe05303d7705fa')
            GROUP BY `to`
        ) binance
        GROUP BY binance.address
        UNION
        SELECT traces.`from` AS address
    , 'RocketPool' AS protocol
    FROM ethereum.transactions txs
    RIGHT JOIN ethereum.traces traces ON txs.hash=traces.tx_hash AND traces.to = lower('0x00000000219ab540356cbb839cbe05303d7705fa')
    WHERE txs.`to` IN (lower('0xdcd51fc5cd918e0461b9b7fb75967fdfd10dae2f'), lower('0x1cc9cf5586522c6f483e84a19c3c2b0b6d027bf0'))
, staker_data AS (SELECT SUM(et.value)/1e18 as deposited
,staker_names.name AS depositor
,et.`from` as address
from ethereum.traces as et 
LEFT JOIN staker_names ON et.`from` = staker_names.address 
WHERE et.`to` = lower('0x00000000219ab540356cBB839Cbe05303d7705Fa')
AND success
AND value > 0
GROUP BY et.`from`,depositor
ORDER BY deposited DESC)

SELECT CASE WHEN depositor is null THEN 'Other'
ELSE depositor
END AS depositor
, SUM(deposited) as deposited_eth 
, SUM(deposited)/(SELECT SUM(deposited) FROM staker_data) AS marketshare
FROM staker_data 
GROUP BY depositor
ORDER BY deposited_eth DESC
--LIMIT 30
--modified from @hildoby https://dune.com/queries/991483/1716887
