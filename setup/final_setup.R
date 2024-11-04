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
