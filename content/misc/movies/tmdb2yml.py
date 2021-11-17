#!/usr/bin/env python3

""" Quick helper script to retrieve movies metadata using TMDB API.

You will need a .secrets.toml file with the following content:

    [tmdb]
    api_key = "FIXME"
    api_url = "https://api.themoviedb.org/3"

Then, provide a list of movies (one per line, each line containing either a TMDB
id or the name of the movie). For example:

    $ cat my_movies.txt
    49797
    22538
    memento
    the general
    $ cat my_movies.txt | ./tmdb2yml.py
    - title: I Saw the Devil
      year: 2010
      poster_url: https://image.tmdb.org/t/p/w154/zp5NrmYp80axIGiEiYPmm1CW6uH.jpg
      tmdb_url: https://www.themoviedb.org/movie/49797
    - title: Scott Pilgrim vs. the World
      year: 2010
      poster_url: https://image.tmdb.org/t/p/w154/g5IoYeudx9XBEfwNL0fHvSckLBz.jpg
      tmdb_url: https://www.themoviedb.org/movie/22538
    - title: Memento
      year: 2000
      poster_url: https://image.tmdb.org/t/p/w154/yuNs09hvpHVU1cBTCAk9zxsL2oW.jpg
      tmdb_url: https://www.themoviedb.org/movie/77
    - title: The General
      year: 1926
      poster_url: https://image.tmdb.org/t/p/w154/dd2cviAare1rUoMiDmG2NuvFQEE.jpg
      tmdb_url: https://www.themoviedb.org/movie/961

Note: using the name of the movie as input means defaulting to the first search
result of TMDB website.

"""

import json
import logging
import re
import sys
import urllib
from typing import Any, Dict

import dateutil.parser
import requests
import toml
import yaml

JSONType = Dict[str, Any]


class TMDBService:
    api_key: str
    api_url: str
    session: requests.Session
    config: JSONType

    def __init__(self, config_path: str) -> None:
        config = toml.load(config_path)
        self.api_key = config["tmdb"]["api_key"]
        self.api_url = config["tmdb"]["api_url"]
        self.session = requests.Session()
        self.config = self.request("/configuration")

    def request(self, endpoint: str, query: str=None) -> JSONType:
        if not endpoint.startswith("/"):
            raise ValueError("TMDB endpoint string must start with a '/'")
        url = f"{self.api_url}{endpoint}?api_key={self.api_key}"
        if query:
            url = f"{url}&{query}"

        try:
            r = self.session.get(url)
            return r.json()
        except requests.HTTPError as err:
            logging.error(f"could not connect to TMDB: {err} (url: {url})")
            raise
        except json.JSONDecodeError as err:
            logging.error(f"could not parse JSON: {err} (url: {url})")
            raise

    def get_poster_url(self, poster_path: str) -> str:
        base_url = self.config["images"]["secure_base_url"]
        poster_size = self.config["images"]["poster_sizes"][1]
        return f"{base_url}{poster_size}{poster_path}"


tmdb_service = TMDBService(".secrets.toml")
metadatas = []
for query in sys.stdin:
    # Remove unwanted '\n' introduced by sys.stdin
    query = query.rstrip()
    if re.match(r"[0-9]+", query):
        tmdb_id = query
    else:
        escaped_query = f"query={urllib.parse.quote(query)}"
        search = tmdb_service.request(f"/search/movie", escaped_query)
        if search["results"]:
            tmdb_id = search["results"][0]["id"]
        else:
            tmdb_id = None

    try:
        movie = tmdb_service.request(f"/movie/{tmdb_id}")
        metadatas.append(
            {
                "title": movie["title"],
                "year": dateutil.parser.parse(movie["release_date"]).year,
                "poster_url": tmdb_service.get_poster_url(movie["poster_path"]),
                "tmdb_url": f"https://www.themoviedb.org/movie/{tmdb_id}",
            }
        )
    except Exception as err:
        logging.error(f"error while processing {query}: err={err}, metadata={movie}")
print(yaml.dump(metadatas, sort_keys=False))
