# Population Distribution Analysis

## Overview

The Population Distribution Analysis project processes and analyses population data across countries and years. The project focuses on total population, gender distribution, and rural/urban population distribution, including both percentage and population-count measures.

The project also estimates missing values and maintains consistency between related population measures.

The analysis uses functions from the **RVD** R package, a custom package developed for reusable data-processing, estimation, and analytical functions.

This data is collected from the Worldbank Open Source

---
  
## Project Structure
  
  ```text
Population-Distribution-Analysis/
  ├── input/
  ├── plot/
  ├── output/
  ├── scripts/
  │   ├── 01_constants/
  │   ├── 02_data_download/
  │   ├── 03_input/
  │   ├── 04_data manipulation/
  │   ├── 05_forecasting/
  │   ├── 06_plot/
  │   └── 07_output/
  ├── 00_main.R
└── README.md
```

### Folder Description

- **input/** – Contains input datasets used for the analysis.
- **plot/** – Stores generated population distribution plots.
- **output/** – Contains processed and final output datasets.
- **scripts/** – Contains scripts for constants, data downloading, data manipulation, forecasting, visualization, and output generation.
- **00_main.R** – Main script used to run the complete analysis.
- **README.md** – Project documentation.

# Data Description

The project analyses population data by country and year, including total population, gender distribution, and rural/urban distribution.

## Population Indicators

| Indicator | Description |
  |---|---|
  | Total Population | Total population of the country |
  | Male Population | Population of males |
  | Female Population | Population of females |
  | Male Population Percentage | Percentage of total population that is male |
  | Female Population Percentage | Percentage of total population that is female |
  | Rural Population | Population living in rural areas |
  | Urban Population | Population living in urban areas |
  | Rural Population Percentage | Percentage of population living in rural areas |
  | Urban Population Percentage | Percentage of population living in urban areas |
  
  ## Derived Indicators
  
  The project derives population counts and percentages while maintaining consistency between related population measures.

### Gender Distribution

The following relationship is maintained:
  
  ```text
Male Population + Female Population = Total Population
```

and:
  
  ```text
Male Population Percentage + Female Population Percentage = 100%
```

### Rural and Urban Distribution

The following relationship is maintained:
  
  ```text
Rural Population + Urban Population = Total Population
```

and:
  
  ```text
Rural Population Percentage + Urban Population Percentage = 100%
```

# RVD Package

This project uses functions from the custom **RVD** R package:
  
  **RVD – Exploring, Automating, and Creating Useful R Functions**
  
  The package contains reusable functions for data processing, missing-value estimation, calculations, transformations, and analytical workflows.

The population analysis uses functions from RVD to simplify and standardize the data-processing workflow, rather than implementing all of these operations separately within the project scripts.

### RVD Functions Used

The project uses the following RVD & EconoR functions:
  
- `fill_spline_advance()` – Used for estimating missing values through spline-based interpolation.
- `fill_linear()` – Used for linear interpolation where applicable.
- `fill_median()` – Used for median-based missing-value handling where applicable.
- `fill_pattern()` – Used for pattern-based value filling where applicable.
- `add_status()` – Used to identify and combine actual, calculated/estimated, and missing values across the processed data.

The RVD package allows these functions to be reused across different analytical projects and keeps the project-specific scripts focused on the population analysis itself.

# Data Processing Workflow

## Missing Value Estimation

Missing population values are estimated using the available historical data.

Where sufficient historical observations are available, spline-based estimation is performed using the `fill_spline()` function from the RVD package.

The estimated values are stored separately from the original values to distinguish between actual and estimated observations.

## Population Distribution

Population distribution is calculated across two major dimensions:
  
  ### Gender
  
  The project calculates:
  
  - Male Population
- Female Population
- Male Population Percentage
- Female Population Percentage

The male and female components are adjusted where necessary to maintain consistency with total population.

### Rural and Urban

The project calculates:
  
  - Rural Population
- Urban Population
- Rural Population Percentage
- Urban Population Percentage

The rural and urban components are adjusted where necessary to maintain consistency with total population.

## Population Count Calculations

Population counts are derived from the corresponding population percentages and total population.

### Male Population

```text
Male Population =
  Total Population × Male Population Percentage / 100
```

### Female Population

```text
Female Population =
  Total Population × Female Population Percentage / 100
```

### Rural Population

```text
Rural Population =
  Total Population × Rural Population Percentage / 100
```

### Urban Population

```text
Urban Population =
  Total Population × Urban Population Percentage / 100
```

# Visualization

The project generates population distribution plots for each country.

The project generates a PDF containing visualizations for every country.

Each country is displayed on a **separate page** using a **3-row layout**.

```text
┌──────────────────────────────────────────────────────────────┐
│                      Country Name                            │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│                  Total Population                            │
│                                                              │
├──────────────────────────────┬───────────────────────────────┤
│ Gender Distribution %        │ Gender Distribution           │
│                              │                               │
│ Estimated → Lines            │ Estimated → Lines             │
│ Actual → Points              │ Actual → Points               │
├──────────────────────────────┼───────────────────────────────┤
│ Region Distribution %        │ Region Distribution           │
│                              │                               │
│ Estimated → Lines            │ Estimated → Lines             │
│ Actual → Points              │ Actual → Points               │
└──────────────────────────────┴───────────────────────────────┘
```

### Plot 1 — Total Population

Compares:
  
  - Actual total population
- Estimated total population

Estimated values are displayed as **lines**, while actual observations are displayed as **points**.

### Plot 2 — Population Gender Distribution %

Shows:
  
  - Male population percentage
- Female population percentage

Estimated values are displayed as **lines**, while actual observations are displayed as **points**.

### Plot 3 — Population Gender Distribution

Shows:
  
  - Male population
- Female population

Estimated values are displayed as **lines**, while actual observations are displayed as **points**.

### Plot 4 — Population Region Distribution %

Shows:
  
  - Rural population percentage
- Urban population percentage

Estimated values are displayed as **lines**, while actual observations are displayed as **points**.

### Plot 5 — Population Region Distribution

Shows:
  
  - Rural population
- Urban population

Estimated values are displayed as **lines**, while actual observations are displayed as **points**.

---

# Output Data

The final processed dataset is stored in a wide format.

# Output Data Format

The final processed population data is stored in a **wide format**, where each row represents a country and population product combination, and each year is represented as a separate column.

```text
------------------- ┌────┬────┬────┬────┬────┬────────┐
Country/Product     │2010│2011│2012│2013│2014│ Status │
────────────────────┼────┼────┼────┼────┼────┼────────┤
Total Population    │ ...│ ...│ ...│ ...│ ...│ AAACX  │
Male Population     │ ...│ ...│ ...│ ...│ ...│ AAACC  │
Female Population   │ ...│ ...│ ...│ ...│ ...│ AAACC  │
Male Population %   │ ...│ ...│ ...│ ...│ ...│ AAACC  │
Female Population % │ ...│ ...│ ...│ ...│ ...│ AAACC  │
Rural Population    │ ...│ ...│ ...│ ...│ ...│ AAACC  │
Urban Population    │ ...│ ...│ ...│ ...│ ...│ AAACC  │
Rural Population %  │ ...│ ...│ ...│ ...│ ...│ AAACC  │
Urban Population %  │ ...│ ...│ ...│ ...│ ...│ AAACC  │
────────────────────┴────┴────┴────┴────┴────┴────────┘
```

---

# Status Coding

The `add_status()` function generates a status string that records the status of each yearly value.

The status codes used by the project are:

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

---

# Extracting Actual Values

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

---
## Output Data Structure

The final output contains the following population indicators:
  
  1. Total Population
2. Male Population
3. Female Population
4. Male Population Percentage
5. Female Population Percentage
6. Rural Population
7. Urban Population
8. Rural Population Percentage
9. Urban Population Percentage

### Status Coding

The project maintains status information to distinguish between original and derived observations.

The status information is generated using the `add_status()` function from the RVD package.

### Extracting Actual Values

Actual values can be identified separately from estimated or calculated values using the status information maintained during the processing workflow.

# Running the Project

Run the main script:
  
  ```r
source("00_main.R")
```

The main script executes the complete workflow, including:
  
1. Loading input data
2. Data preparation
3. Missing-value estimation
4. Population distribution calculations
5. Population count calculations
6. Status assignment
7. Data reshaping
8. Visualization
9. Output generation

# Key Features

- Country-level population analysis
- Total population analysis
- Gender population distribution
- Rural and urban population distribution
- Percentage and population-count calculations
- Missing-value estimation
- Consistency checks between related population measures
- Actual and estimated value tracking
- Automated country-level visualization
- Wide-format output generation
- Reusable analytical functions through the **RVD** R package
- Standardized data-processing workflow using custom RVD functions