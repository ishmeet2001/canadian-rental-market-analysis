# Statistics Canada Table 34-10-0133-01 Source Notes

- Official source name: Statistics Canada Table 34-10-0133-01, "Canada Mortgage and Housing Corporation, average rents for areas with a population of 10,000 and over."
- Source webpage URL: https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=3410013301
- Full CSV download URL used: https://www150.statcan.gc.ca/n1/tbl/csv/34100133-eng.zip
- Download date: 2026-06-22
- Data frequency: Annual
- Geographic coverage: Census subdivision, census metropolitan area, census agglomeration, census metropolitan area part, and census agglomeration part.
- Reference period in downloaded file: 1987 to 2025.
- Key fields expected: `REF_DATE`, `GEO`, `DGUID`, `Type of structure`, `Type of unit`, `UOM`, `VALUE`, `STATUS`, `SYMBOL`, `TERMINATED`.
- Measures expected: average rent in dollars by geography, structure type, and unit/bedroom type.
- Known limitations, suppression symbols, or comparability concerns:
  - Observed `STATUS` values include `..` for values not available for a specific reference period and `F` for values too unreliable to be published.
  - Some geography members are marked terminated in the official metadata.
  - The file contains average rents only; it does not contain vacancy rates, turnover rates, or rental-unit universe counts.
  - Geographic definitions and available places change over the long 1987-2025 period, so time series by city require careful DGUID/geography validation before use.
  - Values are split by structure type and unit type; city-level totals require explicit selection rules.

Supporting official metadata saved locally: `data/documentation/statcan_34100133_metadata.csv`.
