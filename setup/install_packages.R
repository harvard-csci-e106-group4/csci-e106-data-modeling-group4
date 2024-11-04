# List of required packages
packages <- c(
    "assertthat",
    "bookdown",
    "flextable",
    "officer",
    "plotly",
    "viridis"
)

# Install packages
for (pkg in packages) {
    if (!require(pkg, character.only = TRUE)) {
        install.packages(pkg, repos = "https://cloud.r-project.org")
    }
}

# Update renv snapshot
renv::snapshot()
