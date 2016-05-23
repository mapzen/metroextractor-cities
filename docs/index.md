<style>
    .content.top {
      background-color: rgb(230,234,210);
      padding: 0px 10px;
    	margin-bottom: 20px;
    	margin-top: -10px;
    }
    .feedback {
      background-color: transparent !important;
      margin-top: 30px;
    }
    .top h4, .top .fa-times {
      margin: 0;
    }
    .content p {
      font-size:14px;
      line-height: 1.6em;
      margin: 15px 0;
    }
    .content .btn {
      margin:0;
    }
    @media(min-width: 768px) and (max-width: 992px) {
      .fa-comments { 
        font-size: 80px;
        margin-top: 40px;
      }
    }
  </style>
<div class="content top row"><img class="feedback col-sm-2 hidden-xs" src="https://mapzen.com/common/styleguide/images/feedback.svg"/><div class="col-sm-10 col-xs-12"><h4>Help us make Metro Extracts better!</h4><p>Hi, we are looking for people using metro extracts to participate in a short usability study. Interested in helping? Please answer a few short questions about how you use extracts in your mapping work and we will schedule a time to chat.</p><a href="https://docs.google.com/forms/d/1WXXV9PtiFcHzRoeLkXWXSBcbgKWauDy6oiAuj4mXa8Y/viewform" class="btn btn-mapzen-alt">Sure, let's do it!</a></div></div>
Metro Extracts are chunks of OpenStreetMap data clipped to the rectangular region surrounding a particular city or region of interest. Data is available for locations around the world.

To download the OSM data, go to the Metro Extracts download page at https://mapzen.com/data/metro-extracts/. The page has a map showing the available downloads, as well as a filter box and an alphabetical list of city names below it.

![Filter the list of extracts](./images/filter_extracts.png)

When you download from Metro Extracts, you can choose from several formats that run a spectrum of raw to more processed. For most map-making workflows, a shapefile or GeoJSON works well because these can be added directly to many software applications. The less-processed formats, such as xml and osm, are intended for developers who are running their own tools on the data. 

Metro Extracts is updated weekly, typically on weekends, but the last modified date and time is listed on the website. 

To learn more about using Metro Extracts, you can follow this [tutorial](walkthrough.md). You will download the extracted OSM data for a region and load the file into QGIS, which is a free, open-source desktop GIS application. 

If you want OpenStreetMap data for a city that is not currently available from Metro Extracts, you can follow the [instructions for contributing](https://github.com/mapzen/metroextractor-cities#contributing), or [open an issue](https://github.com/mapzen/metroextractor-cities/issues) requesting that your city be added to list.
