# Labour Market Analysis

## Overview

This project performs a comprehensive **Labour Market Analysis** using labour-market data obtained from the **World Bank**.

The project combines labour-market indicators, estimates missing values, calculates employed/unemployed/other counts, validates the resulting data, and generates country-level visualizations.

---

## Project Structure

```text
Labour-Market-Analysis/
│
├── input/
│   └── Input data collected from the World Bank
│
├── plot/
│   └── Country-level PDF visualizations
│
├── output/
│   └── Final processed labour-market data
│
├── scripts/
│   ├── 01_constants/
│   │   └── Project constants and configuration
│   │
│   ├── 02_data_download/
│   │   └── World Bank data download scripts
│   │
│   ├── 03_input/
│   │   └── Input data preparation
│   │
│   ├── 04_data manipulation/
│   │   └── Data joining, transformation and calculations
│   │
│   ├── 05_forecasting/
│   │   └── Missing-value estimation and forecasting
│   │
│   ├── 06_plot/
│   │   └── Plot generation scripts
│   │
│   └── 07_output/
│       └── Output data preparation and export
│
├── 00_main.R
│   └── Main script that runs the complete workflow
│
└── README.md
    └── Project documentation
```

### Folder Description

| Folder/File | Description |
|---|---|
| `input/` | Contains the input datasets used for the analysis. |
| `plot/` | Contains the generated country-level PDF visualizations. |
| `output/` | Contains the final processed labour-market dataset. |
| `scripts/01_constants/` | Stores project constants and configuration values. |
| `scripts/02_data_download/` | Contains scripts used to download data from the World Bank. |
| `scripts/03_input/` | Contains scripts for preparing and structuring the input data. |
| `scripts/04_data manipulation/` | Contains scripts for joining, transforming and calculating the required indicators. |
| `scripts/05_forecasting/` | Contains scripts for estimating missing values and forecasting labour-market data. |
| `scripts/06_plot/` | Contains scripts used to generate the visualizations. |
| `scripts/07_output/` | Contains scripts for preparing and exporting the final output dataset. |
| `00_main.R` | Main entry-point script that runs the complete analysis workflow. |

---

# Data Description

The project uses **labour-market data from the World Bank** for multiple countries and years.

The data is used to analyse the size and composition of the labour force through labour-force, employment, and unemployment indicators.

## World Bank Indicators

The main source indicators used in the project are:

| Indicator | World Bank Indicator Name | Indicator Code |
|---|---|---|
| Labour Count | **Labor force, total** | `SL.TLF.TOTL.IN` |
| Employed Percentage | **Employment to population ratio, 15+, total (%) (modeled ILO estimate)** | `SL.EMP.TOTL.SP.ZS` |
| Unemployed Percentage | **Unemployment, total (% of total labor force) (modeled ILO estimate)** | `SL.UEM.TOTL.ZS` |

The World Bank identifies **Labor force, total** with indicator code `SL.TLF.TOTL.IN`. The indicator represents the total labour force and is sourced from labour statistics compiled by the ILO and other sources.

The unemployment indicator used in the analysis is **Unemployment, total (% of total labor force) (modeled ILO estimate)** with indicator code `SL.UEM.TOTL.ZS`.

### Derived Indicators

In addition to the World Bank indicators, the project derives additional indicators from the source data.

| Indicator | Description |
|---|---|
| **Other Percentage** | Calculated as `100 - Employed Percentage - Unemployed Percentage`. |
| **Employed Count** | Calculated using labour count and employed percentage. |
| **Unemployed Count** | Calculated using labour count and unemployed percentage. |
| **Other Count** | Calculated using labour count and other percentage. |

The three percentage categories are designed to satisfy:

```text
Employed Percentage
+ Unemployed Percentage
+ Other Percentage
= 100%
```

---

# Data Processing Workflow

```text
World Bank Data
      ↓
02_data_download
      ↓
03_input
      ↓
Data Joining
      ↓
Percentage Calculations
      ↓
04_data manipulation
      ↓
Missing Value Identification
      ↓
05_forecasting
      ↓
Spline Estimation
      ↓
Proportion Distribution
      ↓
Count Calculations
      ↓
06_plot
      ↓
Country-Level PDF
      ↓
07_output
      ↓
Final Processed Dataset
```

---

## Missing Value Estimation

Missing percentage values are estimated using the project's `fill_spline()` function.

Because percentages should not become negative, a logarithmic transformation is applied before spline estimation.

```text
Original Percentage
        ↓
      log()
        ↓
 fill_spline()
        ↓
      exp()
        ↓
Estimated Percentage
```

This approach helps constrain the estimated percentage values to positive values.

---

## Proportion Distribution

After estimating missing percentage values, the project ensures that the three labour-market categories sum to 100%.

The categories are:

- Employed
- Unemployed
- Others

The final relationship is:

```text
Employed %
+ Unemployed %
+ Others %
= 100%
```

A proportional distribution is applied where necessary to maintain this constraint.

---

## Labour Count Estimation

Missing labour-force counts are estimated using the `fill_spline()` function.

The estimated labour count is then combined with the estimated percentages to calculate the corresponding category counts.

---

## Count Calculations

### Employed Count

```text
Employed Count =
Labour Count × Employed Percentage / 100
```

### Unemployed Count

```text
Unemployed Count =
Labour Count × Unemployed Percentage / 100
```

### Other Count

```text
Other Count =
Labour Count × Other Percentage / 100
```

The final estimated variables include:

- `f_labour_count`
- `f_employed_percent`
- `f_unemployed_percent`
- `f_others_percent`
- `f_employed_count`
- `f_unemployed_count`
- `f_others_count`

---

# Visualization

The project generates a PDF containing visualizations for every country.

Each country is displayed on a **separate page** using a **2 × 2 layout**.

```text
┌──────────────────────────────┬──────────────────────────────┐
│ Estimated vs Actual          │ Labour-Market Counts         │
│ Employed Count               │                              │
│                              │ Estimated → Lines            │
│                              │ Actual → Points              │
├──────────────────────────────┼──────────────────────────────┤
│ Labour-Market Percentages    │ Labour-Market Composition    │
│                              │                              │
│ Estimated → Lines            │ Stacked Bar Chart            │
│ Actual → Points              │                              │
└──────────────────────────────┴──────────────────────────────┘
```

### Plot 1 — Estimated vs Actual Employed Count

Compares the estimated employed count with the available actual employed count.

### Plot 2 — Labour-Market Counts

Shows:

- Employed count
- Unemployed count
- Other count

Estimated values are displayed as **lines**, while actual observations are displayed as **points**.

### Plot 3 — Labour-Market Percentages

Shows:

- Employed percentage
- Unemployed percentage
- Other percentage

Estimated values are displayed as **lines**, while actual observations are displayed as **points**.

### Plot 4 — Labour-Market Composition

A stacked bar chart showing:

- Employed count
- Unemployed count
- Other count

This provides a visual representation of the composition of the labour force over time.

---

# Output Data

The processed data is saved in the `output/` folder.

The final output includes metadata such as:

- `status`
- `productname`
- `product_id`

Each product represents a specific labour-market indicator.

### Example Products

| Product | Description |
|---|---|
| Labour Count | Total labour force |
| Employed Percentage | Employment percentage |
| Unemployed Percentage | Unemployment percentage |
| Other Percentage | Remaining labour-force percentage |
| Employed Count | Number of employed people |
| Unemployed Count | Number of unemployed people |
| Other Count | Number of people in the other category |

---

## Output Data Format

## Output Data Structure

The final processed labour-market data is stored in a **wide format**, where each row represents a country and product combination, and each year is represented as a separate column.

```text
------------------- ┌────┬────┬────┬────┬────┬────────┐
Country/Product     │2010│2011│2012│2013│2014│ Status │
────────────────────┼────┼────┼────┼────┼────┼────────┤
Labour Count        │ ...│ ...│ ...│ ...│ ...│ AAACX  │
Employed %          │ ...│ ...│ ...│ ...│ ...│ AAACC  │
Unemployed %        │ ...│ ...│ ...│ ...│ ...│ AAACX  │
Other %             │ ...│ ...│ ...│ ...│ ...│ AACCC  │
Employed Count      │ ...│ ...│ ...│ ...│ ...│ AAACC  │
Unemployed Count    │ ...│ ...│ ...│ ...│ ...│ AAACC  │
Other Count         │ ...│ ...│ ...│ ...│ ...│ AAACC  │
────────────────────┴────┴────┴────┴────┴────┴────────┘
```

### Status Coding

The `add_status()` function generates a status string that records the status of each yearly value.

| Code | Meaning |
|---|---|
| `A` | Actual |
| `C` | Calculated |
| `X` | Missing |

Each character in the status string corresponds sequentially to the yearly values.

For example:

```text
Years:   2010  2011  2012  2013  2014
Values:   ...   ...   ...   ...   ...
Status:    A     A     A     C     X
```

The resulting status string is:

```text
AAACX
```

This indicates:

- `2010` → Actual
- `2011` → Actual
- `2012` → Actual
- `2013` → Calculated
- `2014` → Missing

Another example:

```text
Years:   2010  2011  2012  2013  2014
Status:    A     A     A     C     C

Status string: AAACC
```

Here, the first three years contain actual observations, while the values for 2013 and 2014 are calculated.

The status information allows the dataset to retain the **provenance of each yearly value** and distinguish between actual, calculated, and missing observations.

### Extracting Actual Values

The status string can also be used to identify the original actual observations from the processed data.

For example:

```text
Years:   2010  2011  2012  2013  2014
Values:   100   105   110   115    NA
Status:    A     A     A     C     X
```

Using the status information:

- `A` → retain the original actual value.
- `C` → value was calculated.
- `X` → value is missing.

Therefore, the original actual values are:

```text
100, 105, 110
```

This structure makes it possible to distinguish **actual observations from calculated and missing values** when performing further analysis or creating visualizations.

# Running the Project

The complete workflow can be executed using the main script:

```r
source("00_main.R")
```

The `00_main.R` script runs the different stages of the analysis using the scripts stored under the `scripts/` directory.

---

# Key Features

- World Bank labour-market data integration
- Automated data download
- Data preparation and joining
- Calculation of the Other category
- Missing-value estimation using spline interpolation
- Log/exp transformation for percentage estimation
- Proportion-based adjustment to ensure percentages sum to 100%
- Labour-force count estimation
- Employed, unemployed, and other count calculations
- Actual vs estimated comparison
- Country-level visualizations
- 2 × 2 PDF visualization layout
- Separate PDF page for each country
- Product-based output structure
- Status and product metadata
- Wide-format final dataset