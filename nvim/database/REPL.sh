#!/usr/bin/env bash
# REPL.sh

DB="$1"  # first argument: path to database script

if [[ -z "$DB" ]]; then
    echo "Usage: $0 path/to/database_script.sh"
    exit 1
fi

echo "==========================================================================="
echo "Currently connect to script:"
cat $DB
echo "==========================================================================="
echo "Database streaming REPL. Type your queries and press Enter."
echo "Ctrl+D to exit."
echo "==========================================================================="

while read query; do

    # skip empty lines
    [[ -z "$query" ]] && continue

    # execute query and stream output
    echo "$query" | "$DB" | csvlook
done

