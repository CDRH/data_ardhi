# ET is used for reading the xml and pandas is used to create the dataframe for csv
from types import MethodType
from unicodedata import name
import xml.etree.ElementTree as ET
import pandas as pd
import os


def get_metadata(root: ET.Element) -> list:
    '''
    Given the root, gets all the metadata you want and returns it in a list
    '''
    data = []
    file_name = list(root.attrib.values())
    data.append(file_name[0])

    # Use root.find if there's only 1 value you want
    title = root.find('.//{*}title[@level="a"]').text

    data.append(title)

    '''
     method for multiple values:
     1. find overarching section 
     2.loop through
    '''
    place__section = root.find('.//{*}keywords[@n="places"]')
    places = []

    # loop through the children in the section
    for curr_place in place__section:
        places.append(curr_place.text)

    places_str = '; '.join(places)

    data.append(places_str)

    return data


def get_filepaths(dir_path: str) -> list:
    '''
    Given the directory's path, returns all the filepaths including the directory
    '''
    files = os.listdir(dir_path)
    # .keep doesn't have data in it
    files.remove('.keep')

    file_paths = []
    for curr_file in files:
        curr_file_path = str(f'{dir_path}/{curr_file}')
        file_paths.append(curr_file_path)

    return file_paths


def main():
    path = 'source/tei'
    file_paths = get_filepaths(path)

    file_rows = []
    for curr_file in file_paths:
        xmlParse = ET.parse(curr_file)
        root = xmlParse.getroot()
        meta_data = get_metadata(root)
        file_rows.append(meta_data)

    # Create the dataframe and write to csv
    cols = ['File', 'Title names', 'Places']
    df = pd.DataFrame(file_rows, columns=cols)
    df.to_csv('output\csv\output.csv', index=False)


if __name__ == '__main__':
    main()
