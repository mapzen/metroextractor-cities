metroextractor-cities
=====================
![Build Status](https://circleci.com/gh/mapzen/metroextractor-cities.png?circle-token=83dc13d4097b378ad6ba101b226118fda9e03844)

Description
-----------
* cities.json defines bounding boxes for various metro areas, which are used by [chef-metroextractor](https://github.com/mapzen/chef-metroextractor)
to produce weekly extracts.

Pull Request Overview
----------------------
You need to perform the following tasks for us to accept a pull request:

* update cities.json with your changes. Do not modify cities.geojson, it will be generated automatically when your pull request is merged.
*  run the included tests, which will validate:
  * the syntax of the json
  * that the bounding boxes being sumbitted are valid
  * that the bounding boxes for cities all fall within their encompassing upper level bounding box (e.g. north_america)
* the top/left/bottom/right bbox parameters should be carried out to the thousandths (three digits to the right of the decimal)

If you're unable to run the test suite locally, you can submit a pull requests, but if the specs fail there will be a delay in getting your request resolved.

Running Tests
-------------
You will need to have a Ruby 2.x environment, then simply:

`bundle install`
`bundle exec rake`

License and Authors
-------------------
* license: GPL
* authors: grant@mapzen.com
