#!/bin/bash
set -x

echo "Starting collaborator invitation process..."

check_auth() {
    echo "Checking GitHub authentication..."
    gh auth status
}

invite_collaborator() {
    local email=$1
    local permission=$2

    echo "Attempting to invite ${email} with ${permission} permission..."
    # Remove leading slash from API endpoints for Git Bash compatibility
    gh api \
        --method POST \
        -H "Accept: application/vnd.github+json" \
        -H "X-GitHub-Api-Version: 2022-11-28" \
        "repos/ThanhPhong-Le/csci-e106-data-modeling-group4/invitations" \
        -f email="${email}" \
        -f permission="${permission}" \
        --verbose

    if [ $? -ne 0 ]; then
        echo "Failed to invite ${email}. Error code: $?"
        return 1
    fi
}

# Check authentication first
check_auth

# Define collaborators and their permissions
declare -A collaborators
collaborators=(
    ["sc.samuelcarvalho@gmail.com"]="admin"
    ["joshuaswkim@gmail.com"]="write"
    ["phani.sunke@gmail.com"]="write"
    ["sya938@g.harvard.edu"]="write"
    ["suk747@g.harvard.edu"]="write"
    ["joshuarwhite99@gmail.com"]="write"
    ["Reidlewisofficial@gmail.com"]="write"
    ["lilly0813@gmail.com"]="write"
    ["chundamazc@gmail.com"]="write"
)

# Check current invitations before starting
echo "Current invitations before starting:"
gh api \
    -H "Accept: application/vnd.github+json" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    "repos/ThanhPhong-Le/csci-e106-data-modeling-group4/invitations"

# Process each collaborator
for email in "${!collaborators[@]}"; do
    permission=${collaborators[$email]}
    echo "-------------------------------------------"
    echo "Processing invitation for: $email"
    invite_collaborator "$email" "$permission"
    echo "-------------------------------------------"
done

# Check final state
echo "Checking current invitations after completion..."
gh api \
    -H "Accept: application/vnd.github+json" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    "repos/ThanhPhong-Le/csci-e106-data-modeling-group4/invitations"

echo "Current collaborators:"
gh api \
    -H "Accept: application/vnd.github+json" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    "repos/ThanhPhong-Le/csci-e106-data-modeling-group4/collaborators"

echo "Process completed"
