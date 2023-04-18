"""
TODO
"""

from git import Repo


def download_data(data: str):
    """
    TODO
    """
    Repo.clone_from(
        f"git@github.com:UniversalDependencies/{data}.git",
        "./data/ud/",
        verbose=True
    )
