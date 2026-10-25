# GDP and Population Analysis

## Overview

This project focuses on analysing **Gross Domestic Product (GDP)** and **population data** for countries around the world. The data is obtained from the **World Bank** and is used to estimate missing values, calculate GDP per capita, and analyse GDP and GDP-per-capita growth rates.

The project uses two primary datasets:

* **GDP**
* **Population**

These datasets are cleaned, processed, combined, and used to derive additional economic indicators.

---

## Data Source

The data used in this project is obtained from the **World Bank**.

The project primarily uses:

* GDP data
* Population data

The GDP and population datasets are combined using common country and year identifiers.

---

## Project Objectives

The main objectives of this project are:

1. Download GDP and population data from the World Bank.
2. Clean and standardise the downloaded datasets.
3. Complete missing years for each country.
4. Combine GDP and population data.
5. Estimate missing observations using spline-based methods.
6. Calculate GDP per capita.
7. Calculate GDP growth rates.
8. Calculate GDP-per-capita growth rates.
9. Compare GDP growth with GDP-per-capita growth.
10. Generate country-level PDF reports and visualisations.

---

## Project Structure

```text
GDP/
│
├── input/
│   ├── GDP/
│   └── population/
│
├── output/
│
├── plot/
│
└── scripts/
```

### `input/`

Contains the input datasets downloaded from the World Bank.

### `input/GDP/`

Contains GDP-related data.

### `input/population/`

Contains population-related data.

### `output/`

Contains processed datasets and final analytical outputs.

### `plot/`

Contains the PDF reports and visualisations generated for each country.

### `scripts/`

Contains the R scripts used for downloading, processing, estimating, and analysing the data.

---

## RVD Package

This project uses **RVD**, a custom R package developed to provide reusable functions for data processing, estimation, and analysis.

The package is designed around the idea of:

> **Exploring, Automating, and Creating Useful R Functions**

RVD provides reusable functions that simplify common data-analysis tasks and help create a consistent analytical workflow.

### RVD GitHub Repository

The package is available on GitHub:

**https://github.com/Deepaneesh/RVD**

### Functions Used in This Project

#### `trimed_data()`

Used to trim and standardise the input data before further processing.

```r
gdp_data %<>% trimed_data()
pop_data %<>% trimed_data()
```

#### `fill_spline_advance()`

Used to estimate missing observations using spline-based interpolation and extrapolation.

The function is applied after a logarithmic transformation for GDP and population estimation.

Example:

```r
fill_spline_advance(
  back = FALSE,
  outside = FALSE,
  n = 5
)
```

#### `growth_rate()`

Used to calculate year-over-year growth rates.

```r
growth_rate <- function(x) {
  c(NA, diff(x) / head(x, -1) * 100)
}
```

This function is used to calculate:

* Population growth
* GDP growth
* GDP-per-capita growth

#### `apply_growth_rate_tail()`

Used to adjust estimated GDP values based on estimated growth rates.

```r
apply_growth_rate_tail(
  f_gdp,
  f_pop_gr,
  left_tail = TRUE,
  right_tail = FALSE
)
```

This allows the estimated series to follow the expected growth pattern rather than relying only on direct spline estimation.

### Why Use RVD?

Using the RVD package provides several advantages:

* Reusable functions
* Consistent data-processing methods
* Reduced repetitive code
* Easier maintenance
* Standardised estimation procedures
* Functions that can be reused across different economic datasets and projects

The package is continuously being expanded with additional data manipulation, statistical, forecasting, and utility functions.

---

## Data Processing

The GDP and population datasets go through several processing steps.

### 1. Selecting Required Variables

Only the required columns are retained from the downloaded datasets:

* Year
* Country ID
* Country Name
* Country Code
* Value

The value column is then renamed appropriately to `gdp` or `pop`.

### 2. Data Cleaning

Country identifiers are checked to ensure that observations contain either a valid country code or country ID.

The data is also trimmed using the RVD `trimed_data()` function.

### 3. Completing Missing Years

The project ensures that each country has a complete sequence of years.

Missing years are added so that subsequent estimation and growth-rate calculations can be performed consistently.

### 4. Combining GDP and Population

GDP and population data are joined using:

* Year
* Country Name
* Country ID
* Country Code

This creates a combined dataset containing both GDP and population information.

### 5. GDP per Capita

GDP per capita is calculated as:

```text
GDP Per Capita = GDP / Population
```

This provides an additional indicator for comparing economic output relative to population size.

---

## Missing Value Estimation

Missing GDP and population observations are estimated using spline-based methods from the RVD package.

The general process includes:

1. Applying a logarithmic transformation.
2. Estimating missing observations using spline interpolation/extrapolation.
3. Converting the estimated values back to their original scale.
4. Calculating growth rates.
5. Adjusting estimated values using growth-rate information.

This approach helps produce a more complete time series while maintaining a smoother progression between observations.

---

## Growth Rate Calculation

The project calculates growth rates for several variables.

The general growth-rate formula is:

```text
Growth Rate = ((Current Value - Previous Value) / Previous Value) × 100
```

The project calculates:

* Population growth rate
* GDP growth rate
* GDP-per-capita growth rate

---

## GDP and GDP-Per-Capita Growth

One of the main analytical components of the project is comparing **GDP growth** with **GDP-per-capita growth**.

GDP per capita is calculated as:

```text
GDP Per Capita = GDP / Population
```

The relationship between the growth rates can be approximately represented as:

```text
GDP Per Capita Growth
≈ GDP Growth - Population Growth
```

This comparison helps understand how changes in total economic output relate to changes in economic output per person.

For example:

* If GDP grows faster than GDP per capita, population growth may be contributing to the difference.
* If GDP per capita grows faster than GDP, population growth may be negative or very low.
* Comparing the two measures provides additional insight into changes in economic output relative to population.

---

## Plots and Visualisation

The project generates **PDF reports for each country**.

Each country is presented on a **separate page** in the PDF output.

Each country page contains four plots arranged in a **2 × 2 layout**.

### Plots Included

The four plots are:

1. **GDP Per Capita**
2. **GDP Growth Rate vs GDP-Per-Capita Growth Rate**
3. **GDP**
4. **Population**

The 2 × 2 layout provides a compact view of the country's economic and population trends on a single page.

### Plot Layout

```text
┌──────────────────────────┬──────────────────────────┐
│                          │                          │
│      GDP Per Capita      │   GDP Growth Rate vs    │
│                          │ GDP-Per-Capita Growth   │
│                          │                          │
├──────────────────────────┼──────────────────────────┤
│                          │                          │
│           GDP            │       Population         │
│                          │                          │
│                          │                          │
└──────────────────────────┴──────────────────────────┘
```

### Original vs Estimated Values

The plots distinguish between **original observations** and the **estimated time series**.

* **Points** represent the original values available in the source data.
* **Lines** represent the estimated values.
* When an original value is available, the estimated line passes through that original point.
* When an observation is missing, the line provides the estimated value for that period.

This makes it possible to visually compare the original observations with the estimated series.

Conceptually:

```text
Original value  → Point
Estimated value → Line
```

When an original observation exists, the estimated line passes through the corresponding point:

```text
          ●
        /   \
------●------●----------------
      ↑
 Original observation
 Estimated line passes through it
```

Therefore, the plots provide both:

* A visual representation of the original World Bank observations.
* A continuous estimated series covering the required time period.

### Country-Level PDF Output

The final plots are generated in **PDF format**, with each country occupying a separate page.

This makes the output easy to review country by country and allows the complete analysis to be shared as a single PDF report.

---

## Estimation Workflow

```text
World Bank Data
      │
      ▼
Data Cleaning
      │
      ▼
Complete Missing Years
      │
      ▼
Combine GDP + Population
      │
      ▼
RVD Spline Estimation
      │
      ▼
Calculate GDP Per Capita
      │
      ▼
Calculate Growth Rates
      │
      ▼
Apply Growth-Rate Adjustments
      │
      ▼
Generate Country-Level Plots
      │
      ▼
PDF Report
      │
      ├── GDP Per Capita
      ├── GDP Growth vs GDP-Per-Capita Growth
      ├── GDP
      └── Population
```

---

## Key Variables

The final dataset contains variables such as:

| Variable           | Description                   |
| ------------------ | ----------------------------- |
| `year`             | Year of observation           |
| `country_name`     | Country name                  |
| `country_id`       | World Bank country identifier |
| `country_code`     | Country code                  |
| `gdp`              | GDP value                     |
| `pop`              | Population                    |
| `gdp_per_capita`   | GDP per capita                |
| `f_gdp`            | Estimated GDP                 |
| `f_pop`            | Estimated population          |
| `f_pop_gr`         | Population growth rate        |
| `f_gdp_gr`         | GDP growth rate               |
| `f_gdp_per_capita` | Estimated GDP per capita      |
| `f_gdp_percap_gr`  | GDP-per-capita growth rate    |

---

## Tools and Technologies

The project is developed using:

* **R**
* **Tidyverse**
* **World Bank data**
* **RVD**
* Spline-based interpolation and extrapolation
* Data manipulation and transformation
* Data visualisation
* PDF report generation

---

## Future Improvements

The project can be further improved in the following areas.

### Multiple Data Sources

Currently, the project primarily uses data from the World Bank.

In the future, GDP and population data can be collected from multiple reliable sources, such as:

* World Bank
* IMF
* United Nations
* National statistical agencies
* Other official economic databases

Using multiple sources can help improve the reliability and completeness of the final dataset.

### Cross-Source Validation

Values from different sources can be compared to identify discrepancies.

A validation framework could be developed to:

1. Compare values across sources.
2. Identify large differences.
3. Check the methodology used by each source.
4. Select the most appropriate value.
5. Flag observations that require further investigation.

### Improving Missing Values

Multiple sources can also be used to fill missing observations rather than relying only on interpolation or extrapolation.

This can improve the quality of the estimated time series.

### Automated Data Updates

The data-download process can be automated so that the latest GDP and population data can be retrieved without manually downloading the files.

### Additional Economic Indicators

Future versions could include additional macroeconomic indicators such as:

* Inflation
* GDP growth
* Employment
* Exports
* Imports
* Urban population
* CO₂ emissions
* Government expenditure
* Foreign direct investment

This would allow the project to perform a broader economic analysis.

### Improved Forecasting

Additional forecasting and estimation techniques could be explored, including:

* Time-series forecasting
* Regression-based estimation
* State-space models
* ARIMA
* Machine-learning-based methods

These methods could be compared with the current spline-based approach to determine which provides better estimates.

### Further RVD Development

The RVD package can also be expanded with additional reusable functions for:

* Data cleaning
* Missing-value treatment
* Time-series analysis
* Forecasting
* Statistical analysis
* Data validation
* Automated reporting

This would allow future projects to reuse the same functions and create a consistent analytical workflow.

---

## Conclusion

This project provides a workflow for processing GDP and population data, estimating missing observations, calculating GDP per capita, and analysing economic growth across countries.

By combining GDP and population data and comparing GDP growth with GDP-per-capita growth, the project provides additional insight into changes in economic output relative to population.

The use of the **RVD package** makes the workflow more reusable and modular by providing custom functions for data cleaning, spline-based estimation, growth-rate calculation, and growth-rate-based adjustments.

The country-level PDF reports provide a clear visual summary of the analysis, with each country presented on a separate page containing four plots in a **2 × 2 layout**:

* GDP per capita
* GDP growth rate vs GDP-per-capita growth rate
* GDP
* Population

The plots show **original observations as points** and the **estimated time series as lines**, with the estimated line passing through available original observations.

Future development will focus on **integrating multiple data sources, improving data validation, increasing data completeness, expanding the RVD package, and developing more robust estimation and forecasting methods**.
