# Canadian Rental Market Pressure Analysis
## Project Brief Deck

---

### Slide 1 — Title

# Canadian Rental Market Pressure Analysis
### Python + SQL + CMHC Rental Market Data
**2024–2025 comparison across 43 major centres**

*A study on how combined market signals highlight rental pressure across Canada.*

---

### Slide 2 — Problem

## Question:
### Which Canadian rental markets showed the strongest pressure signals in 2025?

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

*Note: High rent alone does not mean highest pressure. The strongest pressure comes from combined signals.*

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

### Slide 4 — Main Finding

## Top 10 Pressure-Signal Markets

![Top 10 Pressure-Signal Markets](/Users/ishmeet16/Documents/RMA/canadian-rental-market-pressure/outputs/charts/top_pressure_markets.png)

**Caption:**
*Nanaimo, St. John’s, and Saguenay had the most combined pressure signals (Score 3), but for different reasons.*

---

### Slide 5 — Explain the Difference

## Rent vs Vacancy Scatterplot

![Rent vs Vacancy Scatterplot](/Users/ishmeet16/Documents/RMA/canadian-rental-market-pressure/outputs/charts/rent_vs_vacancy_scatterplot.png)

**Key Message:**
*Vancouver had the highest rent, but Nanaimo had both high rent and low vacancy. Saguenay had lower rent but very tight vacancy and fast growth.*

---

### Slide 6 — Answer + Limits

## The Answer:
Rental pressure looked different across cities. Some markets were expensive, some were tight, and some were changing quickly. **Nanaimo, St. John’s, Saguenay, and Halifax** were the strongest markets to monitor based on combined signals.

### Limitations:
* **2024–2025 comparison only** (short-term window).
* **2BR rent is a standard measure**, not representative of every household or unit size.
* **No income data included**, so this is not an affordability score.
* **Patterns, not causes** (does not explain why rents/vacancies changed).

---
*Project brief deck + GitHub repo available.*
