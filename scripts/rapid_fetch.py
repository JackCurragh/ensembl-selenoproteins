'''
Fetch assembly FASTA file from ensembl Rapid release

Usage:
    rapid_fetch.py -s <species> -a <assembly GCA> -o <output>

Options:
    -s <species>        Species name
    -a <assembly GCA>   Assembly GCA
    -o <output>         Output file

Example:
    rapid_fetch.py -s 'Homo sapiens' -a GCA_000001405.15 -o GCA_000001405.15.fasta

'''

import argparse
import os
import requests
from bs4 import BeautifulSoup
from datetime import datetime, timedelta

def lint_args(args: argparse.Namespace) -> argparse.Namespace:
    '''
    Lint arguments from argparse
    
    Parameters
    ----------
    args : argparse.Namespace
        Arguments from argparse
    
    Returns
    -------
    args : argparse.Namespace
        Arguments from argparse that have been linted
    '''
    if args.species[0].islower():
        args.species = args.species.capitalize()
    
    if " " in args.species:
        args.species = args.species.replace(" ", "_")

    args.assembly = args.assembly.upper()
    
    return args


def check_url_validity(url: str) -> bool:
    '''
    Assess whether an ensemble URL is valid

    Parameters
    ----------
    url : str
        URL to check

    Returns
    -------
    bool
        Whether the URL is valid
    '''
    r = requests.get(url)
    if r.status_code == 200:
        return True
    else:
        return False


def get_latest_release_date(species: str, assembly: str, annotation_types=['ensembl', 'refseq', 'braker', 'community', 'genbank', 'flybase', 'wormbase', 'noninsdc']) -> str:

    for annotation in annotation_types:
        base_url = f"https://ftp.ensembl.org/pub/rapid-release/species/{species}/{assembly}/{annotation}/geneset/"

        # Try to fetch the release dates
        response = requests.get(base_url)

        if response.status_code == 200:
            soup = BeautifulSoup(response.text, 'html.parser')
            links = soup.find_all('a', href=True)
            release_dates = [link['href'] for link in links if link['href'].count('/') == 1]
            return max(release_dates) if release_dates else None
        elif response.status_code == 404:
            print(f"Directory not found. Trying to find the latest release date by progressively going back in time.")

            # Attempt to find the latest release date by going back in time
            current_date = datetime.utcnow().strftime("%Y_%m")
            end_date = "2010_01"  # You can adjust the end date based on your preferences

            while current_date >= end_date:
                if check_url_validity(f"{base_url}/{current_date}"):
                    print(f"Latest release date found: {current_date}")
                    return current_date

                current_date = (datetime.strptime(current_date, "%Y_%m") - timedelta(days=30)).strftime("%Y_%m")

        print("Error: Could not determine the latest release date.")
        print(base_url)
        return None
    else:
        print(f"Error fetching release dates: {response.status_code}")
        return None


def build_url(file_type: str, species: str, assembly: str, release: str, annotation_types=['ensembl', 'refseq', 'braker', 'community', 'genbank', 'flybase', 'wormbase', 'noninsdc']) -> str:
    if file_type == 'fasta':
        for annotation_type in annotation_types:
            url = f"https://ftp.ensembl.org/pub/rapid-release/species/{species}/{assembly}/{annotation_type}/genome/{species}-{assembly}-softmasked.fa.gz"
            if check_url_validity(url):
                return url
        else:
            raise ValueError(f"Could not find assembly {assembly} for species {species} in Ensembl Rapid release.")
    elif file_type == 'gtf':
        for annotation_type in annotation_types:
            url = f"https://ftp.ensembl.org/pub/rapid-release/species/{species}/{assembly}/{annotation_type}/geneset/{release}/{species}-{assembly}-{release.strip('/')}-genes.gtf.gz"
            if check_url_validity(url):
                return url
        else:
            raise ValueError(f"Could not find GTF file for assembly {assembly} and species {species} in Ensembl Rapid release.")
    else:
        raise ValueError(f"Invalid file type: {file_type}")


def fetch_file(file_type: str, url: str, output: str):
    try:
        response = requests.get(url)
        response.raise_for_status()  # Raise an exception for bad responses (4xx and 5xx)
        file_content = response.content

        with open(output, "wb") as f:
            f.write(file_content)

    except requests.RequestException as e:
        print(f"Error fetching {file_type.upper()} file: {e}")


def main(args: argparse.Namespace):
    args = lint_args(args)
    
    # Attempt to get the latest release date
    release_date = get_latest_release_date(args.species, args.assembly)
    if release_date:
        url = build_url(args.file_type, args.species, args.assembly, release_date)
        output = os.path.join(args.output, f"{args.assembly}_{release_date.strip('/')}.{args.file_type}.gz")
        fetch_file(args.file_type, url, output)
    else:
        print("Error: Could not determine the latest release date.")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Download Ensembl Rapid Release files.")
    parser.add_argument(
        "-s",
        "--species",
        type=str,
        help="Species name (preferably of the form 'Homo sapiens')",
        required=True,
    )
    parser.add_argument(
        "-a",
        "--assembly",
        type=str,
        help="Assembly GCA (preferably of the form 'GCA_000001405.15')",
        required=True,
    )
    parser.add_argument(
        "-o",
        "--output",
        type=str,
        help="Output directory",
        default=".",
    )
    parser.add_argument(
        "--file-type",
        choices=['fasta', 'gtf'],
        help="Type of file to download (fasta or gtf)",
        required=True,
    )
    args = parser.parse_args()
    main(args)