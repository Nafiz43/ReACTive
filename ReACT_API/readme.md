# ReACT Extractor

This script processes a JSON file containing ReACT data and filters out the relevant entries based on the average and monthly feature values from a provided project dataset. It then saves the filtered and sorted ReACT entries into a new JSON file.

## Table of Contents

- [Description](#description)
- [Input](#input)
- [Output](#output)
- [Mechanism](#mechanism)
- [Usage](#usage)

## Description

The `ReACT Extractor` filters a given JSON dataset of ReACT entries, calculates feature value differences based on the provided dataset, and sorts the entries based on a computed importance score. The script outputs the filtered, sorted ReACT entries in a new JSON file.

## Input

1. **JSON Data**: The script expects a JSON file (`react_set.json`) that contains an array of ReACT entries. Each entry must include the following keys:
    - `ReACT-ID`: Unique identifier of the ReACT entry
    - `ReACT_title`: Title of the ReACT entry
    - `Entity_responsible`: A list of entities responsible for the ReACT
    - `Features`: Comma-separated string of features associated with the ReACT
    - `Importance`: A numeric value representing the importance of the ReACT entry
    - `References` and `Articles`: (Optional) Additional information related to the ReACT

2. **Feature Data**: The script expects a CSV file (`Apache-Kafka-Data.csv`) containing feature values. The CSV should include:
    - A `month` column (integer values representing months)
    - Columns for each of the features (e.g., `s_avg_clustering_coef`, `t_num_dev_nodes`, etc.)

3. **Month**: The script accepts an integer `month_n`, which represents the target month for the analysis. It calculates values for the months from `n-2` to `n+1`.

## Output

1. **Filtered and Sorted JSON**: The script outputs a JSON file (`extracted_react.json`) that contains the filtered ReACT entries, sorted by their `Importance` key in descending order. It returns the sorted data as a Python list of dictionaries.

## Mechanism

1. **Feature Calculation**:
   - The script first calculates the average feature values for a given list of features over the entire dataset.
   - It then computes the monthly feature values for the period from month `n-2` to `n`.
   - It calculates the difference between the monthly feature values and the average feature values.
   - The script identifies the features where the difference is less than or equal to 0 (i.e., negative or zero differences).

2. **Filtering JSON Data**:
   - The script filters the ReACT JSON entries by checking if any of the features from the given list match the features in the `Features` field of each ReACT entry.
   
3. **Sorting**:
   - After filtering, the script sorts the remaining entries by the `Importance` key in descending order.

4. **Saving Output**:
   - The filtered and sorted entries are saved in a new JSON file (`extracted_react.json`).

## Usage

1. Ensure you have the required libraries installed:
   - `json`
   - `pandas`

2. Place your original ReACT data in a JSON file (`react_set.json`) and your feature data in a CSV file (`Apache-Kafka-Data.csv`).

3. Modify the `month_n` variable to the target month you want to analyze.

4. Run the script:
   ```bash
   python react_api.py
