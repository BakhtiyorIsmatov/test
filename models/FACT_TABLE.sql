{{
  config(
    materialized='view'
  )
}}

with FACTRESELLERSALES as (

    select * from {{ ref('stg_FACTRESELLERSALES') }}

),

DIMRESELLER as (

    select * from {{ ref('stg_DIMRESELLER') }}

),

DIMPRODUCT as (

    select * from {{ ref('stg_DIMPRODUCT') }}

),

DIMGEOGRAPHY as (

    select * from {{ ref('stg_DIMGEOGRAPHY') }}

),

DIMCUSTOMER as (

    select * from {{ ref('stg_DIMCUSTOMER') }}

),

final as (

    select
        "FR"."ProductKey",
        "FR"."ResellerKey",
        "FR"."SalesAmount",
        "DR"."ResellerKey",
        "DR"."GeographyKey",
        "DR"."BankName",
        "DP"."ProductKey",
        "DP"."Color",
        "DP"."StartDate",
        "DP"."EndDate",
        "DG"."GeographyKey",
        "DG"."City",
        "DG"."IpAddressLocator",
        "DC"."CustomerKey",
        "DC"."GeographyKey",
        "DC"."FirstName",
        "DC"."LastName",
        "DC"."EmailAddress",
        "DC"."TotalChildren",
        "DC"."Phone"

    from FACTRESELLERSALES AS FR

    inner join DIMRESELLER AS DR using ("ResellerKey")
    inner join DIMGEOGRAPHY AS DG using ("GeographyKey")
    inner join DIMCUSTOMER AS DC using ("GeographyKey")
    inner join DIMPRODUCT AS DP using ("ProductKey")
   
)

select * from final