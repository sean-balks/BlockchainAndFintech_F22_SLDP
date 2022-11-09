-- code not finished... having a little trouble


with stored_eth as (
    select `to` as address,
        sum(value)/1e18 as eth_amount
    from ethereum.transactions
    where 
        -- block_time > '2020-10-14'
        -- and 
        success
    group by 1
),
sent_eth as (
    select `from` as address,
        sum(value)/1e18 as eth_amount
    from ethereum.transactions
    where 
        -- block_time > '2020-10-14'
        -- and 
        success
    group by 1
)

select
        (case when stored_eth.address = '0xf977814e90da44bfa03b6295a0616a897441acec' then '0xf977814e90da44bfa03b6295a0616a897441acec'
            when stored_eth.address = '0xda9dfa130df4de4673b89022ee50ff26f6ea73cf' then '0xda9dfa130df4de4673b89022ee50ff26f6ea73cf'
            when stored_eth.address = '0x0716a17fbaee714f1e6ab0f9d59edbc5f09815c0' then '0x0716a17fbaee714f1e6ab0f9d59edbc5f09815c0'
            when stored_eth.address = '0xa7efae728d2936e78bda97dc267687568dd593f3' then '0xa7efae728d2936e78bda97dc267687568dd593f3'
            when stored_eth.address = '0x0548f59fee79f8832c299e01dca5c76f034f558e' then '0x0548f59fee79f8832c299e01dca5c76f034f558e'
            when stored_eth.address = '0x176f3dab24a159341c0509bb36b833e7fdd0a132' then '0x176f3dab24a159341c0509bb36b833e7fdd0a132'
            when stored_eth.address = '0xb29380ffc20696729b7ab8d093fa1e2ec14dfe2b' then '0xb29380ffc20696729b7ab8d093fa1e2ec14dfe2b'
            when stored_eth.address = '0xc882b111a75c0c657fc507c04fbfcd2cc984f071' then '0xc882b111a75c0c657fc507c04fbfcd2cc984f071'
            when stored_eth.address = '0x6262998ced04146fa42253a5c0af90ca02dfd2a3' then '0x6262998ced04146fa42253a5c0af90ca02dfd2a3'
            when stored_eth.address = '0xdc1487e092caba080c6badafaa75a58ce7a2ec34' then '0xdc1487e092caba080c6badafaa75a58ce7a2ec34'
            when stored_eth.address = '0xd6216fc19db775df9774a6e33526131da7d19a2c' then '0xd6216fc19db775df9774a6e33526131da7d19a2c'
            when stored_eth.address = '0x203520f4ec42ea39b03f62b20e20cf17db5fdfa7' then '0x203520f4ec42ea39b03f62b20e20cf17db5fdfa7'
            when stored_eth.address = '0xb9711550ec6dc977f26b73809a2d6791c0f0e9c8' then '0xb9711550ec6dc977f26b73809a2d6791c0f0e9c8'
            when stored_eth.address = '0xcdbf58a9a9b54a2c43800c50c7192946de858321' then '0xcdbf58a9a9b54a2c43800c50c7192946de858321'
            when stored_eth.address = '0x5f397b62502e255f68382791947d54c4b2d37f09' then '0x5f397b62502e255f68382791947d54c4b2d37f09'
            when stored_eth.address = '0xb60c61dbb7456f024f9338c739b02be68e3f545c' then '0xb60c61dbb7456f024f9338c739b02be68e3f545c'
            when stored_eth.address = '0x1b8766d041567eed306940c587e21c06ab968663' then '0x1b8766d041567eed306940c587e21c06ab968663'
            when stored_eth.address = '0x5a52e96bacdabb82fd05763e25335261b270efcb' then '0x5a52e96bacdabb82fd05763e25335261b270efcb'
            when stored_eth.address = '0x8ae880b5d35305da48b63ce3e52b22d17859f293' then '0x8ae880b5d35305da48b63ce3e52b22d17859f293'
            when stored_eth.address = '0x9e927c02c9eadae63f5efb0dd818943c7262fb8e' then '0x9e927c02c9eadae63f5efb0dd818943c7262fb8e'
            else 'Others'
        end) 
            -- stored_eth.address
            as wallet_address,
    sum(stored_eth.eth_amount) - sum(sent_eth.eth_amount) as total_eth_in_wallets
from stored_eth 
inner join sent_eth on stored_eth.address=sent_eth.address
group by 1
order by 2 desc
-- limit 100