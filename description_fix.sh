#!/bin/bash

# Create a new DESCRIPTION file
cat > DESCRIPTION << 'EOF'
Package: csci-e106-data-modeling-group4
Title: CSCI E-106 Data Modeling Group 4 Project
Version: 0.0.0.9000
Authors@R: person("Group", "4", , "first.last@example.com", role = c("aut", "cre"))
Description: Harvard Extension School CSCI E-106 Data Modeling Group 4 Project
License: MIT + file LICENSE
Encoding: UTF-8
Roxygen: list(markdown = TRUE)
RoxygenNote: 7.2.3
Imports:
    tidyverse,
    dplyr,
    tidyr,
    readr,
    purrr,
    stringr,
    forcats,
    lubridate,
    data.table,
    janitor,
    dtplyr,
    vroom,
    ggplot2,
    plotly,
    scales,
    viridis,
    patchwork,
    stats,
    broom,
    caret,
    tidymodels,
    modelr,
    bench,
    profvis,
    rmarkdown,
    knitr,
    bookdown,
    here,
    devtools,
    usethis,
    testthat,
    roxygen2,
    DBI,
    RSQLite,
    tibble,
    purrr,
    furrr,
    checkmate,
    assertthat,
    parallel,
    future,
    gt,
    flextable,
    officer,
    gert,
    httr2,
    rvest,
    jsonlite
Suggests:
    spelling,
    covr,
    lintr,
    styler
Config/testthat/edition: 3
Language: en-US

EOF

# Create R script for final package setup
cat > final_setup.R << 'EOF'
# Install any missing packages from DESCRIPTION
desc <- read.dcf("DESCRIPTION")
imports <- strsplit(desc[,"Imports"], ",\\s*")[[1]]
suggests <- strsplit(desc[,"Suggests"], ",\\s*")[[1]]
packages <- c(imports, suggests)

# Clean package names
packages <- gsub("\\s+", "", packages)
packages <- packages[packages != ""]

# Install missing packages
for(pkg in packages) {
    if (!require(pkg, character.only = TRUE)) {
        install.packages(pkg, repos = "https://cloud.r-project.org")
    }
}

# Reinitialize renv
renv::init(force = TRUE)

# Take final snapshot
renv::snapshot()
EOF

# Run the R script
R --vanilla -e "source('final_setup.R')"

echo "Setup complete!"