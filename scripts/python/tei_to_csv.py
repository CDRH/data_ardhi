#ET is used for reading the xml and pandas is used to create the dataframe for csv
#Using lxml over the normal elementree because it claims to be faster and allows for xpathing
#Note: ensure you're using the right form of python
import xml.etree.ElementTree as ET
import pandas as pd

#right now looking at 1 file

#need to get each file in the folder eventually 


file_path = 'source/tei/ardhi.treaty.00001.xml'


xmlparse = ET.parse(file_path)
root = xmlparse.getroot()
print(root.tag, root.attrib)

namespace = {'d' : 'http://www.tei-c.org/ns/1.0'}
titles = root.findall(path="d:title", namespaces=namespace)


if len(titles) > 0:
    print("We got some!")
else:
    print("couldn't find anything")

for title in titles:
    print(title.tag, title.attrib)

'''
for child in root.find('title'):

    print(child.tag, child.attrib)
'''




