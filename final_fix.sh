#!/bin/bash

# Create R script to install remaining packages
cat > final_fix.R << 'EOF'
# Ensure there's a newline at the end of DESCRIPTION
write(readLines("DESCRIPTION"), "DESCRIPTION", append = FALSE)

# Install remaining packages
install.packages(c(
    "bench",
    "gt",
    "assertthat",
    "bookdown",
    "flextable",
    "plotly",
    "viridis"
), repos = "https://cloud.r-project.org")

# Initialize renv
renv::init(force = TRUE)

# Take a snapshot
renv::snapshot()
EOF

# Run the R script
R --vanilla -e "source('final_fix.R')"

echo "Final fixes complete!"