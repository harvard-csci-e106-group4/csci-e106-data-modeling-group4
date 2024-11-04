#!/bin/bash

# Create R script for final renv setup
cat > renv_fix.R << 'EOF'
# First, remove existing renv files
unlink("renv", recursive = TRUE)
unlink("renv.lock")

# Reinitialize renv
renv::init(bare = TRUE)

# Install all packages from DESCRIPTION
renv::install()

# Take a clean snapshot
renv::snapshot()

# Verify status
status <- renv::status()
print(status)
EOF

# Run the R script
R --vanilla -e "source('renv_fix.R')"

echo "renv setup complete!"