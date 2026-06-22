# Bedroom Type Analysis Feasibility Documentation (CMHC Table 6.0)

This document assesses the structure of Table 6.0 in the CMHC Rental Market Survey workbook and evaluates the feasibility of incorporating bedroom-type dimensions into the Canadian Rental Market Pressure dashboard.

## 1. Table 6.0 Header Structure
Table 6.0 contains multi-row formatted headers spanning rows 0 to 9 (0-indexed). The table occupies 44 columns (0 to 43).

- **Row 1:** Main title: `"6.0 Average Rent for Turnover and Non-turnover Units"`
- **Row 3:** Universe and structural scope: `"Privately Initiated Apartment Structures of Three Units and Over - Provinces and Major Centres"`
- **Row 6:** Split by turnover status: 
  - `"Turnover units"` (starting at Column 10, logically spanning Columns 2 to 21)
  - `"Non-turnover units"` (starting at Column 32, logically spanning Columns 24 to 43)
- **Row 7:** Bedroom type categories repeat for each turnover group: `"Studio"`, `"1 Bedroom"`, `"2 Bedroom"`, `"3 Bedroom +"`, and `"Total"`. Note that the bachelor unit category is referred to as **"Studio"** in this sheet.
- **Row 8:** Metric name: `"Average rent ($)"`
- **Row 9:** Reporting period and centre column:
  - Column 0: `"Centre"`
  - Columns 2 to 43: Alternating between the reporting period (`Oct-24` and `Oct-25`) and the Quality Indicator (QI) flag column.
    - *Example (Turnover units, Studio):* Column 2 is `Oct-24` average rent, Column 3 is the `Oct-24` QI, Column 4 is `Oct-25` average rent, Column 5 is the `Oct-25` QI.

## 2. Available Bedroom Categories
The table reports rents for the following bedroom sizes:
- **Studio** (representing bachelor units)
- **1 Bedroom**
- **2 Bedroom**
- **3 Bedroom +**
- **Total** (representing the average rent within that specific turnover group, *not* a weighted overall market average).

## 3. Geography Level
Table 6.0 aligns with the CMHC geography reporting standards. It includes:
- Provincial 10,000+ aggregates (e.g., `Newfoundland and Labrador 10,000+`)
- Census Metropolitan Areas (CMAs) (e.g., `Halifax CMA`, `Toronto CMA`)
- Census Agglomerations (CAs) (e.g., `Charlottetown CA`)
- National aggregates (`Canada 10,000+` and `Canada CMAs`).

## 4. Availability of 2024 and 2025 Values
Yes, values for both **October 2024 (`Oct-24`)** and **October 2025 (`Oct-25`)** are present across all bedroom type categories and turnover groups, allowing for Year-over-Year comparisons.

## 5. Alignment of Centres with Table 1.0
Yes, the reporting centres in Table 6.0 **align perfectly** in order and naming with those in Table 1.0:
- Both sheets list the identical **55 geography rows** (excluding header and footnote rows) starting from `Newfoundland and Labrador 10,000+` to `Canada CMAs`.
- Due to layout differences, the data section starts at **Row 10** in Table 6.0, whereas it starts at **Row 7** in Table 1.0.

## 6. Feasibility of Vacancy and Rent Analysis by Bedroom Type
- **Rent:** Average rent can be analyzed by bedroom type. However, it is **only available split by turnover status** (Turnover vs. Non-turnover units). No unified weighted overall average rent by bedroom type exists in the workbook.
- **Vacancy:** **Cannot** be analyzed by bedroom type. Vacancy rates by bedroom size are not included in the CMHC workbook (neither in Table 1.0 nor Table 6.0). Vacancy rates are only available as a single, overall city-level percentage in Table 1.0.

## 7. Safety of Adding a "Bedroom Type" Slicer in Power BI
It is **NOT safe** to introduce a Bedroom Type slicer in Power BI for the Version 1 dashboard. 

> [!WARNING]
> Adding a Bedroom Type slicer in Power BI for Version 1 will lead to logic errors and misleading visualizations:
> 1. **Mismatched Grain:** Vacancy rates (Table 1.0) are only available at the overall centre level. Slicing by bedroom type would duplicate the overall vacancy rate across all bedroom categories, falsely implying vacancy is identical for Studios and 3-Bedroom units.
> 2. **No Weighted Overall Rent:** The rents in Table 6.0 are split into `Turnover` and `Non-turnover` groups. We do not have a unified average rent by bedroom type for the whole market. 
> 3. **Version 1 Standardized Measure:** To avoid misleading users, Version 1 must use the two-bedroom average rent (`average_rent_2br`) from Table 1.0 as the default standardized rent measure. This functions as a benchmark comparison measure rather than a representation of all renters.
