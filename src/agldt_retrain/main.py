"""
Entry point
"""


import os
from agldt_retrain.normalizer import normalize_data
from agldt_retrain.uddata import download_data


def main():
    """
    Main function
    """
    if not os.path.exists("data/ud/"):
        download_data()

    # Normalization
    dev_data = "data/ud/grc_perseus-ud-dev.conllu"
    normalize_data(dev_data)
    test_data = "data/ud/grc_perseus-ud-test.conllu"
    normalize_data(test_data)
    train_data = "data/ud/grc_perseus-ud-train.conllu"
    normalize_data(train_data)


if __name__ == "__main__":
    main()
