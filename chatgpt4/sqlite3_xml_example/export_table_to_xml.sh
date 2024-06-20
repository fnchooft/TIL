#!/bin/bash

# Function to display usage
usage() {
    echo "Usage: $0 <database-name> <table-name> [--include-schema]"
    exit 1
}

# Check if the correct number of arguments is provided
if [ "$#" -lt 2 ] || [ "$#" -gt 3 ]; then
    usage
fi

DATABASE_NAME=$1
TABLE_NAME=$2
INCLUDE_SCHEMA=false

if [ "$#" -eq 3 ] && [ "$3" == "--include-schema" ]; then
    INCLUDE_SCHEMA=true
fi

OUTPUT_FILE="${TABLE_NAME}.xml"

# Check if the database file exists
if [ ! -f "$DATABASE_NAME" ]; then
    echo "Database file '$DATABASE_NAME' does not exist."
    exit 1
fi

# Check if the table exists in the database
TABLE_EXISTS=$(sqlite3 "$DATABASE_NAME" "SELECT name FROM sqlite_master WHERE type='table' AND name='$TABLE_NAME';")

if [ -z "$TABLE_EXISTS" ]; then
    echo "Table '$TABLE_NAME' does not exist in the database '$DATABASE_NAME'."
    exit 1
fi


rm -rf schema

# Get schema if requested
if [ "$INCLUDE_SCHEMA" == true ]; then
    sed "s|TABLE_NAME|$TABLE_NAME|g" get_schema.tmpl             | sqlite3 "$DATABASE_NAME" > schema
    sed "s|TABLE_NAME|$TABLE_NAME|g" get_schema_constraints.tmpl | sqlite3 "$DATABASE_NAME" >> schema
    SCHEMA=`cat schema`
else
    SCHEMA=""
fi

# Export the table to XML using the AWK script
sqlite3 -header -separator "|" "$DATABASE_NAME" "SELECT * FROM $TABLE_NAME;" | awk -v table=$TABLE_NAME -v schema="$SCHEMA" -f export_to_xml.awk > "$OUTPUT_FILE"

echo "Table '$TABLE_NAME' has been exported to '$OUTPUT_FILE'."

