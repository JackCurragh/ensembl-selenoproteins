
#!/bin/bash

# Define the input TSV file
tsv_file="data/ensembl_rapid_species.tsv"

# Check if the TSV file exists
if [ ! -f "$tsv_file" ]; then
    echo "Error: TSV file not found: $tsv_file"
    exit 1
fi

# Loop through each row in the TSV file
tail -n +2 "$tsv_file" | while IFS=$'\t' read -r species accession clade; do
    echo "Processing: Species=$species, Accession=$accession, Clade=$clade"

    # Run the Python script with the specified arguments
    time python scripts/rapid_fetch.py -s "$species" -a "$accession" --file-type 'gtf' --write-url
done
