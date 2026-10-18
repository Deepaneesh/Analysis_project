# Gapminder Data Completion and Reconstruction

## Overview

This project works with the **Gapminder dataset** to complete missing yearly observations for countries from **1950 to 2010**.

The main objective is to create a complete annual dataset by interpolating and extrapolating missing values for:

* Life expectancy
* Population
* GDP
* GDP per capita

A key methodological decision is that **GDP per capita was not directly interpolated or extrapolated**. Instead, GDP was calculated from GDP per capita and population, GDP was then estimated, and GDP per capita was finally recalculated from GDP and population.

This preserves the mathematical relationship:

```text
GDP per capita = GDP / Population
```
The project uses a spline-based method through the `fill_spline()` function from my own R package.

---

## Dataset

The original Gapminder dataset contains observations for different countries and years. However, some countries do not have observations available for every year.


The project uses the **Gapminder dataset**, containing country-level observations for:

| Variable    | Description         |
| ----------- | ------------------- |
| `country`   | Country name        |
| `continent` | Continent           |
| `year`      | Year of observation |
| `lifeExp`   | Life expectancy     |
| `pop`       | Population          |
| `gdpPercap` | GDP per capita      |

The original dataset contains gaps in the yearly observations for some countries.


To make the dataset consistent, I created a complete yearly range from:

**1950 → 2010**

for every country.

Missing observations are then estimated using interpolation and extrapolation.

---

## Methodology

### 1. Creating a Complete Year Range

The original dataset does not contain observations for every year.

Therefore, the project creates a complete sequence of years from **1950 to 2010** for each country.

This allows the final dataset to have a consistent yearly structure.

---

### 2. Life Expectancy

Missing life expectancy values are estimated using the `fill_spline()` function from my own R package.

Both interpolation and extrapolation are performed where required.

---

### 3. Population

Missing population values are also estimated using the `fill_spline()` function.

The function is used to fill missing values within the available range and estimate values outside the observed range where necessary.

---

### 4. GDP

GDP is not directly available as a variable in the original data in the required form.

GDP is first calculated using:

```text
GDP = GDP per capita × Population
```

The calculated GDP is then used to estimate missing values through spline interpolation and extrapolation.

---

### 5. GDP Per Capita

GDP per capita is calculated from GDP and population:

```text
GDP per capita = GDP / Population
```

GDP per capita is **not directly interpolated or extrapolated**.

This is important because GDP per capita is mathematically derived from GDP and population. Estimating GDP per capita independently could make the relationship between GDP, population, and GDP per capita internally inconsistent.

Therefore, the project follows this process:

```text
GDP per capita + Population
            ↓
      Calculate GDP
            ↓
 Interpolate / Extrapolate
            ↓
       Estimated GDP
            ↓
 Estimated GDP / Population
            ↓
Estimated GDP per capita
```

This keeps the three measures internally consistent.

---

## Project Workflow

The project is divided into several stages:

```text
Original Gapminder Data
          ↓
Create complete years (1950–2010)
          ↓
Data Manipulation
          ↓
Identify missing observations
          ↓
Spline Interpolation / Extrapolation
          ↓
Estimate Population & Life Expectancy
          ↓
Calculate GDP
          ↓
Estimate GDP
          ↓
Recalculate GDP per capita
          ↓
Generate Completed Dataset
          ↓
Create Country-level Plots
          ↓
Save Final Output
```

---

## Project Structure

```text
Gapminder/
│
├── input/
│
├── script/
│   ├── set.const.R
│   ├── input.R
│   ├── data_manipulation.R
│   ├── forecasting.R
│   ├── plot.R
│   └── output.R
│
├── plot/
│   └── country-level PDF plots
│
├── output/
│   ├── original_life_exp.csv
│   ├── estimated_life_exp.csv
│   ├── original_population.csv
│   ├── estimated_population.csv
│   ├── original_gdp.csv
│   ├── estimated_gdp.csv
│   ├── original_gdp_per_capita.csv
│   └── estimated_gdp_per_capita.csv
│
└── README.md
```

---

## Scripts

### `set.const.R`

Contains project-level constants and configuration values used throughout the analysis.

### `input.R`

Handles reading and preparing the input data.

### `data_manipulation.R`

Performs data cleaning, restructuring, creation of the complete year range, and preparation of the data for estimation.

### `forecasting.R`

Performs interpolation and extrapolation using the `fill_spline()` function.

It estimates missing values for:

* Life expectancy
* Population
* GDP

GDP per capita is recalculated after GDP and population have been estimated.

### `plot.R`

Creates country-level visualizations.

Each country receives a combined **2 × 2 PDF dashboard** containing:

1. Life expectancy
2. GDP per capita
3. Population
4. GDP

For life expectancy:

* Original observations are displayed as **points**
* Estimated observations are displayed as a **line**

### `output.R`

Exports the original and completed datasets as CSV files.

---

## Output Data

The output folder contains separate files for each major indicator.

Examples:

```text
original_life_exp.csv
estimated_life_exp.csv

original_population.csv
estimated_population.csv

original_gdp.csv
estimated_gdp.csv

original_gdp_per_capita.csv
estimated_gdp_per_capita.csv
```

The **estimated files contain both the original and estimated values in the same completed series**.

For example:

```text
country       1950   1951   1952   ...   2010
Afghanistan   ...    ...    ...    ...   ...
Albania       ...    ...    ...    ...   ...
```

The data is stored in **wide format**:

* Countries are in rows
* Years are in columns
* Values represent the corresponding indicator

---

## Original vs Estimated Data

The project maintains the distinction between the original observations and the estimated values.

For visualization, the original observations can be compared with the completed series.

For example, in the life expectancy plot:

```text
Original observations → Points
Estimated values      → Line
```

This makes it easier to visually identify which values were originally available and which were estimated.

---

## Custom R Package

This project uses my own R package for reusable data analysis and data manipulation functions.

### RVD

**GitHub:**
https://github.com/Deepaneesh/RVD

The `fill_spline()` function from my package is used in this project to perform spline-based interpolation and extrapolation.

Using my own package makes the analysis more reusable and allows the same functions to be applied across different projects.

---

## R Packages

The project uses R packages for:

* Data manipulation
* Data visualization
* Plot composition
* Data processing
* Custom analytical functions

The custom `RVD` package is also used for the spline-based data completion process.

---

## Visualization

For every country, a combined PDF is generated in a **2 × 2 layout**.

The dashboard contains:

```text
┌───────────────────────┬───────────────────────┐
│    Life Expectancy    │     GDP Per Capita    │
│                       │                       │
├───────────────────────┼───────────────────────┤
│      Population       │          GDP          │
│                       │                       │
└───────────────────────┴───────────────────────┘
```

This provides a compact view of the country's historical development from 1950 to 2010.

---

## Key Methodological Principle

The most important methodological decision in this project is that **GDP per capita is not estimated independently**.

Since:

```text
GDP per capita = GDP / Population
```

GDP and population are estimated first, and GDP per capita is then recalculated.

This helps maintain the mathematical relationship between:

```text
GDP
Population
GDP per capita
```

and prevents inconsistencies that could occur if all three variables were estimated independently.

---

## Key Skills Demonstrated

This project demonstrates practical skills in:

* R programming
* Data manipulation
* Data cleaning
* Missing-value handling
* Interpolation
* Extrapolation
* Spline-based estimation
* Derived-variable calculation
* Data restructuring
* Time-series data processing
* Data visualization
* `ggplot2`
* `patchwork`
* CSV input/output
* Creating reusable R functions
* Using a personal R package in an analytical project

---

## Conclusion

This project transforms an incomplete Gapminder dataset into a **complete annual dataset covering 1950–2010** for each country.

Rather than independently estimating every variable, the project preserves the relationship between GDP, population, and GDP per capita by estimating GDP and population first and then recalculating GDP per capita.

The project also demonstrates how a **personal R package** can be developed and reused in real analytical workflows, with the `fill_spline()` function serving as a key component of the data completion process.
