## Project Overview

Classify whether a passenger on board the maiden voyage of the RMS Titanic in 1912 survived given their age, sex and class.

## Due Date

December 18th, 2024 at 11:59 pm EST

## Project Structure

> fs::dir_tree()
.
# Project Root Directory Structure with Usage Comments

csci-e106-data-modeling-group4.Rproj  # RStudio project file - contains project settings and configuration

data/
  ├── raw/                  # Store original, immutable data files exactly as received
  ├── intermediate/         # Temporary data files during processing steps
  ├── interim/              # Partially processed data, may need further modifications
  ├── processed/            # Cleaned, validated, and ready-to-analyze data
  ├── derived/              # Data created from combining or transforming other datasets
  ├── external/             # Data from third-party sources, reference tables, lookup data
  ├── metadata/             # Data dictionaries, schemas, variable descriptions, README files
  ├── final/                # Final versions of datasets used in analysis/reporting
  └── results/              # Output data from analyses, models, and visualizations

docs/                       # Project documentation and reference materials
  ├── data_sources/         # Documentation of data origins, access methods, and citations
  ├── figures/              # Static images and diagrams for documentation
  ├── manuals/              # User guides, technical documentation, and how-to guides
  ├── manuscript/           # Draft papers, theses, or academic manuscripts
  ├── meeting_minutes/      # Records of team meetings and decisions
  ├── notebooks/            # Jupyter/R notebooks for exploratory analysis
  ├── papers/               # Related research papers and literature
  ├── project_description/  # Project objectives, scope, and requirements
  ├── references/           # Bibliography and reference materials
  ├── reports/              # Final analysis reports and deliverables
  ├── slides/               # Presentation materials
  ├── styles/               # CSS/styling files for reports and documentation
  ├── tutorials/            # Step-by-step guides and educational materials
  └── xlsx/                 # Excel files for documentation or small datasets

output/                     # Generated content from analysis
  ├── analysis/             # R Markdown/Quarto files for analysis reports
  ├── figures/              # Generated plots and visualizations
  ├── logs/                 # Execution logs and debug information
  ├── plots/                # Additional plotting outputs
  ├── tables/               # Generated summary tables and results
  └── tests/                # Test output and validation results

project/                    # Project-specific files
                            # Contains project templates and data files specific to this course

R/                          # R code and scripts
  ├── functions/            # Reusable R functions and utilities
  ├── models/               # Model definitions and fitting scripts
  └── scripts/              # Main analysis and processing scripts
      └── data_raw/         # Scripts for initial data import/download

setup/                      # Project setup and configuration scripts
                            # Contains shell scripts and R code for project initialization

src/                        # Source code for complex functions or external code
tests/                      # Unit tests and validation scripts
vignettes/                  # Long-form documentation and tutorials
inst/                       # Additional installation files

# Core Project Files
DESCRIPTION                # Project metadata and dependencies (if structured as R package)
LICENSE                    # Project license and usage terms
NAMESPACE                  # R package namespace definitions
README.md                  # Project overview and getting started guide
renv.lock                  # Package dependency management lockfile
renv/                      # Project-specific package library and settings

## Data Description

File: `project/Titanic_Survival_Data.csv`

### Variables

| Variable  | Description                                                       |
|-----------|-------------------------------------------------------------------|
| pclass    | Passenger Class (1st, 2nd, or 3rd)                                |
| survived  | Survival Status (0=No, 1=Yes)                                     |
| name      | Name of the Passenger                                             |
| sex       | Sex                                                               |
| sibsp     | Number of Siblings/Spouses aboard                                 |
| parch     | Number of Parents/Children aboard                                 |
| ticket    | Ticket Number                                                     |
| fare      | Passenger Fare                                                    |
| cabin     | Cabin number (e.g., "C85" = deck C, number 85)                    |
| embarked  | Port of Embarkation (C=Cherbourg, Q=Queenstown, S=Southampton)    |
| boat      | Lifeboat ID (if passenger survived)                               |
| body      | Body number (if passenger did not survive and body was recovered) |
| home.dest | The intended home destination of the passenger                    |

## Required R Packages

### Core Data Science & Modeling

# Data Manipulation
library(tidyverse)  # v2.0.0    # Meta-package for data manipulation
library(dplyr)      # v1.1.4    # Data manipulation
library(tidyr)      # v1.3.1    # Data tidying
library(purrr)      # v1.0.2    # Functional programming

# Statistical Modeling
library(caret)      # v6.0-94   # Classification and regression training
library(MASS)       # v7.3-60.2 # Modern applied statistics
library(rpart)      # v4.1.23   # Recursive partitioning
library(e1071)      # v1.7-16   # Statistical modeling
library(nnet)       # v7.3-19   # Neural networks

# Visualization
library(ggplot2)    # v3.5.1    # Data visualization
library(plotly)     # v4.10.4   # Interactive plots

### Project Management & Documentation

# Project Management
library(renv)       # v1.0.11   # Package management
library(here)       # v1.0.1    # File path management

# Documentation
library(knitr)      # v1.48     # Dynamic report generation
library(rmarkdown)  # v2.29     # R Markdown document generation

### Model Evaluation & Diagnostics

# Model Evaluation
library(pROC)       # v1.18.5   # ROC curves
library(ModelMetrics) # v1.2.2.2 # Model performance metrics
library(yardstick)  # v1.3.1    # Model metrics

# Data Processing
library(recipes)    # v1.1.0    # Feature engineering
library(rsample)    # v1.2.1    # Data sampling

### Development Tools

# Development
library(devtools)   # v2.4.5    # Package development tools
library(usethis)    # v3.0.0    # Project setup
library(testthat)   # v3.2.1.1  # Unit testing

## Getting Started

### Prerequisites

- R (version requirements to be specified)
- Required R packages (listed above)

### Installation

1. Clone the repository:

a. Install Git:
https://git-scm.com/downloads

b. Clone the repository:
git clone https://github.com/harvard-csci-e106-group4/csci-e106-data-modeling-group4.git

2. Open the project:

Double click on the `csci-e106-data-modeling-group4.Rproj` file to open the project in RStudio.

2. Install required packages:

# Restore project environment using renv
install.packages("renv")
renv::restore()

Now you are ready to start working on the project!

## Project Instructions

1. Load and Review the dataset "Titanic_Survival_Data.csv"
2. Create train data set (70%) using set.seed(1023) and test data set (30%)
3. Investigate data and combine categorical variables if needed, drop unnecessary variables
4. Build appropriate model to predict survival probability
5. Create scatter plots and correlation matrix for train data set
6. Build best models using appropriate selection method
7. Check model assumptions and apply remedy measures
8. Investigate unequal variances and multicollinearity
9. Build alternative models using:
   - Logistic regression
   - Classification Tree
   - NN
   - SVM
   - Negative binomial regression
   - Poisson regression
10. Use test data set to assess model performances
11. Determine primary (champion) model and benchmark model
12. Create model development document

## Report Structure (Points Distribution)

1. Executive Summary
2. Introduction (5 points)
3. Description of the data and quality (15 points)
4. Model Development Process (15 points)
5. Model Performance Testing (15 points)
6. Challenger Models (15 points)
7. Model Limitation and Assumptions (15 points)
8. Ongoing Model Monitoring Plan (5 points)
9. Conclusion (5 points)
10. Bibliography (7 points)
11. Appendix (3 points)

## Project Setup

This project uses:

- `renv` for package management
- `.gitignore` for Git version control configuration
- Project-specific documentation in the `doc/` directory

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## Notes

- No typographical errors, grammar mistakes, or misspelled words
- Use English language
- All tables must be numbered and described in document body
- All figures/graphs must be numbered and described
- All results must be accurate and clearly explained
- Submit both RMD markdown file and PDF with appropriate explanations
- A formal Word document can replace PDF file

## Team Members (Group 4 in Google Docs)

https://docs.google.com/spreadsheets/d/1TGn8OscLktORh_1CP5mt0YHNYAjscAV8-2GIj6o-EsE/edit?gid=0#gid=0

- [Member 1] Samuel Carvalho    sc.samuelcarvalho@gmail.com
- [Member 2] Thanh Phong Le     ltphongssvn@gmail.com 
- [Member 3] Josh Kim	          joshuaswkim@gmail.com
- [Member 4] Phani Sunke	      phani.sunke@gmail.com
- [Member 5] Hamza Ali	        sya938@g.harvard.edu
- [Member 6] Surabhi Khanal	    suk747@g.harvard.edu
- [Member 7] Joshua White	      joshuarwhite99@gmail.com
- [Member 8] Reid Lewis	        Reidlewisofficial@gmail.com
- [Member 9] Ying	              lilly0813@gmail.com
- [Member 10] Stephen Chundama	chundamazc@gmail.com
- [Member 11] Monika Kumaria	  mok257@g.harvard.edu

## License

This project is private and for educational purposes as part of Harvard Extension School's CSCI E-106 course.
