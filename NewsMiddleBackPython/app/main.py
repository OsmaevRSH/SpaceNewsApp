from fastapi import FastAPI
from newspaper import Article

app = FastAPI()


@app.get("/description")
async def description(url: str):
    return get_description(url)


def get_description(url):
    article = Article(url)
    article.download()
    article.parse()
    return article.text
