# SCMS Delivery Analysis

**End-to-end Data Science & Supply Chain Analytics Project**

![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-4479A1?style=for-the-badge&logo=postgresql&logoColor=white)
![Pandas](https://img.shields.io/badge/pandas-150458?style=for-the-badge&logo=pandas&logoColor=white)

## Overview
Comprehensive analysis of the **Supply Chain Management System (SCMS)** Delivery History dataset. This project focuses on global shipment of life-saving health commodities (ARVs and lab reagents) for USAID and PEPFAR programs.

The goal is to uncover insights into logistics efficiency, freight costs, lead times, and delivery performance through **Exploratory Data Analysis (EDA)**, data cleaning, and visualization.

## Key Features
- **Exploratory Data Analysis (EDA)**: Shipment modes, country-wise distribution, commodity insights
- **Advanced Data Cleaning**: Python + **SQL** (handling missing values, semantic placeholders, date standardization, deduplication)
- **Feature Engineering**: Lead Time, On-Time In-Full (OTIF), Freight Cost modeling
- **Professional Visualizations**: Freight spend by country, shipment mode mix, lead time boxplots, missing data analysis
- **Reproducible Pipeline**: Clean SQL queries included

## Technologies Used
- **Python** (pandas, numpy, matplotlib, seaborn, plotly, missingno)
- **SQL** (Data cleaning, deduplication, and validation)
- **Jupyter Notebook**

## Repository Contents
- `SCMS_Delivery_Analysis_Project.ipynb` → Main Jupyter Notebook
- `SCMS_Delivery_Analysis_Project_updated.docx` → Full project documentation
- `scms_clean_query.sql` → SQL data cleaning script
- `SCMS_Delivery_History_data.csv` → Original dataset (if included)

## How to Run
```bash
# 1. Clone the repository
git clone https://github.com/your-username/SCMS-Delivery-Analysis.git

# 2. Install dependencies
pip install pandas numpy matplotlib seaborn plotly missingno

# 3. Open the notebook
jupyter notebook SCMS_Delivery_Analysis_Project.ipynb
