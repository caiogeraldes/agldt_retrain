"""
Normalization to NFC
"""

from unicodedata import normalize


def normalize_data(data: str):
    """
    TODO
    """
    with open(data, encoding="utf8") as file:
        text = file.read()

    text = normalize("NFKC", text)
    with open(data,
              "w", encoding="utf8") as file:
        file.write(text)
