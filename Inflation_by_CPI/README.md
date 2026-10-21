# Inflation Analysis Using CPI

## Overview

This project analyzes **inflation across countries using Consumer Price Index (CPI) data** obtained from the **World Bank**.

The CPI data contains missing years for some countries. To create a continuous time series, missing CPI values are **interpolated and extrapolated using a custom spline-based function** available in my R package.

After estimating the missing CPI values, the **inflation rate is calculated from the CPI growth rate**.

The project also generates country-level visualizations showing the CPI series and the corresponding inflation rate.

---

## Objectives

The main objectives of this project are:

* Download CPI data for countries from the World Bank.
* Prepare and clean the CPI dataset.
* Identify missing years and missing CPI values.
* Interpolate and extrapolate missing CPI values.
* Use a custom spline function from my own R package for estimation.
* Calculate inflation rates from CPI.
* Compare original and estimated CPI and inflation values.
* Generate country-level plots for CPI and inflation.
* Export the processed datasets to Excel files.

---

## Data Source

The CPI data is obtained from the **World Bank**.

**Indicator used:**

`FP.CPI.TOTL`

**Indicator:** Consumer Price Index (2010 = 100)

Inflation is estimated from the growth rate of CPI:

$$
Inflation_t =
\frac{CPI_t-CPI_{t-1}}{CPI_{t-1}}\times100
$$

Therefore:

> **CPI → Growth rate of CPI → Inflation rate (%)**

---

## Methodology

The analysis follows the workflow below:

```text
World Bank CPI Data
        ↓
Data Preparation
        ↓
Identify Missing Years / Values
        ↓
Spline Interpolation & Extrapolation
        ↓
Estimated CPI
        ↓
Calculate CPI Growth Rate
        ↓
Estimated Inflation
        ↓
Output Excel Files
        ↓
Country-level PDF Plots
```

### 1. CPI Data Download

CPI data is downloaded from the World Bank for countries and years available in the dataset.

### 2. Data Preparation

The downloaded data is cleaned and structured for analysis.

The data is grouped by country and arranged chronologically before performing interpolation, extrapolation, and inflation calculations.

### 3. CPI Interpolation and Extrapolation

Missing CPI values are estimated using a custom spline-based function:

```r
fill_spline_advance()
```

The function is part of my own R package:

**RVD – Exploring, Automating, and Creating Useful R Functions**

The package contains custom functions developed for data analysis, including spline-based interpolation and extrapolation.

### 4. Inflation Calculation

Once the CPI series is completed, inflation is calculated from the year-over-year growth rate of CPI.

$$
Inflation_t =
\left(
\frac{CPI_t}{CPI_{t-1}}-1
\right)\times100
$$

This produces inflation as an annual percentage.

Both original and estimated CPI values are used to calculate their corresponding inflation series.

---

## Project Structure

```text
Inflation_CPI/
│
├── 00_main.r
│
├── input/
│   └── Raw / input data
│
├── output/
│   ├── original_cpi.xlsx
│   ├── estimated_cpi.xlsx
│   ├── original_inflation.xlsx
│   └── estimated_inflation.xlsx
│
├── plots/
│   └── Country-level PDF plots
│
└── scripts/
    ├── constants.r
    ├── data_download.r
    ├── input.r
    ├── data_manipulation.r
    ├── forecast.r
    └── output.r
```

---

## Scripts

### `00_main.r`

The main script that controls the complete workflow.

It executes the individual scripts in the required order.

### `constants.r`

Contains project-level constants and configurations used throughout the analysis.

### `data_download.r`

Downloads the CPI data from the World Bank.

### `input.r`

Reads and prepares the input data required for the analysis.

### `data_manipulation.r`

Performs data cleaning, transformation, grouping, sorting, and preparation of the CPI dataset.

### `forecast.r`

Performs CPI interpolation and extrapolation using the custom spline function from my R package.

The estimated CPI values are then used to calculate estimated inflation.

### `output.r`

Creates and saves the final Excel outputs and other processed results.

---

## Outputs

The project generates four main Excel files:

### Original CPI

Contains the CPI values available in the original World Bank dataset.

```text
original_cpi.xlsx
```

### Estimated CPI

Contains the CPI series after interpolation and extrapolation.

```text
estimated_cpi.xlsx
```

### Original Inflation

Contains inflation calculated from the original CPI observations.

```text
original_inflation.xlsx
```

### Estimated Inflation

Contains inflation calculated from the estimated CPI series.

```text
estimated_inflation.xlsx
```

---

## Visualization

Country-level plots are generated and saved as PDF files.

Each country is represented on a separate page.

The plot follows the structure:

```text
┌──────────────────────────────┐
│                              │
│          CPI Plot            │
│                              │
├──────────────────────────────┤
│                              │
│       Inflation Plot         │
│                              │
└──────────────────────────────┘
```

### CPI Plot

The upper plot shows the CPI series, allowing comparison between original and estimated CPI values.

### Inflation Plot

The lower plot shows the corresponding inflation rate derived from CPI.

This structure makes it easier to visually compare:

* Original vs. estimated CPI
* Original vs. estimated inflation
* The behavior of the estimated series in interpolated and extrapolated regions

---

## R Package Used

This project uses functions from my own R package:

**RVD – Exploring, Automating, and Creating Useful R Functions**

The package contains reusable functions developed for data manipulation, interpolation, forecasting, and analysis.

In particular, the project uses the custom:

```r
fill_spline_advance()
```

function for CPI interpolation and extrapolation.

---

## Technologies Used

* **R**
* **World Bank Data**
* **tidyverse**
* **worldbank**
* **Custom R package – RVD**
* **Spline-based interpolation and extrapolation**
* **Excel output**
* **PDF visualization**

---

## Key Analysis

The main analytical relationship used in this project is:

$$
CPI \rightarrow CPI\ Growth \rightarrow Inflation
$$

A higher growth rate in CPI indicates higher consumer-price inflation, while a lower growth rate indicates lower inflation.

The project therefore uses the estimated CPI series as the foundation for generating the corresponding estimated inflation series.

---

## Reproducibility

To reproduce the analysis:

1. Clone or download the repository.
2. Install the required R packages.
3. Ensure the custom **RVD** package is installed and available.
4. Run:

```r
source("00_main.r")
```

The main script will execute the complete workflow from data preparation through forecasting, output generation, and plotting.

---

## Project Workflow Summary

```text
                World Bank
                    │
                    ▼
              CPI Data
                    │
                    ▼
            Data Manipulation
                    │
                    ▼
       Missing CPI Identification
                    │
                    ▼
      fill_spline_advance()
                    │
          ┌─────────┴─────────┐
          ▼                   ▼
    Original CPI        Estimated CPI
          │                   │
          ▼                   ▼
  Original Inflation   Estimated Inflation
          │                   │
          └─────────┬─────────┘
                    ▼
              Excel Outputs
                    │
                    ▼
             Country Plots
                    │
                    ▼
                  PDF
```

## Conclusion

This project provides a country-level analysis of inflation using CPI data from the World Bank. Missing CPI observations are estimated using a custom spline-based interpolation and extrapolation method, and the resulting CPI series is used to derive inflation rates.

The project demonstrates a complete analytical workflow covering **data acquisition, data preparation, interpolation/extrapolation, inflation estimation, output generation, and visualization**.
