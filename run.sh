#!/bin/bash

DATA=UD_Ancient_Greek-Perseus
CW=$PWD

export PYTHONPATH="$HOME/.miniconda3/bin/"
export STANZA_RESOURCES_DIR="$HOME/proj/data/stanza_resources"
export TOKENIZE_DATA_DIR="$HOME/proj/data/tokenize"
export UDBASE="$HOME/proj/data/ud/"

if [ -d "$TOKENIZE_DATA_DIR" ]; then
    echo "using TOKENIZE_DATA_DIR = $TOKENIZE_DATA_DIR"
else
    echo "creating $TOKENIZE_DATA_DIR"
    mkdir -p "$TOKENIZE_DATA_DIR"
fi

if [ -d "$UDBASE" ]; then
    echo "using UDBASE = $UDBASE"
else
    echo "creating $UDBASE"
    mkdir -p "$UDBASE"
fi

if ! [ -d "$UDBASE/$DATA" ]; then
    cd "$UDBASE" || return 1
    git clone git@github.com:UniversalDependencies/"$DATA".git
    cd "$CW" || return 1
fi

# TOKENIZER
python3 -m stanza.utils.datasets.prepare_tokenizer_treebank "$DATA"
python3 -m stanza.utils.training.run_tokenizer "$DATA"
python3 -m stanza.utils.training.run_tokenizer "$DATA" --score_dev
python3 -m stanza.utils.training.run_tokenizer "$DATA" --score_test

# lemma
python3 -m stanza.utils.datasets.prepare_lemma_treebank "$DATA"
python3 -m stanza.utils.training.run_lemma "$DATA"
python3 -m stanza.utils.training.run_lemma "$DATA" --score_dev
python3 -m stanza.utils.training.run_lemma "$DATA" --score_test

# pos
python3 -m stanza.utils.datasets.prepare_pos_treebank "$DATA"
python3 -m stanza.utils.training.run_pos "$DATA"
python3 -m stanza.utils.training.run_pos "$DATA" --score_dev
python3 -m stanza.utils.training.run_pos "$DATA" --score_test

# depparse
python3 -m stanza.utils.datasets.prepare_depparse_treebank "$DATA"
python3 -m stanza.utils.training.run_depparse "$DATA"
python3 -m stanza.utils.training.run_depparse "$DATA" --score_dev
python3 -m stanza.utils.training.run_depparse "$DATA" --score_test
