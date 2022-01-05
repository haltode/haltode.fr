#!/usr/bin/env python3

""" Quick helper script to retrieve movies metadata using TMDB API.

You will need a .secrets.toml file with the following content:

    [tmdb]
    api_key = "FIXME"
    api_url = "https://api.themoviedb.org/3"

Then, provide a list of movies or playlists (one per line, each line containing
either a TMDB movie/playlist id or the name of the movie). For example:

    $ cat my_movies.txt
    movie 49797
    movie 22538
    search 'memento'
    search 'the general'
    playlist '1234'
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

import datetime
import json
import logging
import re
import sys
import urllib
from typing import Any, Dict, Iterator

import dateutil.parser
import requests
import toml
import yaml

JSONType = Dict[str, Any]

# Default (and sane) values for global TMDB configuration
TMDB_URL = "https://www.themoviedb.org"
TMDB_POSTER_BASE_URL = "https://image.tmdb.org/t/p/"
TMDB_POSTER_SIZE = "w154"


class TMDBMovie:
    title: str
    year: datetime.datetime
    poster_url: str
    tmdb_url: str

    def __init__(self, meta: JSONType) -> None:
        self.title = meta["title"]
        self.year = dateutil.parser.parse(meta["release_date"]).year
        self.poster_url = f"{TMDB_POSTER_BASE_URL}{TMDB_POSTER_SIZE}{meta['poster_path']}"
        self.tmdb_url = f"{TMDB_URL}/movie/{meta['id']}"

    def to_json(self) -> JSONType:
        return {
            "title": self.title,
            "year": self.year,
            "poster_url": self.poster_url,
            "tmdb_url": self.tmdb_url
        }

class TMDBService:
    api_key: str
    api_url: str
    session: requests.Session

    def __init__(self, config_path: str) -> None:
        config = toml.load(config_path)
        self.api_key = config["tmdb"]["api_key"]
        self.api_url = config["tmdb"]["api_url"]
        self.session = requests.Session()

        # Overwrite default configuration if not the most recent
        tmdb_config = self.request("/configuration")
        poster_base_url = tmdb_config["images"]["secure_base_url"]
        poster_size = tmdb_config["images"]["poster_sizes"][1]
        if poster_base_url != TMDB_POSTER_BASE_URL:
            logging.warning(f"overwriting poster_base_url (old: {TMDB_POSTER_BASE_URL}, new: {poster_base_url})")
        if poster_size != TMDB_POSTER_SIZE:
            logging.warning(f"overwriting poster_size (old: {TMDB_POSTER_SIZE}, new: {poster_size})")

    def request(self, endpoint: str, query: str=None) -> JSONType:
        if not endpoint.startswith("/"):
            raise ValueError("TMDB endpoint string must start with a '/'")
        url = f"{self.api_url}{endpoint}?api_key={self.api_key}"
        if query:
            url = f"{url}&{query}"

        try:
            r = self.session.get(url).json()
            if "success" in r and not r["success"]:
                raise ValueError(f"TMDB API call failed: {r} (url: {url})")
            return r
        except requests.HTTPError as err:
            logging.error(f"could not connect to TMDB: {err} (url: {url})")
            raise
        except json.JSONDecodeError as err:
            logging.error(f"could not parse JSON: {err} (url: {url})")
            raise

    def get_user_movies(self, query: str) -> Iterator[TMDBMovie]:
        if match := re.search(r"movie ([0-9]+)", query):
            movie_id = match.group(1)
            movie = self.request(f"/movie/{movie_id}")
            yield TMDBMovie(movie)
        elif match := re.search(r"playlist ([0-9]+)", query):
            playlist_id = match.group(1)
            playlist = self.request(f"/list/{playlist_id}")
            for item in playlist["items"]:
                yield TMDBMovie(item)
        elif match := re.search(r"search '(.*)'", query):
            movie_title = match.group(1)
            escaped_query = f"query={urllib.parse.quote(movie_title)}"
            search = self.request("/search/movie", escaped_query)
            if search["results"]:
                yield TMDBMovie(search["results"][0])
            else:
                raise ValueError(f"cannot find search result for {query}")
        else:
            raise ValueError(f"cannot parse input query: {query}")


tmdb_service = TMDBService(".secrets.toml")
for query in sys.stdin:
    # Remove unwanted '\n' introduced by sys.stdin
    query = query.rstrip()
    try:
        movies = [m.to_json() for m in tmdb_service.get_user_movies(query)]
        print(yaml.dump(movies, sort_keys=False))
    except Exception as err:
        logging.error(f"error while processing {query}: err={err}\n")
