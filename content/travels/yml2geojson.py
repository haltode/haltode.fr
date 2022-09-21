#!/usr/bin/env python3

""" Helper script to convert a list of places to GeoJSON points compatible with
uMap import interface.

You will need a .secrets.toml file with the following content:

    [nominatim]
    user_agent = "FIXME"

See https://operations.osmfoundation.org/policies/nominatim/

Then, provide a list of places as a yml file. For example:

    $ cat my_travel.yml
    - name: this is the visible label
      description: this is the description
      search:
        query: Paris, France
        featuretype: city
    $ ./yml2geojson.py my_travel.yml
    {
      "type": "FeatureCollection",
      "features": [
        {
          "type": "Feature",
          "properties": {
            "_umap_options": {
              "iconClass": "Default",
              "showLabel": null
            },
            "name": "this is the visible label",
            "description": "this is the description"
          },
          "geometry": {
            "type": "Point",
            "coordinates": [
              2.3200410217200766,
              48.8588897
            ]
          }
        }
      ]
    }

You can find the full list of the search query parameters here:
https://geopy.readthedocs.io/en/stable/#geopy.geocoders.Nominatim.geocode

Note: make sure to double check in uMap the result, mainly the coordinates found
using the search query.

"""

import json
import logging
import sys
import toml
import yaml
from time import sleep
from typing import Any, Dict

from geopy.geocoders import Nominatim

JSONType = Dict[str, Any]
YAMLType = Dict[str, Any]

logging.getLogger().setLevel(logging.INFO)


class OSMService:
    """OpenStreetMap (OSM) related services, such as Nominatim geolocator for
    GeoJSON export and uMap interactive maps."""

    geolocator: Nominatim

    def __init__(self, config_path: str) -> None:
        config = toml.load(config_path)
        self.geolocator = Nominatim(user_agent=config["nominatim"]["user_agent"])

    def place2feature(self, place: YAMLType) -> str:
        logging.info(f"Searching for: {place['search']}")
        location = self.geolocator.geocode(**place["search"])
        return {
            "type": "Feature",
            "properties": {
                "_umap_options": {"iconClass": "Default", "showLabel": None},
                "name": place["name"],
                "description": place["description"],
            },
            "geometry": {
                "type": "Point",
                "coordinates": [location.longitude, location.latitude],
            },
        }

    def places2geojson(self, places: YAMLType) -> JSONType:
        logging.warning(
            "It might take some time for a long list since Nominatim "
            "usage policy specifies a maximum use of 1 request per second."
        )
        features = []
        for place in places:
            features.append(self.place2feature(place))
            sleep(1)
        return {"type": "FeatureCollection", "features": features}


if len(sys.argv) != 2:
    sys.exit("Usage: ./yml2geojson.py [TRAVEL_YML_FILE]")

with open(sys.argv[1], "r") as f:
    try:
        places = yaml.safe_load(f)
        osm_service = OSMService(".secrets.toml")
        geojson = osm_service.places2geojson(places)
        print(json.dumps(geojson, indent=2))
    except yaml.YAMLError as exc:
        logging.error(exc)
