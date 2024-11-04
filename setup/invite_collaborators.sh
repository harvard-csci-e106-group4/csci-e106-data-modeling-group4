#!/bin/bash

# Enable debug mode
set -x

REPO="ThanhPhong-Le/csci-e106-data-modeling-group4"

# Function to check if repository exists
check_repo() {
    echo "Checking GitHub authentication and repository..."
    gh repo view "$REPO"
}

# Function to invite collaborator
invite_collaborator() {
    local email="$1"
    local permission="$2"

    echo "Attempting to invite $email with $permission permission..."

    # Use gh cli's built-in add command
    gh repo add-collaborator "$REPO" "$email" --permission "$permission" && \
    echo "Successfully invited $email" || \
    { echo "Failed to invite $email"; return 1; }
}

# Main script
echo "Starting collaborator invitation process..."

# Check repository access first
check_repo

# Store collaborator information
declare -A collaborators=(
    ["sc.samuelcarvalho@gmail.com"]="admin"
    ["joshuaswkim@gmail.com"]="push"
    ["phani.sunke@gmail.com"]="push"
    ["sya938@g.harvard.edu"]="push"
    ["suk747@g.harvard.edu"]="push"
    ["joshuarwhite99@gmail.com"]="push"
    ["Reidlewisofficial@gmail.com"]="push"
    ["lilly0813@gmail.com"]="push"
    ["chundamazc@gmail.com"]="push"
)

# Process each collaborator
for email in "${!collaborators[@]}"; do
    echo "-------------------------------------------"
    echo "Processing invitation for: $email"
    permission="${collaborators[$email]}"

    # For admin permission, use admin, otherwise use push
    if [ "$permission" = "admin" ]; then
        actual_permission="admin"
    else
        actual_permission="push"
    fi

    invite_collaborator "$email" "$actual_permission" || \
    echo "Warning: Failed to process invitation for $email"
    sleep 2  # Rate limiting precaution
done

echo "-------------------------------------------"
echo "Process completed"

# Show pending invitations
echo "Pending invitations:"
gh api "repos/$REPO/invitations"
