#!/usr/bin/env rake

require 'json'
require 'rainbow/ext/string'

desc 'Build GeoJSON'
task :build_geojson do
  if ENV['CIRCLECI'] == 'true'
    if ENV['CIRCLE_BRANCH'] == 'master'
      puts 'Building cities.geojson'.color(:blue)
      sh <<-EOH
        bin/json2geojson.rb
        git diff --exit-code
        if [ $? != 0 ]
        then
          echo 'Changes found, committing and pushing'
          git config user.email 'circle@circleci'
          git config user.name 'circle'
          git commit -am 'COMMITTED VIA CIRCLECI: cities.geojson update'
          git push origin master
        else
          echo "No changes found, we're done here"
        fi
      EOH
    end
  end
end
