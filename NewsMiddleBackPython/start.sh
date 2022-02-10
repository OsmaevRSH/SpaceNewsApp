docker build -t news_server .
docker run -d --name news_server -p 80:80 news_server
