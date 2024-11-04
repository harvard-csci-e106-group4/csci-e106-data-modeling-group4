#!/bin/bash

# Exit on error
set -e

echo "Starting project setup..."

# Clean up any existing setup
if [ -d ".git" ]; then
    echo "Removing existing git repository..."
    rm -rf .git
fi

# Ensure the directory is safe for git operations
echo "Configuring git safety..."
git config --global --add safe.directory "$(pwd)"

# Create the repository
echo "Creating GitHub repository..."
gh repo create ThanhPhong-Le/csci-e106-data-modeling-group4 \
  --public \
  --description "Harvard Extension School CSCI E-106 Data Modeling Group 4 Project"

# Create directory structure
echo "Creating project directory structure..."
mkdir -p {data/{raw,processed,external},doc,output/{figures,tables},R,renv}

# Create README files for output directories
echo "# Figures output directory" > output/figures/README.md
echo "# Tables output directory" > output/tables/README.md

# Create .gitignore
echo "Creating .gitignore..."
cat > .gitignore << 'EOF'
# History files
.Rhistory
.Rapp.history

# Session Data files
.RData
.RDataTmp

# User-specific files
.Ruserdata

# RStudio files
.Rproj.user/

# R Environment Variables
.Renviron

# R project files
*.Rproj

# Output files
output/*
!output/README.md
!output/figures/README.md
!output/tables/README.md

# renv library
renv/library/

# OS files
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db
EOF

# Create DESCRIPTION file
echo "Creating DESCRIPTION file..."
cat > DESCRIPTION << 'EOF'
Package: csci-e106-data-modeling-group4
Title: CSCI E-106 Data Modeling Group 4 Project
Version: 0.0.0.9000
Authors@R: 
    person("Group", "4", , "first.last@example.com", role = c("aut", "cre"))
Description: Harvard Extension School CSCI E-106 Data Modeling Group 4 Project
License: MIT + file LICENSE
Encoding: UTF-8
Roxygen: list(markdown = TRUE)
RoxygenNote: 7.2.3
Imports:
    # Core tidyverse packages
    tidyverse,
    dplyr,
    tidyr,
    readr,
    purrr,
    stringr,
    forcats,
    lubridate,
    
    # Data manipulation and cleaning
    data.table,
    janitor,
    dtplyr,
    vroom,
    
    # Visualization
    ggplot2,
    plotly,
    scales,
    viridis,
    patchwork,
    
    # Statistical modeling and machine learning
    stats,
    broom,
    caret,
    tidymodels,
    modelr,
    
    # Performance and optimization
    bench,
    profvis,
    
    # Documentation and reproducibility
    rmarkdown,
    knitr,
    bookdown,
    here,
    
    # Project management and development
    devtools,
    usethis,
    testthat,
    roxygen2,
    
    # Database connections
    DBI,
    RSQLite,
    
    # Advanced data structures
    tibble,
    matrices,
    
    # Functional programming
    purrr,
    furrr,
    
    # Quality control and testing
    checkmate,
    assertthat,
    
    # Parallel processing
    parallel,
    future,
    
    # Reporting and output
    gt,
    flextable,
    officer,
    
    # Version control integration
    gert,
    
    # Web scraping and API interaction
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

# Create R project file
echo "Creating R project file..."
cat > csci-e106-data-modeling-group4.Rproj << 'EOF'
Version: 1.0

RestoreWorkspace: No
SaveWorkspace: No
AlwaysSaveHistory: Default

EnableCodeIndexing: Yes
UseSpacesForTab: Yes
NumSpacesForTab: 2
Encoding: UTF-8

RnwWeave: Knitr
LaTeX: pdfLaTeX

AutoAppendNewline: Yes
StripTrailingWhitespace: Yes
LineEndingConversion: Posix
EOF

# Create basic R scripts
echo "Creating R script files..."
mkdir -p R
touch R/01_data_preparation.R
touch R/02_data_exploration.R
touch R/03_modeling.R
touch R/04_visualization.R

# Initialize git repository
echo "Initializing git repository..."
git init
git add .
git commit -m "Initial R project structure"
git branch -M main

# Add remote and push
echo "Setting up git remote and pushing..."
git remote add origin "git@github.com:ThanhPhong-Le/csci-e106-data-modeling-group4.git"
git push -u origin main

# Initialize R environment
echo "Setting up R environment..."
R --quiet -e 'if (!require("renv")) install.packages("renv", repos = "https://cloud.r-project.org")'
R --quiet -e 'renv::init(force = TRUE)'

# Create .Rprofile after renv initialization
echo "Creating .Rprofile..."
cat > .Rprofile << 'EOF'
source("renv/activate.R")
EOF

# Add collaborators using email invitations
echo "Adding collaborators..."
collaborators=(
    "sc.samuelcarvalho@gmail.com:admin"
    "joshuaswkim@gmail.com:write"
    "phani.sunke@gmail.com:write"
    "sya938@g.harvard.edu:write"
    "suk747@g.harvard.edu:write"
    "joshuarwhite99@gmail.com:write"
    "Reidlewisofficial@gmail.com:write"
    "lilly0813@gmail.com:write"
    "chundamazc@gmail.com:write"
)

for collab in "${collaborators[@]}"; do
    IFS=':' read -r email permission <<< "$collab"
    echo "Inviting $email with $permission permissions..."
    gh api \
        --method POST \
        "repos/ThanhPhong-Le/csci-e106-data-modeling-group4/invitations" \
        -f email="$email" \
        -f permission="$permission" || echo "Failed to invite $email"
done

# Final snapshot of R environment
echo "Creating final renv snapshot..."
R --quiet -e 'renv::snapshot()'

echo "Project setup complete!"