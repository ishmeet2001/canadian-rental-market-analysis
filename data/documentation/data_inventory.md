# Data Inventory

Download date: 2026-06-22

## `data/raw/statcan/statcan_34100133_average_rents.csv`

- Source: Statistics Canada Table 34-10-0133-01.
- Source URL: https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=3410013301
- Row count: 132,344.
- Column names: `REF_DATE`, `GEO`, `DGUID`, `Type of structure`, `Type of unit`, `UOM`, `UOM_ID`, `SCALAR_FACTOR`, `SCALAR_ID`, `VECTOR`, `COORDINATE`, `VALUE`, `STATUS`, `SYMBOL`, `TERMINATED`, `DECIMALS`.
- Date range: 1987 to 2025.
- Geography levels: Census subdivision, census metropolitan area, census agglomeration, census metropolitan area part, census agglomeration part.
- Geography count observed: 244 unique `GEO` values.
- Contains average rent: Yes.
- Contains vacancy rate: No.
- Contains turnover: No.
- Contains rental-unit count: No.
- Contains bedroom type: Yes, through `Type of unit` (`Bachelor units`, `One bedroom units`, `Two bedroom units`, `Three bedroom units`).
- Contains dwelling type: Yes, through `Type of structure`.

10 sample rows:

```csv
REF_DATE,GEO,DGUID,Type of structure,Type of unit,UOM,UOM_ID,SCALAR_FACTOR,SCALAR_ID,VECTOR,COORDINATE,VALUE,STATUS,SYMBOL,TERMINATED,DECIMALS
1987,"Bay Roberts, Newfoundland and Labrador",2011S0504005,Row and apartment structures of three units and over,Bachelor units,Dollars,81,units,0,v42135513,192.3.1,,..,,,0
1987,"Bay Roberts, Newfoundland and Labrador",2011S0504005,Row and apartment structures of three units and over,One bedroom units,Dollars,81,units,0,v42135529,192.3.2,,..,,,0
1987,"Bay Roberts, Newfoundland and Labrador",2011S0504005,Row and apartment structures of three units and over,Two bedroom units,Dollars,81,units,0,v42135545,192.3.3,,..,,,0
1987,"Bay Roberts, Newfoundland and Labrador",2011S0504005,Row and apartment structures of three units and over,Three bedroom units,Dollars,81,units,0,v42135561,192.3.4,,..,,,0
1987,"Bay Roberts, Newfoundland and Labrador",2011S0504005,Row structures of three units and over,Bachelor units,Dollars,81,units,0,v42135577,192.2.1,,..,,,0
1987,"Bay Roberts, Newfoundland and Labrador",2011S0504005,Row structures of three units and over,One bedroom units,Dollars,81,units,0,v42135593,192.2.2,,..,,,0
1987,"Bay Roberts, Newfoundland and Labrador",2011S0504005,Row structures of three units and over,Two bedroom units,Dollars,81,units,0,v42135609,192.2.3,,..,,,0
1987,"Bay Roberts, Newfoundland and Labrador",2011S0504005,Row structures of three units and over,Three bedroom units,Dollars,81,units,0,v42135625,192.2.4,,..,,,0
1987,"Bay Roberts, Newfoundland and Labrador",2011S0504005,Apartment structures of three units and over,Bachelor units,Dollars,81,units,0,v42135641,192.1.1,,..,,,0
1987,"Bay Roberts, Newfoundland and Labrador",2011S0504005,Apartment structures of three units and over,One bedroom units,Dollars,81,units,0,v42135657,192.1.2,,..,,,0
```

## `data/raw/cmhc/cmhc_rental_market_survey_latest.xlsx`

- Source: CMHC Rental Market Survey Data Tables.
- Source URL: https://www.cmhc-schl.gc.ca/professionals/housing-markets-data-and-research/housing-data/data-tables/rental-market/rental-market-report-data-tables
- Row count: 494 worksheet rows across 8 sheets. Sheet row counts: `Table of Contents` 26, `Table 1.0` 77, `Table 4.1` 38, `Table 4.2` 39, `Table 5.0` 85, `Table 6.0` 74, `Table 6.1` 79, `Table 6.2` 76.
- Column names: The workbook uses multi-row formatted headers. Observed core fields in `Table 1.0`: `Centre`, vacancy rates for `Oct-24` and `Oct-25`, turnover rates for `Oct-24` and `Oct-25`, average rent two bedroom for `Oct-24` and `Oct-25`, percentage change of average rent two bedroom from fixed sample for `Oct-23 to Oct-24` and `Oct-24 to Oct-25`, quality indicators, and significance indicators.
- Date range: Latest 2025 publication; core tables include October 2024 and October 2025 columns, with percentage-change columns covering October 2023 to October 2025.
- Geography levels: Canada 10,000+, Canada CMAs, provinces/territories or provincial 10,000+ aggregates, CMAs, CAs, and major centres listed by CMHC.
- Contains average rent: Yes.
- Contains vacancy rate: Yes.
- Contains turnover: Yes.
- Contains rental-unit count: Yes, in condominium/private apartment universe tables.
- Contains bedroom type: Yes, two-bedroom measures in `Table 1.0` and multiple bedroom-size columns in `Table 6.0`.
- Contains dwelling type: Yes, including privately initiated apartment structures, row/townhouse and apartment structures, rental condominium apartments, and apartments in the RMS.

10 sample rows from `Table 1.0`:

```csv
Centre,Vacancy Rate Oct-24,Vacancy Rate QI Oct-24,Vacancy Rate Oct-25,Vacancy Rate QI Oct-25,Vacancy Significant Change,Turnover Rate Oct-24,Turnover QI Oct-24,Turnover Rate Oct-25,Turnover QI Oct-25,Turnover Significant Change,Average Rent Two Bedroom Oct-24,Average Rent QI Oct-24,Average Rent Two Bedroom Oct-25,Average Rent QI Oct-25,Rent Change Oct-23 to Oct-24,Rent Change QI Oct-23 to Oct-24,Rent Change Oct-24 to Oct-25,Rent Change QI Oct-24 to Oct-25
Newfoundland and Labrador 10,000+,1.8,a,2.1,b,-,12.7,a,11.3,a,down,1109,a,1208,b,3.2,c,6.6,b
St. John's CMA,2.1,b,2.0,a,-,14.1,a,13.0,a,-,1250,a,1361,b,2.1,c,7.6,b
Prince Edward Island 10,000+,0.8,a,2.1,b,up,8.2,b,9.8,b,-,1181,a,1293,a,3.8,d,**,,
Charlottetown CA,0.7,a,1.6,c,up,9.1,b,9.8,b,-,1196,a,1300,a,3.3,d,4.7,d
Nova Scotia 10,000+,2.0,a,2.6,a,up,10.0,a,8.9,a,down,1606,a,1711,a,4.5,c,6.7,b
Halifax CMA,2.1,a,2.7,a,up,10.0,a,9.0,a,down,1707,a,1826,a,3.8,c,6.7,b
New Brunswick 10,000+,2.0,a,2.9,a,up,14.1,a,13.2,a,-,1285,a,1368,a,6.4,b,5.3,b
Fredericton CMA,0.9,a,2.5,a,up,18.1,a,13.1,a,down,1341,a,1413,a,5.5,b,5.2,b
Moncton CMA,1.5,a,3.9,b,up,13.4,a,15.4,a,up,1353,a,1453,a,4.8,c,4.7,c
Saint John CMA,4.0,b,1.9,c,down,13.8,c,11.8,c,-,1229,a,1290,a,7.4,c,5.8,c
```

## Overlap and V1 Recommendation

- Year overlap: StatCan covers 1987-2025. The downloaded CMHC latest workbook covers the 2025 publication, with core current/prior columns for October 2024 and October 2025 and rent-change comparisons back to October 2023. Clean overlap for direct city-level measures is therefore 2024-2025, with partial change context from 2023.
- Geography overlap: Both sources include major rental-market geographies such as CMAs/CAs and named centres. StatCan has a broader long-run geography table using DGUIDs and multiple census geography levels; CMHC latest is focused on Canada, provinces, and major centres.
- Recommended primary fact table for Version 1: CMHC Rental Market Survey Data Tables, because it contains all rental-pressure measures requested for the dashboard: vacancy rate, average rent, turnover rate, and rental-unit universe counts.
- Issues preventing a clean city-level rental-pressure dashboard:
  - CMHC latest is a formatted workbook with multi-row headers and sheet-specific layouts, so it must be explicitly parsed before dashboard use.
  - CMHC latest is not a long historical panel unless older editions are downloaded too.
  - StatCan provides average rent only, so it cannot support pressure metrics beyond rent without CMHC.
  - City names/geographies do not line up perfectly between sources; CMA/CA names, province aggregates, parts, DGUIDs, and 2021 census geography notes need a crosswalk.
  - Suppressed values and poor-quality estimates need dashboard rules before ranking or scoring cities.
