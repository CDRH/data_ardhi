# ET is used for reading the xml and pandas is used to create the dataframe for csv
from types import MethodType
from unicodedata import name
import xml.etree.ElementTree as ET
import pandas as pd
import os


def get_metadata(root: ET.Element) -> list:
    data = []
    file_name = list(root.attrib.values())
    data.append(file_name[0])

    # Use 'root.find' if there's only 1 value you want
    title = root.find('.//{*}title[@level="a"]').text

    data.append(title)

    '''
     method for multiple values:
     1. find overarching section 
     2.loop through
    '''
    place__section = root.find('.//{*}keywords[@n="places"]')
    places = []

    for curr_place in place__section:
        places.append(curr_place.text)

    #turn the list to a single string
    places_str = '; '.join(places)

    data.append(places_str)

    return data

def find_single_element(root:ET.Element,keyword:str) -> ET.Element:
    element = root.find(f'.//{{*}}{keyword}')
    return element

def find_multiple_elements(root:ET.Element,keyword:str) -> list:
    section_element = root.find(f'.//{{*}}{keyword}')
    children_nodes = []
    for curr_child in section_element:
        children_nodes.append(curr_child)
    return children_nodes


def get_filepaths(directory_path: str) -> list:

    files = os.listdir(directory_path)
    # .keep doesn't have data in it
    files.remove('.keep')

    file_paths = []
    for curr_file in files:
        curr_file_path = str(f'{directory_path}/{curr_file}')
        file_paths.append(curr_file_path)

    return file_paths


def main():
    path = 'source/tei'
    file_paths = get_filepaths(path)

    csv_rows = []
    for curr_file in file_paths:
        root = ET.parse(curr_file).getroot()
        meta_data = get_metadata(root)
        csv_rows.append(meta_data)

    cols = ['File', 'Title names', 'Places']
    df = pd.DataFrame(data=csv_rows, columns=cols)

    #good question is how missing data should be represented
    df.to_csv('output\csv\output.csv', index=False)


if __name__ == '__main__':
    main()
