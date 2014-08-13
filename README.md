metroextractor-cities
=====================
![Build Status](https://circleci.com/gh/mapzen/metroextractor-cities.png?circle-token=83dc13d4097b378ad6ba101b226118fda9e03844)

Description
-----------
* cities.json defines bounding boxes for various metro areas, which are used by [chef-metroextractor](https://github.com/mapzen/chef-metroextractor)
to produce weekly extracts.

Pull Request Overview
----------------------
* update cities.json and submit a pull request
  * it is not necessary to update cities.geojson, as it will be generated automatically after your pull request is merged
  * make sure that the bounding box of the city you're adding falls within the upper level bounding box for the continent you're placing it in
  * the top/left/bottom/right bbox parameters should be carried out to the thousandths (three digits to the right of the decimal)

License and Authors
-------------------
* license: GPL
* authors: grant@mapzen.com
