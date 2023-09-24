#!/usr/bin/env sh

# This scripts creates a new template dir with requried files
# Run it like : ./new.sh my-template

TEMPLATE_NAME=$1
# Check if template name is provided
if [ -z "$TEMPLATE_NAME" ]; then
    echo "Usage: ./new.sh <template_name>"
    exit 1
fi

# Create template directory and exist if it alredy exists
if [ -d "$TEMPLATE_NAME" ]; then
    echo "Module with name $TEMPLATE_NAME already exists"
    echo "Please choose a different name"
    exit 1
fi
mkdir -p "${TEMPLATE_NAME}"

# Copy required files from the sample template
cp -r .sample/* "${TEMPLATE_NAME}"
# Update main.tf with template name
sed -i "s/TEMPLATE_NAME/${TEMPLATE_NAME}/g" main.tf
# Update README.md with template name
sed -i "s/TEMPLATE_NAME/${TEMPLATE_NAME}/g" README.md

# Change to template directory
cd "${TEMPLATE_NAME}"
