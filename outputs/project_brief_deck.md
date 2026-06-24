# Canadian Rental Market Pressure Analysis
## Project Brief Deck

---

### Slide 1 — Title

# Canadian Rental Market Pressure Analysis
### Comparing cost, availability, and recent change across 43 Canadian rental markets
**Where multiple rental-market pressure signals appear together**

*Python + SQL + CMHC Rental Market Data (2024-2025)*

---

### Slide 2 — Problem

## Question:
### Which Canadian rental markets showed combinations of high rent, low vacancy, rapid rent growth, or declining vacancy between 2024 and 2025?

We monitor pressure using 4 key signals:

```
┌───────────────────────────┐     ┌───────────────────────────┐
│     High 2BR Rent         │     │        Low Vacancy        │
│   (Rent >= $1,802)        │     │      (Vacancy <= 2.5%)    │
└───────────────────────────┘     └───────────────────────────┘
┌───────────────────────────┐     ┌───────────────────────────┐
│     Fast Rent Growth      │     │    Vacancy Tightening     │
│   (Growth YoY >= 6.1%)    │     │   (Rate decreased YoY)    │
└───────────────────────────┘     └───────────────────────────┘
```

*Note: A higher score does not necessarily mean higher rent; it means more selected signals occurred at the same time.*

---

### Slide 3 — Data + Method

## Project Workflow
`CMHC Excel` ➔ `Python cleaning` ➔ `SQLite analysis` ➔ `Pressure labels` ➔ `Dashboard`

### Dataset Summary:
* **43 major centres** analyzed in total.
* **2024 and 2025 values** compared to track changes.
* **38 non-caution records** used to calculate data-driven benchmarks.
* **5 caution-quality records** retained but flagged (not used for benchmarks).

---

### Slide 4 — Markets with Combined Pressure Signals

## Markets with the most combined pressure signals
### A higher score does not necessarily mean higher rent; it means more selected signals occurred at the same time.

![Markets with Multiple Pressure Signals](/Users/ishmeet16/Documents/RMA/canadian-rental-market-pressure/outputs/charts/top_pressure_markets.png)

**Caption:**
*Nanaimo, St. John’s, and Saguenay led with 3 signals, while Halifax, Kingston, Kamloops, Sudbury, Saint John, and Quebec hit exactly 2 signals.*

---

### Slide 5 — Highest 2025 Rents (Cost Story)

## Highest 2025 Two-Bedroom Rents
### Looking at absolute costs across the top major markets.

![Highest 2025 Two-Bedroom Rents](/Users/ishmeet16/Documents/RMA/canadian-rental-market-pressure/outputs/charts/highest_rents.png)

**Caption:**
*Vancouver, Victoria, Kelowna, and Toronto had the highest two-bedroom rents, with Vancouver leading at $2,363.*

---

### Slide 6 — Explain the Difference (Scatterplot)

## Rent vs Vacancy Scatterplot

![Rent vs Vacancy Scatterplot](/Users/ishmeet16/Documents/RMA/canadian-rental-market-pressure/outputs/charts/rent_vs_vacancy_scatterplot.png)

**Key Message:**
*Vancouver had the highest rent, but Nanaimo had both high rent and low vacancy. Saguenay had lower rent but very tight vacancy and fast growth. This visualizes the separation of the cost story and the tightening story.*

---

### Slide 7 — Answer + Limits

## The Answer:
The analysis separates two patterns: high-cost markets and markets with rapidly tightening rental conditions. Markets with multiple signals may warrant closer monitoring, but the score does not measure affordability or identify causes.

* **High Cost:** Vancouver and Toronto had the highest two-bedroom rents in the dataset.
* **High Combined Pressure:** Nanaimo combined high rent with low and declining vacancy.
* **Emerging Pressure:** St. John’s and Saguenay were not among the highest-rent markets, but their low vacancy and rapid growth signals suggest emerging rental-market pressure.

### Limitations:
* **2024–2025 comparison only** (short-term window).
* **2BR rent is a standard measure**, not representative of every household or unit size.
* **No income data included**, so this is not an affordability score.
* **Patterns, not causes** (does not explain why rents/vacancies changed).

---
*Project brief deck + GitHub repo available.*
