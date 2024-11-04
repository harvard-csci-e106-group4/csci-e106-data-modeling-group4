#!/bin/bash

echo "Installing renv package..."
R --vanilla -e 'install.packages("renv", repos = "https://cloud.r-project.org")'

echo "Initializing renv..."
R --vanilla -e 'renv::init(restart = FALSE)'

echo "Creating .Rprofile..."
echo 'source("renv/activate.R")' > .Rprofile

echo "Taking renv snapshot..."
R --vanilla -e 'renv::snapshot()'

echo "R environment setup complete!"