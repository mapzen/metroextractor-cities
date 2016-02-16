# Walkthrough: Extract OpenStreetMap data for display in QGIS

Metro Extracts are chunks of OpenStreetMap data clipped to the rectangular region surrounding a particular city or region of interest.

In this walkthrough, you will download the extracted OSM data for a region and load the file into QGIS, which is a free, open-source desktop GIS application. You will use QGIS to explore the structure of the extracts and make a map of roads and places in Lisbon, Portugal. You can follow along by downloading the data for Lisbon, or choose a different city.

##Requirements:

1. An Internet connection with the ability to download the Metro Extract files. The Lisbon data used in this exercise is approximately 50 MB, but downloads for other cities range from 2 MB to 350 MB.
2. QGIS and its dependencies, such as GDAL. QGIS is available for multiple platforms, including Windows and Mac. If you need to install QGIS, follow the instructions for your [operating system](https://www.qgis.org/en/site/forusers/download.html). The tutorial was originally written for QGIS 2.8 (Wien).

##Download the extract files
Originally created by Mike Migurski, Mapzen has taken over hosting and maintenance of Metro Extracts. You will go to the Mapzen website to download the files.

1. Open a web browser to the Metro Extracts download page at https://mapzen.com/data/metro-extracts/. The page has a map showing the available downloads, as well as a filter box and an alphabetical list of city names below it.
2. Below the map, in the Filter box, type `lisbon`. You can also zoom in on the map to see the area covered and click a box to choose the city.

    ![Filter the list of extracts](./images/filter_extracts.png)

3. The matching result appears in the list. If you do not see the city you want, choose another one from the list. (Note that you can submit a GitHub request to add a city to the list of extracts, but more on that later).

When you download from Metro Extracts, you can choose from several formats that run a spectrum of raw to more processed from left to right. The less-processed formats, such as xml and osm, are intended for developers who are running their own tools on the data. For most map-making workflows, a shapefile or GeoJSON works well because these can be added directly to many software applications.

The names and contents of the shapefiles and GeoJSON files are based on the process used to extract the OSM data: osm2pgsql or imposm. When you download a Metro Extract created with [osm2pgsql](http://wiki.openstreetmap.org/wiki/Osm2pgsql), you get three datasets split by geometry type: lines, points, or polygons. The [imposm](http://imposm.org/) extracts, however, are grouped into individual layers based on the tags used in OSM, such as buildings and roads.

You will download one of each of these export types so you can explore the file structure, using both shapefiles and GeoJSONs.

![Available files for Lisbon, Portugal](./images/lisbon_download_formats.png)

1. Click OSM2PGSQL SHP to download the shapefile.
2. Click IMPOSM GEOJSON to download the GeoJSON.
3. Find the downloaded files on disk (by default, they will be in your machine's download folder) and unzip them if they were not unzipped automatically. There should be two folders, each containing the appropriate Metro Extracts files.

Note: If you are using Safari as your browser, your downloads may get unzipped automatically and the folders be named slightly differently than those shown in this walkthrough.

While a GeoJSON is a single .geojson file on disk, one shapefile is made of individual files (.shp, .dbf, .prj, and so on), so do not delete or move individually any of these constituent files to avoid corrupting the shapefile and having to download it again. If you manage the files through GIS software, the components are treated as a whole entity and are updated appropriately.

###Add the osm2pgsql shapefiles to QGIS

Now that the files are downloaded, you will load them into QGIS.

1. Start QGIS and display a blank map.
2. On the Browser panel, expand the lisbon_portugal.osm2pgsql folder. If the Browser panel is not visible, you can turn it on from the View menu. If you downloaded a city other than Lisbon, navigate to that folder and expand its contents.
3. Notice that the folder contains three shapefiles, named by the geometry type: point, line, and polygon.
4. Drag the line layer onto the map. Because the extracts are based on a rectangular bounding box, the layer's extent will extend beyond the true administrative boundaries of a city.

    ![osm2pgsql layers added to a map](./images/osm_line_default.png)

###Add a basemap to your map

With the lines alone, it is hard to tell much about the area. You can add a basemap to give the lines more reference. One way to add a basemap is by adding a plug-in to QGIS that allows you to choose from a variety of basemap providers and map types. You will use the OpenLayers plug-in; you need to install it if you do not already have it. If you already have it, skip the installation steps.

####Install the OpenLayers plug-in
1. Click the Plugins menu.
2. Click Manage and Install Plugins.
3. On the All tab, in the Search box, type openlayers.
4. Click OpenLayers Plugin, install it, and close the dialog box.

####Choose a basemap
1. Click the Web menu, point to OpenLayers Plugin, point to OSM/Stamen, and click Stamen Toner/OSM. This adds a black-and-white basemap of OpenStreetMap data provided by Stamen.

    ![Add a basemap](./images/add_basemap.png)

2. If the basemap obscures your line layer, drag the basemap to the bottom of the layer list.

The shapefiles and GeoJSONs all have a spatial reference of WGS 84, and more specifically, EPSG:4326. When using GIS software, such as QGIS or ArcMap, you should be able to overlay the OSM layers with others in your map (note that in QGIS, you need to enable on-the-fly projection in the project's properties). If you are having problems with data alignment, review the documentation for the software you are using for tips on troubleshooting projections.

### View the extract's attribute values

The line layer has over 100,000 features in it, representing every line in OSM in this region, although you are only interested in mapping roads for this walkthrough. You can view the attribute table to understand the search terms to use to limit the display to only certain features.

In OSM, a feature is identified through a [tag](http://wiki.openstreetmap.org/wiki/Tags) that describes the attributes as a key and a value. The key is a broad category, such as `highway`, and the value provides more details, such as the type of road or its name.

1. Under Layers, right-click the lisbon_portugal_osm_line layer and click Open Attribute Table.
2. In the table, the columns across the top represent the most common keys. The rows are individual features in the OSM database referenced by their OSM identification number. As you look through the attribute values, notice that most of the them are `NULL`, indicating that the tag has not been populated.

    ![osm2pgsql attribute table](./images/osm2pgsql_attribute_table.png)

3. Scroll the table to the right to see the highways field and scroll down to see the values in that field.

### Query for road features

As you looked through the table, you may have noticed a few features with a value of [motorway](http://wiki.openstreetmap.org/wiki/Tag:highway%3Dmotorway). A motorway is the highest-level of road in a territory. You can query the attribute table to display only the features that are classified as motorways near Lisbon.

1. Right-click the line layer and click Filter. This opens a dialog box where you can enter a query to filter the layer.
2. In the Fields list, double-click `highway` to add it to expression box below. A field is another term for a column in the attribute table.
3. Under Operators, click the `equals` button.
4. Under Values, click All to get a listing of the available values for the highways field.
5. Double-click `motorway` to add it to the expression. Your expression should read: ``"highway" = 'motorway'``.

    ![Query for motorways](./images/query_builder.png)

6. Click the Test button to verify the syntax of your query. You should receive a message indicating that over 1,000 rows were returned. If not, make sure your text matches the text in the image.
7. Click OK.

Tip: In some cases, performing a query in QGIS may fail if the shapefile has a period or dot in its name. If this happens, rename the shapefile to remove the period. You should not see this with Metro Extracts because the files use underscores.

The map and attribute table now show fewer features because only motorways are being displayed. The other features that do not satisfy the query are still present in the shapefile, but are being hidden from the map. You can export the features, though, if you do want to make a new layer with only motorway lines. If you want to draw all the features again, you can remove the query.

The simplicity of having all line features being grouped into one line layer is the benefit of the osm2pgsql format, but it does require performing queries to be the most useful.

###Change the symbols for the line features

Because motorways are major roads, they should be displayed with a thicker line. QGIS comes with a series of styles already loaded. You can choose to use one of them or build your own symbol to display motorways.

1. Under Layers, double-click the line layer to open its properties.
2. Click the Style tab.
3. Find the Motorway symbol in the list of styles and click it.
4. Click OK to apply the symbol.

    ![Overlapping motorway symbols](./images/overlapping_lines.png)

Because each line feature is being rendered individually, the symbols overlap. Instead, the lines should be drawn as one, continuous feature. You can use a technique called symbol level drawing to merge symbol boundaries.

5. Open the layer's properties again to the Styles tab.
6. Click the Advanced button, and click Symbol levels.
7. Check Enable symbol levels.
8. Click OK on all dialog boxes.

    ![Merged line symbols](./images/symbol_level_lines.png)

Note that there are other cartographic functions on the Styles tab to improve the appearance of the map, including transparency. You can experiment with these on your own.

##Add the imposm GeoJSON files to QGIS

So far you have used the osm2pgsql shapefile, but you also downloaded one of the imposm GeoJSON files. Next, you will add that file to QGIS.

The imposm extraction process results in a series of individual layers named by different themes, such as buildings and places. You may also see files with -gen appended to the name, indicating that the features have been generalized, or simplified. Because features in the imposm layers are already categorized based on attributes, it is less likely that you will need to run your own query to display the features you want. For example, if you want to work with roads, you can find them already grouped in a roads layer.

1. On the Browser panel, expand the lisbon_portugal.imposm-geojson folder.
2. Add the lisbon_portugal_places GeoJSON file to the map.

In the imposm process, the categorization of features into particular layers is determined by the listing and hierarchy in a [JSON file](https://github.com/mapzen/chef-metroextractor/blob/master/files/default/mapping.json). In some cases, this may result in certain OSM tags being in parts of multiple layers. If you cannot find a particular attribute value in the first layer you check, look through the other imposm files, or go back and export it from the osm2pgsql layer.

###Change the symbols for the places layer

The features in the places layer are drawn with one symbol, but you can use the attribute values to draw them in categories with different symbols for certain values.

1. Open the places layer's properties.
2. Click the Style tab.
3. Under Single Symbol, click Categorized to change the drawing method to draw the features by categories.
4. For Column, click `type` to set the `type` field as the field containing the values that will be used to draw the features.
5. Click Classify below the box. This adds all the unique values in the type field and assigns them a separate symbol.
6. If there are any symbols without values or legend entries, highlight them in the list and click Delete.
7. To make the city symbol larger and more prominent, right-click it in the list and click Change size. Set the size to 5.

    ![Places drawn as categories](./images/symbol_categories.png)

8. You can experiment with the symbol colors and sizes to make the different points appear the way you want.
9. Click OK when you are done to return to the map and see your changes.
10. Optionally, save your project when you are done.

Beyond QGIS on the desktop, there are many web-based tools you can use to display GeoJSON. Some of the websites you can use without scripting include [geojson.io](http://geojson.io/) and the [GitHub website](https://help.github.com/articles/mapping-geojson-files-on-github/). Not all applications support large numbers of features or direct editing of GeoJSON, so you may need to convert to another format. Consult the documentation for the software you are using to learn more about its capabilities and limitations.

##Walkthrough summary and new cities for Metro Extracts

In this walkthrough, you downloaded different file formats of Metro Extracts, added the layers to QGIS, and performed queries and set symbols for the features. You should have a better idea of the contents of each download so you can decide which one works best for your project.

Metro Extracts is updated weekly, typically on weekends, but the last modified date and time is listed on the website. Through scripting, you could set up a recurring process to download the updated files, unzip them, and replace the files in your map project.

If you want OpenStreetMap data for a city that is not currently available from Metro Extracts, you can follow the [instructions for contributing and update the cities.json file](https://github.com/mapzen/metroextractor-cities#contributing) that specifies the cities to export, or [open an issue](https://github.com/mapzen/metroextractor-cities/issues) requesting that your city be added to list.

##Data credits
OpenStreetMap data: &copy; OSM contributors

Toner map: Map tiles by [Stamen Design](http://stamen.com), under [CC BY 3.0](http://creativecommons.org/licenses/by/3.0).
