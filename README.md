# Canadian Rental Market Pressure Analysis

I used CMHC rental-market data to compare average rents, vacancy rates, and recent changes across Canadian cities. The goal was to see which markets show multiple signs of rental pressure at the same time, helping policy analysts and planners identify cities that need closer monitoring.

---

## The Core Concept
This analysis uses average **two-bedroom rent** as a standardized benchmark to compare cities. It does not represent all renters or all unit sizes, but it provides a consistent metric across geographies. 

Since this project only looks at supply and demand indicators (and does not include household income data), this is a **market pressure screening tool** rather than an affordability score.

---

## How It Works & Tools Used
1. **Clean & Load (Python):** In `01_clean_and_prepare.ipynb`, I ingest raw CMHC table data, clean up suppressed values, filter out provincial aggregates, and load the clean data into a local SQLite database (`database/rental_market.db`).
2. **SQL Analysis (SQLite):** In `02_sql_analysis.ipynb` and `sql/rental_market_queries.sql`, I calculate data-driven benchmarks using SQLite window functions:
   * **High Rent:** >= $1,802 (75th percentile)
   * **Low Vacancy:** <= 2.5% (25th percentile)
   * **Rapid Rent Growth:** >= 6.1% YoY (75th percentile)
   * **Vacancy Tightening:** vacancy change is negative (< 0 pp) and <= 0.1 pp
3. **Scoring & Labeling:** Cities are scored from 0 to 4 based on how many thresholds they cross. Caution-quality records (estimate flag 'd') are kept in the final segment outputs but were excluded when calculating thresholds to keep the benchmarks reliable.

---

## Key Findings

### Top Markets Under Pressure (2025)
* **Nanaimo, St. John's, and Saguenay (Score 3):** Show the highest level of pressure across rent levels, vacancy tightness, and year-over-year changes.
* **Halifax, Kingston, Kamloops, Sudbury, Saint John, and Québec (Score 2):** Show moderate to high pressure, driven mainly by low vacancy rates and tightening supply.

### Proposed Policy Actions
Based on these findings, I outline four actionable planning recommendations to address these pressure points:
* **Densification:** Accelerate zoning changes and low-rise densification in land-constrained areas like Vancouver.
* **Faster Permitting:** Streamline development approvals to reduce bureaucratic delays and build homes quicker.
* **Migration Incentives:** Use tax breaks and infrastructure to support population growth in rural and suburban areas.
* **Demand Controls:** Keep speculation taxes and limits on short-term rentals to protect long-term housing availability.

---

## Project Directory

```
├── data/
│   ├── raw/                       # Original CMHC and StatsCan data files
│   └── processed/                 # Cleaned dataset (CSV)
├── database/
│   └── rental_market.db           # SQLite database
├── notebooks/
│   ├── 01_clean_and_prepare.ipynb # Data cleaning and DB loading
│   └── 02_sql_analysis.ipynb      # SQL queries and summaries
├── sql/
│   └── rental_market_queries.sql  # Standalone SQL queries
└── outputs/
    └── tables/
        ├── rental_market_thresholds.csv      # Calculated cutoffs
        ├── rental_market_segments.csv        # Final scored cities
        └── rental_market_quality_review.csv  # Data quality logs
```
