# GDP Forecasting for Every Country

## 📌 Overview

This project analyzes **GDP data for countries across different years** using data obtained from the **World Bank**.

The project covers the complete workflow from data downloading and manipulation to GDP forecasting, visualization, and exporting the final results.

For each country, GDP values are forecasted using a **Spline Moving Average** method. The estimated values are then compared with the original GDP observations through visualizations.

The analysis also uses my **own R package** to perform reusable data analysis and manipulation tasks.

## 📊 Data Source

The GDP data was downloaded from the **World Bank**.

**Indicator:** GDP (current US$)

**Source:** [World Bank](https://data.worldbank.org/)

The dataset contains GDP observations for multiple countries across multiple years.

## 📁 Project Structure

```text
GDP/
│
├── input/
│   └── World Bank GDP data
│
├── script/
│   ├── constant.R
│   ├── data_download.R
│   ├── input.R
│   ├── data_manipulation.R
│   ├── data_forecasting.R
│   └── output.R
│
├── plot/
│   └── GDP forecast plots
│
├── output/
│   ├── original/
│   └── estimated/
│
└── README.md
```

## 🔄 Project Workflow

```text
World Bank
    ↓
Data Download
    ↓
Input Data
    ↓
Data Manipulation
    ↓
Analysis using my R package
    ↓
GDP Forecasting
    ↓
Visualization
    ↓
Output
```

## 🧩 Scripts

### `constant.R`

Contains constants and common values used throughout the project.

### `data_download.R`

Handles downloading the GDP data from the World Bank.

### `input.R`

Reads and prepares the downloaded input data for further processing.

### `data_manipulation.R`

Performs the required data cleaning, transformation, and manipulation before forecasting.

This stage also makes use of functions from my **own R package** to perform reusable analysis tasks.

### `data_forecasting.R`

Forecasts GDP values for each country using the **Spline Moving Average** method.

The forecasting process is applied separately to each country based on its historical GDP observations.

### `output.R`

Generates and saves the final datasets containing the original and estimated GDP values.

## 📈 Forecast Visualization

The forecast results are visualized by comparing:

* **Original GDP values** — represented as points
* **Estimated GDP values** — represented as a line

This allows the estimated trend to be visually compared with the original observations.

## 📦 Custom R Package

This project uses my **own R package** for reusable analysis and data manipulation functions.

The package contains functions developed to simplify and automate common analytical tasks.

Using a custom package helps keep the project code:

* Reusable
* Modular
* Consistent
* Easier to maintain

The package can be found here:

**[My R Analysis Package](https://github.com/Deepaneesh/RVD)**

## 📤 Output

The project generates two separate outputs:

### Original Data

Contains the original GDP observations obtained from the World Bank.

### Estimated Data

Contains the GDP values estimated using the Spline Moving Average forecasting method.

The outputs are stored separately in the `output` folder.

## 🛠️ Tools & Technologies

* **R**
* **Tidyverse**
* **Custom R package**
* **Spline Moving Average**
* **Data manipulation**
* **Data visualization**
* **World Bank data**

## 🎯 Objective

The main objective of this project is to build a reproducible workflow for:

1. Downloading economic data
2. Cleaning and manipulating the data
3. Applying reusable functions from my own R package
4. Forecasting GDP for individual countries
5. Comparing estimated values with original observations
6. Visualizing the results
7. Saving the processed and forecasted data

## 🚀 Future Improvements

Possible improvements include:

* Comparing the Spline Moving Average with other forecasting methods
* Adding forecast accuracy metrics
* Evaluating the model separately for different countries
* Adding GDP growth-rate analysis
* Extending the analysis to GDP per capita and GNI
* Automating the World Bank data download and forecasting pipeline
