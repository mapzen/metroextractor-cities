#!/usr/bin/env rake

require 'json'
require 'rainbow/ext/string'

namespace :test do
  desc 'Validate bounding box size'
  task :bbox_size do
    puts 'Validating cities.json bbox\'s'.color(:blue)
    json = JSON.parse(CitiesJSON)
    json['regions'].each do |region, a|
      region_top    = a['bbox']['top'].to_f
      region_left   = a['bbox']['left'].to_f
      region_bottom = a['bbox']['bottom'].to_f
      region_right  = a['bbox']['right'].to_f

      region_threshold = 75
      if (region_left - region_right) > region_threshold
        abort "Failure! Bounding box is too big! Left coordinate (#{region_left}) - right coordinate (#{region_right}) for region #{region} is greater than #{region_threshold}.".color(:red)
      elsif (region_top - region_bottom) > region_threshold
        abort "Failure! Bounding box is too big! Top coordinate (#{region_top}) - bottom coordinate (#{region_bottom}) for region #{region} is greater than #{region_threshold}.".color(:red)
      end

      a['cities'].each do |city, b|
        top     = b['bbox']['top'].to_f
        left    = b['bbox']['left'].to_f
        bottom  = b['bbox']['bottom'].to_f
        right   = b['bbox']['right'].to_f

        city_threshold = 5
        if (left - right) > city_threshold
          abort "Failure! Bounding box is too big! Left coordinate (#{left}) - right coordinate (#{right}) for city #{city} is greater than #{city_threshold}.".color(:red)
        elsif (top - bottom) > city_threshold
          abort "Failure! Bounding box is too big! Top coordinate (#{top}) - bottom coordinate (#{bottom}) for city #{city} is greater than #{city_threshold}.".color(:red)
        end
      end
    end
    puts 'OK'.color(:green)
  end
end
