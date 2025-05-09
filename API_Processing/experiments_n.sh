#!/bin/bash




run_model1() {
    python3 -m decalfc.pipeline.modeling --kwargs \
        strategy="$1" \
        trials=1 \
        model-arch="BLSTM" \
        hyperparams='{"learning_rate": 0.001, "scheduler": "plateau", "num_epochs": 1, "hidden_size": 64, "num_layers": 2, "dropout_rate": 0.5}' 
}

run_model2() {
    python3 -m decalfc.pipeline.modeling --kwargs \
        strategy="$1" \
        trials=1 \
        model-arch="Transformer" \
        hyperparams='{"learning_rate": 0.001, "scheduler": "plateau", "num_epochs": 1, "hidden_size": 64, "num_layers": 2, "dropout_rate": 0.5}' 
}

run_model3() {
    python3 -m decalfc.pipeline.modeling --kwargs \
        strategy="$1" \
        trials=1 \
        model-arch="DLSTM" \
        hyperparams='{"learning_rate": 0.001, "scheduler": "plateau", "num_epochs": 1, "hidden_size": 64, "num_layers": 2, "dropout_rate": 0.5}' 
}

strategies=(
    "A-1-1cn^ --> A-1-1cn^^"
    "A-1-1cn --> E-2-2cn"
    "A-1-1cn --> O-2-2cn"
    "A-1-1cn --> G-3-4cn"
    "E-2-2cn --> A-1-1cn"
    "E-2-2cn^ --> E-2-2cn^^"
    "E-2-2cn --> O-2-2cn"
    "E-2-2cn --> G-3-4cn"
    "O-2-2cn --> A-1-1cn"
    "O-2-2cn --> E-2-2cn"
    "O-2-2cn^ --> O-2-2cn^^"
    "O-2-2cn --> G-3-4cn"
    "A-1-1cn^ + O-2-2cn --> A-1-1cn^^"
    "A-1-1cn^ + O-2-2cn --> E-2-2cn"
    "A-1-1cn^ + O-2-2cn^ --> O-2-2cn^^"
    "A-1-1cn + O-2-2cn --> G-3-4cn"
    "E-2-2cn + O-2-2cn --> A-1-1cn"
    "E-2-2cn^ + O-2-2cn --> E-2-2cn^^"
    "E-2-2cn + O-2-2cn^ --> O-2-2cn^^"
    "E-2-2cn + O-2-2cn --> G-3-4cn"
    "A-1-1cn^ + E-2-2cn --> A-1-1cn^^"
    "A-1-1cn + E-2-2cn^ --> E-2-2cn^^"
    "A-1-1cn + E-2-2cn --> O-2-2cn"
    "A-1-1cn + E-2-2cn --> G-3-4cn"
    "A-1-1cn^ + E-2-2cn + O-2-2cn --> A-1-1cn^^"
    "A-1-1cn + E-2-2cn^ + O-2-2cn --> E-2-2cn^^"
    "A-1-1cn + E-2-2cn + O-2-2cn^ --> O-2-2cn^^"
    "A-1-1cn + E-2-2cn + O-2-2cn --> G-3-4cn"
    "A-1-1cn^ + E-2-2cn^ + O-2-2cn^ --> A-1-1cn^^ + E-2-2cn^^ + O-2-2cn^^"
)

# Run each strategy 15 times
for strategy in "${strategies[@]}"; do
    for i in {1..15}; do
        run_model1 "$strategy"
    done
    wait  # Ensure all 15 runs of this strategy finish before moving to the next
done


# Run each strategy 15 times
for strategy in "${strategies[@]}"; do
    for i in {1..15}; do
        run_model2 "$strategy"
    done
    wait  # Ensure all 15 runs of this strategy finish before moving to the next
done



# Run each strategy 15 times
for strategy in "${strategies[@]}"; do
    for i in {1..15}; do
        run_model3 "$strategy"
    done
    wait  # Ensure all 15 runs of this strategy finish before moving to the next
done



# run_model() {
#     python3 -m decalfc.pipeline.modeling --kwargs \
#         strategy="$1" \
#         trials=1 \
#         model-arch="BLSTM" \
#         hyperparams='{"learning_rate": 0.001, "scheduler": "plateau", "num_epochs": 100, "hidden_size": 64, "num_layers": 2, "dropout_rate": 0.5}' &
# }
# for i in {1..15}; do
#     run_model "A-1-1n^ --> A-1-1n^^"
#     run_model "A-1-1n --> E-2-2n"
#     run_model "A-1-1n --> O-2-2n"
#     run_model "A-1-1n --> G-3-4n"

#     run_model "E-2-2n --> A-1-1n"
#     run_model "E-2-2n^ --> E-2-2n^^"
#     run_model "E-2-2n --> O-2-2n"
#     run_model "E-2-2n --> G-3-4n"

#     run_model "O-2-2n --> A-1-1n"
#     run_model "O-2-2n --> E-2-2n"
#     run_model "O-2-2n^ --> O-2-2n^^"
#     run_model "O-2-2n --> G-3-4n"

#     run_model "A-1-1n^ + O-2-2n --> A-1-1n^^"
#     run_model "A-1-1n^ + O-2-2n --> E-2-2n"
#     run_model "A-1-1n^ + O-2-2n^ --> O-2-2n^^"
#     run_model "A-1-1n + O-2-2n --> G-3-4n"

#     run_model "E-2-2n + O-2-2n --> A-1-1n"
#     run_model "E-2-2n^ + O-2-2n --> E-2-2n^^"
#     run_model "E-2-2n + O-2-2n^ --> O-2-2n^^"
#     run_model "E-2-2n + O-2-2n --> G-3-4n"

#     run_model "A-1-1n^ + E-2-2n --> A-1-1n^^"
#     run_model "A-1-1n + E-2-2n^ --> E-2-2n^^"
#     run_model "A-1-1n + E-2-2n --> O-2-2n"
#     run_model "A-1-1n + E-2-2n --> G-3-4n"

#     run_model "A-1-1n^ + E-2-2n + O-2-2n --> A-1-1n^^"
#     run_model "A-1-1n + E-2-2n^ + O-2-2n --> E-2-2n^^"
#     run_model "A-1-1n + E-2-2n + O-2-2n^ --> O-2-2n^^"
#     run_model "A-1-1n + E-2-2n + O-2-2n --> G-3-4n"
#     run_model "A-1-1n^ + E-2-2n^ + O-2-2n^ --> A-1-1n^^ + E-2-2n^^ + O-2-2n^^"
# done

# wait  






# run_model "G-3-4n --> A-1-1n"
# run_model "G-3-4n --> E-2-2n"
# run_model "G-3-4n --> O-2-2n"
# run_model "G-3-4n^ --> G-3-4n^^"



# pythO-2-2n3 -m decalfc.pipeline.modeling --kwargs \
#     strategy="A-1-1n^ --> A-1-1n^^" \
#     trials=1 \
#     model-arch="BLSTM" \
#     hyperparams='{"learning_rate": 0.001, "scheduler": "plateau", "num_epochs": 100, "hiddE-2-2n_size": 64, "num_layers": 2, "dropout_rate": 0.5}'

# pythO-2-2n3 -m decalfc.pipeline.modeling --kwargs \
#     strategy="A-1-1n --> E-2-2n" \
#     trials=1 \
#     model-arch="BLSTM" \
#     hyperparams='{"learning_rate": 0.001, "scheduler": "plateau", "num_epochs": 100, "hiddE-2-2n_size": 64, "num_layers": 2, "dropout_rate": 0.5}'

# pythO-2-2n3 -m decalfc.pipeline.modeling --kwargs \
#     strategy="A-1-1n --> O-2-2n" \
#     trials=1 \
#     model-arch="BLSTM" \
#     hyperparams='{"learning_rate": 0.001, "scheduler": "plateau", "num_epochs": 100, "hiddE-2-2n_size": 64, "num_layers": 2, "dropout_rate": 0.5}'


# pythO-2-2n3 -m decalfc.pipeline.modeling --kwargs \
#     strategy="A-1-1n --> G-3-4n" \
#     trials=1 \
#     model-arch="BLSTM" \
#     hyperparams='{"learning_rate": 0.001, "scheduler": "plateau", "num_epochs": 100, "hiddE-2-2n_size": 64, "num_layers": 2, "dropout_rate": 0.5}'





# pythO-2-2n3 -m decalfc.pipeline.modeling --kwargs \
#     strategy="E-2-2n --> A-1-1n" \
#     trials=1 \
#     model-arch="BLSTM" \
#     hyperparams='{"learning_rate": 0.001, "scheduler": "plateau", "num_epochs": 100, "hiddE-2-2n_size": 64, "num_layers": 2, "dropout_rate": 0.5}'

# pythO-2-2n3 -m decalfc.pipeline.modeling --kwargs \
#     strategy="E-2-2n^ --> E-2-2n^^" \
#     trials=1 \
#     model-arch="BLSTM" \
#     hyperparams='{"learning_rate": 0.001, "scheduler": "plateau", "num_epochs": 100, "hiddE-2-2n_size": 64, "num_layers": 2, "dropout_rate": 0.5}'

# pythO-2-2n3 -m decalfc.pipeline.modeling --kwargs \
#     strategy="E-2-2n --> O-2-2n" \
#     trials=1 \
#     model-arch="BLSTM" \
#     hyperparams='{"learning_rate": 0.001, "scheduler": "plateau", "num_epochs": 100, "hiddE-2-2n_size": 64, "num_layers": 2, "dropout_rate": 0.5}'

# pythO-2-2n3 -m decalfc.pipeline.modeling --kwargs \
#     strategy="E-2-2n --> G-3-4n" \
#     trials=1 \
#     model-arch="BLSTM" \
#     hyperparams='{"learning_rate": 0.001, "scheduler": "plateau", "num_epochs": 100, "hiddE-2-2n_size": 64, "num_layers": 2, "dropout_rate": 0.5}'







# pythO-2-2n3 -m decalfc.pipeline.modeling --kwargs \
#     strategy="G-3-4n --> A-1-1n" \
#     trials=1 \
#     model-arch="BLSTM" \
#     hyperparams='{"learning_rate": 0.001, "scheduler": "plateau", "num_epochs": 100, "hiddE-2-2n_size": 64, "num_layers": 2, "dropout_rate": 0.5}'

# pythO-2-2n3 -m decalfc.pipeline.modeling --kwargs \
#     strategy="G-3-4n --> E-2-2n" \
#     trials=1 \
#     model-arch="BLSTM" \
#     hyperparams='{"learning_rate": 0.001, "scheduler": "plateau", "num_epochs": 100, "hiddE-2-2n_size": 64, "num_layers": 2, "dropout_rate": 0.5}'

# pythO-2-2n3 -m decalfc.pipeline.modeling --kwargs \
#     strategy="G-3-4n --> O-2-2n" \
#     trials=1 \
#     model-arch="BLSTM" \
#     hyperparams='{"learning_rate": 0.001, "scheduler": "plateau", "num_epochs": 100, "hiddE-2-2n_size": 64, "num_layers": 2, "dropout_rate": 0.5}'

# pythO-2-2n3 -m decalfc.pipeline.modeling --kwargs \
#     strategy="G-3-4n^ --> G-3-4n^^" \
#     trials=1 \
#     model-arch="BLSTM" \
#     hyperparams='{"learning_rate": 0.001, "scheduler": "plateau", "num_epochs": 100, "hiddE-2-2n_size": 64, "num_layers": 2, "dropout_rate": 0.5}'






# pythO-2-2n3 -m decalfc.pipeline.modeling --kwargs \
#     strategy="O --> A-1-1n" \
#     trials=1 \
#     model-arch="BLSTM" \
#     hyperparams='{"learning_rate": 0.001, "scheduler": "plateau", "num_epochs": 100, "hiddE-2-2n_size": 64, "num_layers": 2, "dropout_rate": 0.5}'

# pythO-2-2n3 -m decalfc.pipeline.modeling --kwargs \
#     strategy="O --> E-2-2n" \
#     trials=1 \
#     model-arch="BLSTM" \
#     hyperparams='{"learning_rate": 0.001, "scheduler": "plateau", "num_epochs": 100, "hiddE-2-2n_size": 64, "num_layers": 2, "dropout_rate": 0.5}'

# pythO-2-2n3 -m decalfc.pipeline.modeling --kwargs \
#     strategy="O^ --> O-2-2n^^" \
#     trials=1 \
#     model-arch="BLSTM" \
#     hyperparams='{"learning_rate": 0.001, "scheduler": "plateau", "num_epochs": 100, "hiddE-2-2n_size": 64, "num_layers": 2, "dropout_rate": 0.5}'

# pythO-2-2n3 -m decalfc.pipeline.modeling --kwargs \
#     strategy="O --> G-3-4n" \
#     trials=1 \
#     model-arch="BLSTM" \
#     hyperparams='{"learning_rate": 0.001, "scheduler": "plateau", "num_epochs": 100, "hiddE-2-2n_size": 64, "num_layers": 2, "dropout_rate": 0.5}'






# pythO-2-2n3 -m decalfc.pipeline.modeling --kwargs \
#     strategy="A-1-1n^ + E-2-2n + O --> A-1-1n^^" \
#     trials=1 \
#     model-arch="BLSTM" \
#     hyperparams='{"learning_rate": 0.001, "scheduler": "plateau", "num_epochs": 100, "hiddE-2-2n_size": 64, "num_layers": 2, "dropout_rate": 0.5}'

# pythO-2-2n3 -m decalfc.pipeline.modeling --kwargs \
#     strategy="A-1-1n + E-2-2n^ + O --> E-2-2n^^" \
#     trials=1 \
#     model-arch="BLSTM" \
#     hyperparams='{"learning_rate": 0.001, "scheduler": "plateau", "num_epochs": 100, "hiddE-2-2n_size": 64, "num_layers": 2, "dropout_rate": 0.5}'

# pythO-2-2n3 -m decalfc.pipeline.modeling --kwargs \
#     strategy="A-1-1n + E-2-2n + O^ --> O-2-2n^^" \
#     trials=1 \
#     model-arch="BLSTM" \
#     hyperparams='{"learning_rate": 0.001, "scheduler": "plateau", "num_epochs": 100, "hiddE-2-2n_size": 64, "num_layers": 2, "dropout_rate": 0.5}'

# pythO-2-2n3 -m decalfc.pipeline.modeling --kwargs \
#     strategy="A-1-1n + E-2-2n + O --> G-3-4n" \
#     trials=1 \
#     model-arch="BLSTM" \
#     hyperparams='{"learning_rate": 0.001, "scheduler": "plateau", "num_epochs": 100, "hiddE-2-2n_size": 64, "num_layers": 2, "dropout_rate": 0.5}'

# pythO-2-2n3 -m decalfc.pipeline.modeling --kwargs \
#     strategy="A-1-1n^ + E-2-2n^ + O^ --> A-1-1n^^ + E-2-2n^^ + O^^" \
#     trials=1 \
#     model-arch="BLSTM" \
#     hyperparams='{"learning_rate": 0.001, "scheduler": "plateau", "num_epochs": 100, "hiddE-2-2n_size": 64, "num_layers": 2, "dropout_rate": 0.5}'