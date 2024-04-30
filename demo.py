from bs4 import BeautifulSoup
import requests

url = 'https://aqicn.org/forecast/kathmandu'

res = requests.get(url)
print(res.content)


soup = BeautifulSoup(res.text, "html.parser")
print(soup)