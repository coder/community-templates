#!/usr/bin/env sh

# This scripts creates a new sample templatedir with requried files
# Run it like : ./new.sh my-template

TEMPLATE_NAME=$1

# Check if template name is provided
if [ -z "$TEMPLATE_NAME" ]; then
    echo "Usage: ./new.sh <template_name>"
    exit 1
fi

# Create template directory and exit if it alredy exists
if [ -d "$TEMPLATE_NAME" ]; then
    echo "Module with name $TEMPLATE_NAME already exists"
    echo "Please choose a different name"
    exit 1
fi
mkdir -p "${TEMPLATE_NAME}"

# Copy required files from the sample template
cp -r .sample/* "${TEMPLATE_NAME}"

# Change to template directory
cd "${TEMPLATE_NAME}"

# Detect OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    sed -i '' "s/TEMPLATE_NAME/${TEMPLATE_NAME}/g" main.tf
    sed -i '' "s/TEMPLATE_NAME/${TEMPLATE_NAME}/g" README.md
else
    # Linux
    sed -i "s/TEMPLATE_NAME/${TEMPLATE_NAME}/g" main.tf
    sed -i "s/TEMPLATE_NAME/${TEMPLATE_NAME}/g" README.md
fi