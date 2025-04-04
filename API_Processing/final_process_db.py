# import pandas as pd

# # Load the data
# df = pd.read_parquet("performance_db.parquet")

# # Keep only rows for 'weighted avg'
# weighted = df[df["label"] == "weighted avg"]


# # Extract only f1-score rows for median computation
# f1_scores = weighted[weighted["metric"] == "f1-score"]

# # Only consider relevant strategies
# strategies = [
#     "A-1-1n^ --> A-1-1n^^",
#     "A-1-1n --> E-2-2n",
#     "A-1-1cn --> O-2-2cn",
#     "A-1-1cn --> G-3-4cn",
#     "E-2-2cn --> A-1-1cn",
#     "E-2-2cn^ --> E-2-2cn^^",
#     "E-2-2cn --> O-2-2cn",
#     "E-2-2cn --> G-3-4cn",
#     "O-2-2cn --> A-1-1cn",
#     "O-2-2cn --> E-2-2cn",
#     "O-2-2cn^ --> O-2-2cn^^",
#     "O-2-2cn --> G-3-4cn",
#     "A-1-1cn^ + O-2-2cn --> A-1-1cn^^",
#     "A-1-1cn^ + O-2-2cn --> E-2-2cn",
#     "A-1-1cn^ + O-2-2cn^ --> O-2-2cn^^",
#     "A-1-1cn + O-2-2cn --> G-3-4cn",
#     "E-2-2cn + O-2-2cn --> A-1-1cn",
#     "E-2-2cn^ + O-2-2cn --> E-2-2cn^^",
#     "E-2-2cn + O-2-2cn^ --> O-2-2cn^^",
#     "E-2-2cn + O-2-2cn --> G-3-4cn",
#     "A-1-1cn^ + E-2-2cn --> A-1-1cn^^",
#     "A-1-1cn + E-2-2cn^ --> E-2-2cn^^",
#     "A-1-1cn + E-2-2cn --> O-2-2cn",
#     "A-1-1cn + E-2-2cn --> G-3-4cn",
#     "A-1-1cn^ + E-2-2cn + O-2-2cn --> A-1-1cn^^",
#     "A-1-1cn + E-2-2cn^ + O-2-2cn --> E-2-2cn^^",
#     "A-1-1cn + E-2-2cn + O-2-2cn^ --> O-2-2cn^^",
#     "A-1-1cn + E-2-2cn + O-2-2cn --> G-3-4cn",
#     "A-1-1cn^ + E-2-2cn^ + O-2-2cn^ --> A-1-1cn^^ + E-2-2cn^^ + O-2-2cn^^"
# ]
# f1_scores = f1_scores[f1_scores["transfer_strategy"].isin(strategies)]

# # Get median trial per strategy based on f1-score
# median_dates = (
#     f1_scores
#     .sort_values(["transfer_strategy", "perf"])
#     .groupby("transfer_strategy")
#     .nth(7)  # 8th row (0-indexed) out of 15 trials → median
#     .reset_index()
#     [["transfer_strategy", "date"]]
# )

# # Merge back to full dataset to keep precision, recall, f1-score for those dates
# # Filter for 'weighted avg' label only
# weighted = weighted[weighted["transfer_strategy"].isin(strategies)]

# # Inner join on transfer_strategy + date to get all metrics for median trial
# median_trials_full = pd.merge(weighted, median_dates, on=["transfer_strategy", "date"])

# # (Optional) Save the final median trial rows to a file
# median_trials_full.to_parquet("median_trials_full_metrics.parquet", index=False)

# # Preview
# print(median_trials_full.sort_values(["transfer_strategy", "metric"]))


import pandas as pd

# Load the data
df = pd.read_parquet("d_performance_db.parquet")

# Keep only rows where label == "weighted avg"
weighted = df[df["label"] == "weighted avg"]

# Select only f1-score rows for median computation
f1_scores = weighted[weighted["metric"] == "f1-score"]

# Define your strategies
strategies = [
    "A-1-1n^ --> A-1-1n^^",
    "A-1-1n --> E-2-2n",
    "A-1-1cn --> O-2-2cn",
    "A-1-1cn --> G-3-4cn",
    "E-2-2cn --> A-1-1cn",
    "E-2-2cn^ --> E-2-2cn^^",
    "E-2-2cn --> O-2-2cn",
    "E-2-2cn --> G-3-4cn",
    "O-2-2cn --> A-1-1cn",
    "O-2-2cn --> E-2-2cn",
    "O-2-2cn^ --> O-2-2cn^^",
    "O-2-2cn --> G-3-4cn",
    "A-1-1cn^ + O-2-2cn --> A-1-1cn^^",
    "A-1-1cn^ + O-2-2cn --> E-2-2cn",
    "A-1-1cn^ + O-2-2cn^ --> O-2-2cn^^",
    "A-1-1cn + O-2-2cn --> G-3-4cn",
    "E-2-2cn + O-2-2cn --> A-1-1cn",
    "E-2-2cn^ + O-2-2cn --> E-2-2cn^^",
    "E-2-2cn + O-2-2cn^ --> O-2-2cn^^",
    "E-2-2cn + O-2-2cn --> G-3-4cn",
    "A-1-1cn^ + E-2-2cn --> A-1-1cn^^",
    "A-1-1cn + E-2-2cn^ --> E-2-2cn^^",
    "A-1-1cn + E-2-2cn --> O-2-2cn",
    "A-1-1cn + E-2-2cn --> G-3-4cn",
    "A-1-1cn^ + E-2-2cn + O-2-2cn --> A-1-1cn^^",
    "A-1-1cn + E-2-2cn^ + O-2-2cn --> E-2-2cn^^",
    "A-1-1cn + E-2-2cn + O-2-2cn^ --> O-2-2cn^^",
    "A-1-1cn + E-2-2cn + O-2-2cn --> G-3-4cn",
    "A-1-1cn^ + E-2-2cn^ + O-2-2cn^ --> A-1-1cn^^ + E-2-2cn^^ + O-2-2cn^^"
]
f1_scores = f1_scores[f1_scores["transfer_strategy"].isin(strategies)]

# Step 1: Get median trial date per strategy based on f1-score
median_dates = (
    f1_scores
    .sort_values(["transfer_strategy", "perf"])
    .groupby("transfer_strategy")
    .nth(7)  # median index (0-based) out of 15
    .reset_index()
    [["transfer_strategy", "date"]]
)

# Step 2: Filter original `weighted` DataFrame for those median trials
median_trials = pd.merge(weighted, median_dates, on=["transfer_strategy", "date"])

# Step 3: Pivot the metrics (precision, recall, f1-score) into columns
pivoted = median_trials.pivot_table(
    index=["date", "transfer_strategy", "model_arch"],
    columns="metric",
    values=["perf", "support"],
    aggfunc="first"
).reset_index()

# Flatten multi-index column names
pivoted.columns = ['date', 'transfer_strategy', 'model_arch',
                   'f1-score', 'precision', 'recall',
                   'support_f1', 'support_precision', 'support_recall']

# Sanity check: support should be same across metrics — pick one
pivoted["support"] = pivoted[["support_f1", "support_precision", "support_recall"]].max(axis=1)

# Final column selection & order
final = pivoted[["date", "transfer_strategy", "model_arch", "precision", "recall", "f1-score", "support"]]

# Save to CSV

final['precision'] = (final['precision'] * 100).round(2)
final['recall'] = (final['recall'] * 100).round(2)
final['f1-score'] = (final['f1-score'] * 100).round(2)


final.to_csv("median_trials_summary.csv", index=False)

# Preview
print(final.head())
