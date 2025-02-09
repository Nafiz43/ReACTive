import json
import pandas as pd

json_data = []

# Function to filter JSON data based on the feature list
def filter_json_by_features(data, features):
    filtered_data = []
    for entry in data:
        entry_features = set(map(str.strip, entry.get("Features", "").split(",")))
        if any(feature in entry_features for feature in features):
            filtered_data.append(entry)
    return filtered_data

def calculate_feature_differences(df, month_n, feature_list):
    avg_feature_values = {}
    for feature in feature_list:
        avg_feature_values[feature] = df[feature].mean()
        # print("Average", avg_feature_values)

    # Calculate the monthly feature values for the month n-1 to n+1
    monthly_feature_values = {}
    for feature in feature_list:
        # Filter the dataframe for the relevant months (n-1 to n+1)
        monthly_values = df[(df['month'] >= month_n-2) & (df['month'] <= month_n)][feature]
        monthly_feature_values[feature] = monthly_values.sum()  # Summing the monthly values
        # print("Monthly", monthly_feature_values)

    # Calculate the difference between monthly_feature_values and average_feature_values
    differences = {}
    for feature in feature_list:
        differences[feature] = monthly_feature_values[feature] - avg_feature_values[feature]

    # Get the features with differences <= 0
    negative_or_zero_features = [feature for feature, diff in differences.items() if diff <= 0]

    return negative_or_zero_features




def ReACT_Extractor(original_data, feature_data: pd.DataFrame, month_n: int) -> dict:
    feature_list = ['s_avg_clustering_coef', 't_num_dev_nodes', 't_num_dev_per_file', 't_graph_density', 'st_num_dev', 't_net_overlap'] #features impacting positive outcomes
    processed_features = calculate_feature_differences(feature_data, month_n, feature_list) 
    # print(processed_features)
    filtered_json = filter_json_by_features(original_data, processed_features)
    sorted_json = sorted(filtered_json, key=lambda x: x["Importance"], reverse=True)
    # print(json.dumps(sorted_json, indent=4))
    with open("extracted_react.json", 'w') as json_file:
        json.dump(sorted_json, json_file, indent=4)
    print("ReACTs Saved in `extracted_react.json` file.")
    print("ReACT Set is Provided to you! :)")
    return sorted_json




feature_data = pd.read_csv('Apache-Kafka-Data.csv')
month_n = 9
with open("react_set.json", 'r') as json_file:
    original_data = json.load(json_file)


reacts_to_recommend=ReACT_Extractor(original_data, feature_data, month_n)
