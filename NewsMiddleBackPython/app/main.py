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
