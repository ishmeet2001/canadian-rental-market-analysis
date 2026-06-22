# Canadian Rental Market Pressure Dashboard

## Overview

A data-driven dashboard identifying which Canadian rental markets are under the most pressure based on rent levels, vacancy rates, and supply constraints.

**Target Users:**
- Renters seeking market-aware decision-making
- Housing-policy analysts monitoring affordability trends
- Municipal planners assessing local rental-market health

**Key Business Question:** Which major Canadian rental markets show the strongest signs of rental-market pressure in 2025, and how does that pressure differ by unit size?

---

## Core Metrics

1. **Standardized Two-Bedroom Average Rent (`average_rent_2br`)** – The average rent for two-bedroom units. This serves as the default standardized comparison measure across markets, rather than a representation of all renters. We do not call this or any other measure "overall average rent" as no weighted overall rent is provided.
2. **Vacancy Rate** – Percentage of vacant rental units.
3. **Turnover Rate** – Percentage of units that changed tenants during the year.
4. **Rent Growth (YoY)** – Annual change in two-bedroom rent.
5. **Vacancy Change (YoY)** – Annual change in vacancy rate (percentage points).

---

## Data Sources

### Primary Sources

| Source | Table/Survey | Coverage | Key Variables | Notes |
|--------|-------------|----------|----------------|-------|
| **Statistics Canada** | 34-10-0133-01 | 1990–2025 (varies) | Average rent by geography | Historical breadth; check for suppressed values |
| **CMHC** | Rental Market Survey | Annual (varies by centre) | Vacancy rate, avg rent, units | Covers major centres; most reliable for recent years |

### Data Integration Strategy

1. **Start with Statistics Canada 34-10-0133-01** for historical average rent trends
2. **Supplement with CMHC RMS** for vacancy rates and rental-unit counts
3. **Align geographies** (province, CMA, major centres) across both sources
4. **Handle missing/suppressed data** with clear documentation

---

## Analysis Questions

1. Which Canadian rental markets have the highest average rents?
2. Which markets have the lowest vacancy rates?
3. Which cities combine **high rent + low vacancy**?
4. Which markets have seen the fastest rent growth?
5. Which cities moved from lower pressure to higher pressure over time?
6. Which markets should be flagged for ongoing monitoring?

---

## Pressure Categories (V1)

Simple, explainable segmentation:

- **High Pressure:** High rent + low vacancy
- **Growth Pressure:** Rapid rent growth (YoY)
- **Supply Pressure:** Low vacancy + limited unit growth
- **Monitor:** Emerging trends or data gaps
- **Lower Pressure:** Stable or declining rent; adequate vacancy

*Note:* Not an "affordability score"—does not incorporate income data. Focus is on market indicators only.

---

## Project Structure

```
canadian-rental-market-pressure/
├── data/
│   ├── raw/                 # Original downloads from Stats Can, CMHC
│   └── processed/           # Cleaned, deduplicated, aligned CSVs
├── database/                # SQLite or local DB exports
├── notebooks/
│   ├── 01_data_cleaning.ipynb       # Ingest, deduplicate, align geographies
│   ├── 02_sql_market_pressure_analysis.ipynb  # Join sources, compute metrics
│   ├── 03_eda_visualizations.ipynb  # Exploratory charts
│   └── 04_powerbi_export.ipynb      # Export to Power BI format
├── outputs/
│   ├── charts/              # PNG/SVG dashboard exports
│   └── tables/              # CSV tables for Power BI
├── sql/                     # SQL queries for market-pressure logic
├── requirements.txt         # Python dependencies
└── README.md               # This file
```

---

## Notebooks (Quick Overview)

### **01_data_cleaning.ipynb**
- Download or import Stats Can Table 34-10-0133-01 (CSV)
- Download or import CMHC RMS data (CSV or API)
- Standardize geography names (province, CMA, centre)
- Handle missing values and suppressed cells
- Export cleaned datasets to `data/processed/`

### **02_sql_market_pressure_analysis.ipynb**
- Load cleaned datasets into SQLite
- Join average rent (Stats Can) with vacancy & units (CMHC)
- Compute:
  - Rent growth (YoY %)
  - Vacancy change (YoY pp)
  - Pressure categories
- Export market-pressure dataset

### **03_eda_visualizations.ipynb**
- Exploratory scatter plots: rent vs. vacancy
- Time-series: rent growth by city
- Heatmaps: pressure category distribution
- Identify outliers and trends

### **04_powerbi_export.ipynb**
- Export final tables to CSV/JSON for Power BI
- Format for dashboard consumption
- Prepare summary metrics by pressure category

---

## Quick Start

### 1. Environment Setup
```bash
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

### 2. Data Preparation
- Manually download Statistics Canada Table 34-10-0133-01 from https://www150.statcan.gc.ca/
- Manually download CMHC Rental Market Survey data from https://www.cmhc-schl.gc.ca/
- Place files in `data/raw/`

### 3. Run Notebooks
```
01_data_cleaning → 02_sql_market_pressure_analysis → 03_eda_visualizations → 04_powerbi_export
```

---

## Key Design Decisions

- **Standardized Rent Measure:** Use two-bedroom rent (`average_rent_2br`) as the default standardized comparison measure. It represents a standardized benchmark, not the rent of all unit sizes or a weighted average of all renters. No measure is referred to as "overall average rent" unless a weighted overall measure is explicitly provided.
- **Extensible Database Schema:** The SQLite database is designed to allow a bedroom-type detail table (`bedroom_rent_2024_2025`) to be added in Phase 2 without altering the primary city-level table (`rental_market_2024_2025`).
- **No affordability assumptions:** Metrics are demand/supply indicators only.
- **Pressure categories:** Simple, groupings for stakeholder communication.
- **SQLite:** Lightweight local database for reproducibility.

---

## Version 1 Scope

✓ Ingest and clean CMHC Table 1.0 for core city-level pressure indicators  
✓ Model primary fact table using `average_rent_2br` as the standardized rent benchmark  
✓ Verify feasibility of bedroom-type expansion via Table 6.0 analysis  

✗ Merging Table 6.0 into the main fact table (deferred to Phase 2)  
✗ Bedroom Type Power BI Slicer (unsafe for Version 1 due to lack of vacancy rate breakdown and overall average rent by bedroom type)  
✗ Predictive modelling  
✗ Affordability scoring (requires income)  

---

## Next Steps

1. Confirm downloadable data availability from Statistics Canada and CMHC
2. Map geography codes and names across sources
3. Execute Notebook 01 (cleaning)
4. Iterate on pressure categories based on data distribution
