-- ====================================================================
-- CANADIAN RENTAL MARKET PRESSURE ANALYSIS QUERIES (SQLite)
-- Version 1 Standardized Measure: average_rent_2br_2025
-- ====================================================================

-- --------------------------------------------------------------------
-- QUERY 1: 2025 MARKET OVERVIEW & RANKINGS
-- Business Question: Which major Canadian rental markets have the highest
-- rents in 2025, and what are their corresponding vacancy and turnover rates?
-- --------------------------------------------------------------------
-- (Displayed in overview section; not exported in V1)
SELECT 
    centre,
    vacancy_rate_2025,
    turnover_rate_2025,
    average_rent_2br_2025,
    rent_growth_pct_2024_2025,
    vacancy_change_pct_points,
    is_caution_quality
FROM rental_market_2024_2025
WHERE has_valid_rent_2025 = 1 
  AND has_valid_vacancy_2025 = 1
ORDER BY average_rent_2br_2025 DESC;


-- --------------------------------------------------------------------
-- QUERY 2: DATA-DRIVEN THRESHOLDS
-- Business Question: What are the thresholds for high rent (75th percentile),
-- low vacancy (25th percentile), rapid rent growth (75th percentile), and
-- vacancy tightening (25th percentile) for major Canadian rental markets in 2025?
-- Note: Calculated on valid, non-caution-quality records only.
-- --------------------------------------------------------------------
-- EXPORT: outputs/tables/rental_market_thresholds.csv
WITH 
rent_ordered AS (
    SELECT average_rent_2br_2025 as val,
           ROW_NUMBER() OVER (ORDER BY average_rent_2br_2025) as rn,
           COUNT(*) OVER () as total
    FROM rental_market_2024_2025
    WHERE has_valid_rent_2025 = 1 AND has_valid_vacancy_2025 = 1 AND is_caution_quality = 0 AND average_rent_2br_2025 IS NOT NULL
),
rent_thresh AS (
    SELECT val as high_rent_threshold
    FROM rent_ordered
    WHERE rn = CAST(ROUND(1 + 0.75 * (total - 1)) AS INT)
),
vacancy_ordered AS (
    SELECT vacancy_rate_2025 as val,
           ROW_NUMBER() OVER (ORDER BY vacancy_rate_2025) as rn,
           COUNT(*) OVER () as total
    FROM rental_market_2024_2025
    WHERE has_valid_rent_2025 = 1 AND has_valid_vacancy_2025 = 1 AND is_caution_quality = 0 AND vacancy_rate_2025 IS NOT NULL
),
vacancy_thresh AS (
    SELECT val as low_vacancy_threshold
    FROM vacancy_ordered
    WHERE rn = CAST(ROUND(1 + 0.25 * (total - 1)) AS INT)
),
growth_ordered AS (
    SELECT rent_growth_pct_2024_2025 as val,
           ROW_NUMBER() OVER (ORDER BY rent_growth_pct_2024_2025) as rn,
           COUNT(*) OVER () as total
    FROM rental_market_2024_2025
    WHERE has_valid_rent_2025 = 1 AND has_valid_vacancy_2025 = 1 AND is_caution_quality = 0 AND rent_growth_pct_2024_2025 IS NOT NULL
),
growth_thresh AS (
    SELECT val as rapid_rent_growth_threshold
    FROM growth_ordered
    WHERE rn = CAST(ROUND(1 + 0.75 * (total - 1)) AS INT)
),
tightening_ordered AS (
    SELECT vacancy_change_pct_points as val,
           ROW_NUMBER() OVER (ORDER BY vacancy_change_pct_points) as rn,
           COUNT(*) OVER () as total
    FROM rental_market_2024_2025
    WHERE has_valid_rent_2025 = 1 AND has_valid_vacancy_2025 = 1 AND is_caution_quality = 0 AND vacancy_change_pct_points IS NOT NULL
),
tightening_thresh AS (
    SELECT val as vacancy_tightening_threshold
    FROM tightening_ordered
    WHERE rn = CAST(ROUND(1 + 0.25 * (total - 1)) AS INT)
)
SELECT 
    (SELECT high_rent_threshold FROM rent_thresh) as high_rent_threshold,
    (SELECT low_vacancy_threshold FROM vacancy_thresh) as low_vacancy_threshold,
    (SELECT rapid_rent_growth_threshold FROM growth_thresh) as rapid_rent_growth_threshold,
    (SELECT vacancy_tightening_threshold FROM tightening_thresh) as vacancy_tightening_threshold;


-- --------------------------------------------------------------------
-- QUERY 3: RENTAL MARKET PRESSURE SEGMENTATION
-- Business Question: Which markets show the strongest signs of rental-market
-- pressure in 2025 based on thresholds for high rent, low vacancy, rapid rent
-- growth, and vacancy tightening?
-- --------------------------------------------------------------------
-- EXPORT: outputs/tables/rental_market_segments.csv
WITH 
thresholds AS (
    WITH 
    rent_ordered AS (
        SELECT average_rent_2br_2025 as val,
               ROW_NUMBER() OVER (ORDER BY average_rent_2br_2025) as rn,
               COUNT(*) OVER () as total
        FROM rental_market_2024_2025
        WHERE has_valid_rent_2025 = 1 AND has_valid_vacancy_2025 = 1 AND is_caution_quality = 0 AND average_rent_2br_2025 IS NOT NULL
    ),
    rent_thresh AS (
        SELECT val as high_rent_threshold
        FROM rent_ordered
        WHERE rn = CAST(ROUND(1 + 0.75 * (total - 1)) AS INT)
    ),
    vacancy_ordered AS (
        SELECT vacancy_rate_2025 as val,
               ROW_NUMBER() OVER (ORDER BY vacancy_rate_2025) as rn,
               COUNT(*) OVER () as total
        FROM rental_market_2024_2025
        WHERE has_valid_rent_2025 = 1 AND has_valid_vacancy_2025 = 1 AND is_caution_quality = 0 AND vacancy_rate_2025 IS NOT NULL
    ),
    vacancy_thresh AS (
        SELECT val as low_vacancy_threshold
        FROM vacancy_ordered
        WHERE rn = CAST(ROUND(1 + 0.25 * (total - 1)) AS INT)
    ),
    growth_ordered AS (
        SELECT rent_growth_pct_2024_2025 as val,
               ROW_NUMBER() OVER (ORDER BY rent_growth_pct_2024_2025) as rn,
               COUNT(*) OVER () as total
        FROM rental_market_2024_2025
        WHERE has_valid_rent_2025 = 1 AND has_valid_vacancy_2025 = 1 AND is_caution_quality = 0 AND rent_growth_pct_2024_2025 IS NOT NULL
    ),
    growth_thresh AS (
        SELECT val as rapid_rent_growth_threshold
        FROM growth_ordered
        WHERE rn = CAST(ROUND(1 + 0.75 * (total - 1)) AS INT)
    ),
    tightening_ordered AS (
        SELECT vacancy_change_pct_points as val,
               ROW_NUMBER() OVER (ORDER BY vacancy_change_pct_points) as rn,
               COUNT(*) OVER () as total
        FROM rental_market_2024_2025
        WHERE has_valid_rent_2025 = 1 AND has_valid_vacancy_2025 = 1 AND is_caution_quality = 0 AND vacancy_change_pct_points IS NOT NULL
    ),
    tightening_thresh AS (
        SELECT val as vacancy_tightening_threshold
        FROM tightening_ordered
        WHERE rn = CAST(ROUND(1 + 0.25 * (total - 1)) AS INT)
    )
    SELECT 
        (SELECT high_rent_threshold FROM rent_thresh) as high_rent_threshold,
        (SELECT low_vacancy_threshold FROM vacancy_thresh) as low_vacancy_threshold,
        (SELECT rapid_rent_growth_threshold FROM growth_thresh) as rapid_rent_growth_threshold,
        (SELECT vacancy_tightening_threshold FROM tightening_thresh) as vacancy_tightening_threshold
),
scored_centres AS (
    SELECT 
        m.centre,
        m.vacancy_rate_2024,
        m.vacancy_rate_2025,
        m.vacancy_change_pct_points,
        m.turnover_rate_2024,
        m.turnover_rate_2025,
        m.average_rent_2br_2024,
        m.average_rent_2br_2025,
        m.rent_growth_pct_2024_2025,
        m.is_caution_quality,
        (CASE WHEN m.average_rent_2br_2025 >= t.high_rent_threshold THEN 1 ELSE 0 END) +
        (CASE WHEN m.vacancy_rate_2025 <= t.low_vacancy_threshold THEN 1 ELSE 0 END) +
        (CASE WHEN m.rent_growth_pct_2024_2025 >= t.rapid_rent_growth_threshold THEN 1 ELSE 0 END) +
        (CASE WHEN m.vacancy_change_pct_points <= t.vacancy_tightening_threshold AND m.vacancy_change_pct_points < 0 THEN 1 ELSE 0 END) as market_pressure_score,
        (m.average_rent_2br_2025 >= t.high_rent_threshold) as is_high_rent,
        (m.vacancy_rate_2025 <= t.low_vacancy_threshold) as is_low_vacancy,
        (m.rent_growth_pct_2024_2025 >= t.rapid_rent_growth_threshold) as is_rapid_growth,
        (m.vacancy_change_pct_points <= t.vacancy_tightening_threshold AND m.vacancy_change_pct_points < 0) as is_vacancy_tightening
    FROM rental_market_2024_2025 m
    CROSS JOIN thresholds t
    WHERE m.has_valid_rent_2025 = 1 AND m.has_valid_vacancy_2025 = 1
)
SELECT 
    centre,
    vacancy_rate_2024,
    vacancy_rate_2025,
    vacancy_change_pct_points,
    turnover_rate_2024,
    turnover_rate_2025,
    average_rent_2br_2024,
    average_rent_2br_2025,
    rent_growth_pct_2024_2025,
    market_pressure_score,
    CASE 
        WHEN is_caution_quality = 1 THEN 'Caution-quality data'
        WHEN is_high_rent = 1 AND is_low_vacancy = 1 THEN 'High rent + low vacancy'
        WHEN is_low_vacancy = 1 AND is_rapid_growth = 1 THEN 'Low vacancy + rapid rent growth'
        WHEN is_high_rent = 1 AND is_rapid_growth = 1 THEN 'High rent + rapid rent growth'
        WHEN is_low_vacancy = 1 AND is_vacancy_tightening = 1 THEN 'Low vacancy + vacancy tightening'
        WHEN is_high_rent = 1 THEN 'High rent'
        WHEN is_rapid_growth = 1 THEN 'Rapid rent growth'
        WHEN is_vacancy_tightening = 1 THEN 'Vacancy tightening'
        ELSE 'Monitor'
    END as market_pressure_label,
    CASE 
        WHEN market_pressure_score = 0 THEN 'Stable or moderate conditions. Monitor.'
        ELSE rtrim(
            (CASE WHEN is_high_rent = 1 THEN 'High 2025 rent; ' ELSE '' END) ||
            (CASE WHEN is_low_vacancy = 1 THEN 'Low 2025 vacancy; ' ELSE '' END) ||
            (CASE WHEN is_rapid_growth = 1 THEN 'Rapid rent growth; ' ELSE '' END) ||
            (CASE WHEN is_vacancy_tightening = 1 THEN 'Vacancy tightening; ' ELSE '' END),
            '; '
        )
    END as pressure_reason,
    is_caution_quality
FROM scored_centres
ORDER BY market_pressure_score DESC, average_rent_2br_2025 DESC, vacancy_rate_2025 ASC;


-- --------------------------------------------------------------------
-- QUERY 4: 2024–2025 CHANGE SUMMARY
-- Business Question: How did rent and vacancy conditions change between 2024
-- and 2025 across centres?
-- --------------------------------------------------------------------
SELECT 
    centre,
    average_rent_2br_2024,
    average_rent_2br_2025,
    rent_growth_pct_2024_2025,
    vacancy_rate_2024,
    vacancy_rate_2025,
    vacancy_change_pct_points,
    turnover_rate_2024,
    turnover_rate_2025,
    CASE 
        WHEN rent_growth_pct_2024_2025 > 0 AND vacancy_change_pct_points < 0 THEN 'Rent rising + vacancy tightening'
        WHEN rent_growth_pct_2024_2025 > 0 AND vacancy_change_pct_points > 0 THEN 'Rent rising + vacancy easing'
        WHEN (rent_growth_pct_2024_2025 <= 0 OR rent_growth_pct_2024_2025 IS NULL) AND vacancy_change_pct_points < 0 THEN 'Rent stable/unknown + vacancy tightening'
        ELSE 'Monitor'
    END as change_label,
    is_caution_quality
FROM rental_market_2024_2025
WHERE has_valid_rent_2025 = 1 AND has_valid_vacancy_2025 = 1;


-- --------------------------------------------------------------------
-- QUERY 5: QUALITY REVIEW
-- Business Question: Which centres have data quality concerns (caution-quality
-- estimate flags or missing rent/vacancy/growth measures)?
-- --------------------------------------------------------------------
-- EXPORT: outputs/tables/rental_market_quality_review.csv
SELECT 
    centre,
    CASE 
        WHEN has_valid_rent_2025 = 0 THEN 'Missing 2025 average rent'
        WHEN has_valid_vacancy_2025 = 0 THEN 'Missing 2025 vacancy rate'
        WHEN is_caution_quality = 1 AND has_valid_rent_growth = 0 THEN 'Caution quality (flag d) & Missing rent growth'
        WHEN is_caution_quality = 1 THEN 'Caution quality (flag d)'
        WHEN has_valid_rent_growth = 0 THEN 'Missing rent growth'
        ELSE 'Other quality concern'
    END as quality_review_reason,
    is_caution_quality,
    has_valid_rent_2025,
    has_valid_vacancy_2025,
    has_valid_rent_growth,
    vacancy_quality_2025,
    rent_quality_2025,
    rent_growth_quality_2025
FROM rental_market_2024_2025
WHERE is_caution_quality = 1 
   OR has_valid_rent_growth = 0 
   OR has_valid_vacancy_2025 = 0 
   OR has_valid_rent_2025 = 0;
