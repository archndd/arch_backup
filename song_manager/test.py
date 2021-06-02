import requests
import json

response = requests.get("https://api.spotify.com/v1/search?q=when%20you%20sleep-my%20bloody%20valentine&type=track&limit=1",
        headers={'Accept': 'application/json', 'Content-Type': 'application/json', 'Authorization': 'Bearer BQCY4YkC5lZizYC4wUYTkkA9EkZDUrR31FOJGqu8kljKEQWyGIXEKFlS7r8rF_gbbtXiDA8n1jfPVAs1VGzRGdwD7QsMZNG1-JKaBQiV71_pAARhFiFAD8P_F4a2oYTW2oT_SVjKmgORRSmQsGZ9Dk5hlRSz8zY'})

if (response.status_code == 200):
    print(response.text)
    data = json.loads(response.text)
    print(data["tracks"]["items"][0]["name"])
    print(data["tracks"]["items"][0]["album"]["release_date"])
else:
    print("Error: {}".format(response.status_code))
