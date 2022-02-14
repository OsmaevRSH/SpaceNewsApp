import json

import requests
from fastapi import FastAPI
from newspaper import Article

app = FastAPI()


@app.get("/description")
async def description(url: str, news_id: int):
    news_description = get_description(url)
    if len(news_description) == 0:
        req = requests.get(f'https://api.spaceflightnewsapi.net/v3/articles/{news_id}/')
        json_resp = req.json()
        return json_resp['summary']
    else:
        return news_description


def get_description(url):
    article = Article(url)
    article.download()
    article.parse()
    return article.text


@app.get("/testApi")
async def testApi(latitude: str, longitude: str, radius: str, min_population: str, max_population: str):
    value = {
                "links": {
                    "first": "/cities/nearby?radius=25&latitude=55.12&longitude=37.02&min_population=100&max_population=10000&language=en&page=1&per_page=20",
                    "last": "/cities/nearby?radius=25&latitude=55.12&longitude=37.02&min_population=100&max_population=10000&language=en&page=1&per_page=20",
                    "next": "",
                    "previous": ""
                },
                "page": 1,
                "per_page": 20,
                "total_pages": 1,
                "total_cities": 10,
                "cities": [
                    {
                        "geonameid": 577856,
                        "population": 8421,
                        "name": "Belousovo",
                        "latitude": 55.09499,
                        "longitude": 36.6732,
                        "country": {
                            "code": "RU"
                        },
                        "division": {
                            "code": "RU-KLU",
                            "geonameid": 553899
                        },
                        "distance": "22.26 km"
                    },
                    {
                        "geonameid": 571131,
                        "population": 310,
                        "name": "Bukholovka",
                        "latitude": 55.18919,
                        "longitude": 36.9099,
                        "country": {
                            "code": "RU"
                        },
                        "division": {
                            "code": "RU-KLU",
                            "geonameid": 553899
                        },
                        "distance": "10.41 km"
                    },
                    {
                        "geonameid": 567835,
                        "population": 130,
                        "name": "Chubarovo",
                        "latitude": 55.1993,
                        "longitude": 36.9223,
                        "country": {
                            "code": "RU"
                        },
                        "division": {
                            "code": "RU-KLU",
                            "geonameid": 553899
                        },
                        "distance": "10.80 km"
                    },
                    {
                        "geonameid": 553686,
                        "population": 151,
                        "name": "Kamenka",
                        "latitude": 55.22077,
                        "longitude": 36.99473,
                        "country": {
                            "code": "RU"
                        },
                        "division": {
                            "code": "RU-MOS",
                            "geonameid": 524925
                        },
                        "distance": "11.33 km"
                    },
                    {
                        "geonameid": 11152665,
                        "population": 5238,
                        "name": "LMS",
                        "latitude": 55.31425,
                        "longitude": 37.18546,
                        "country": {
                            "code": "RU"
                        },
                        "division": {
                            "code": "RU-MOW",
                            "geonameid": 524894
                        },
                        "distance": "24.04 km"
                    },
                    {
                        "geonameid": 6730265,
                        "population": 5264,
                        "name": "Obolensk",
                        "latitude": 54.97741,
                        "longitude": 37.22449,
                        "country": {
                            "code": "RU"
                        },
                        "division": {
                            "code": "RU-MOS",
                            "geonameid": 524925
                        },
                        "distance": "20.54 km"
                    },
                    {
                        "geonameid": 512855,
                        "population": 159,
                        "name": "Panino",
                        "latitude": 55.20764,
                        "longitude": 36.94085,
                        "country": {
                            "code": "RU"
                        },
                        "division": {
                            "code": "RU-KLU",
                            "geonameid": 553899
                        },
                        "distance": "10.98 km"
                    },
                    {
                        "geonameid": 502514,
                        "population": 876,
                        "name": "Raisemenovskoe",
                        "latitude": 55.00786,
                        "longitude": 37.33515,
                        "country": {
                            "code": "RU"
                        },
                        "division": {
                            "code": "RU-MOS",
                            "geonameid": 524925
                        },
                        "distance": "23.65 km"
                    },
                    {
                        "geonameid": 472141,
                        "population": 240,
                        "name": "Vorob'i",
                        "latitude": 55.14559,
                        "longitude": 36.80463,
                        "country": {
                            "code": "RU"
                        },
                        "division": {
                            "code": "RU-KLU",
                            "geonameid": 553899
                        },
                        "distance": "14.00 km"
                    },
                    {
                        "geonameid": 470195,
                        "population": 1931,
                        "name": "Vysokinichi",
                        "latitude": 54.90928,
                        "longitude": 36.93148,
                        "country": {
                            "code": "RU"
                        },
                        "division": {
                            "code": "RU-KLU",
                            "geonameid": 553899
                        },
                        "distance": "24.13 km"
                    }
                ],
                "radius": 25,
                "location": {
                    "latitude": 55.12,
                    "longitude": 37.02
                },
                "status": "success"
            }
    return value
