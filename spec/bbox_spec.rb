#!/usr/bin/env rake

require 'json'
require 'rainbow/ext/string'

namespace :test do
  desc 'Validate Bounding Boxes'
  task :bbox do
    puts 'Validating cities.json bbox\'s'.color(:blue)
    json = JSON.parse(CitiesJSON)
    json['regions'].each do |region, a|
      region_top    = a['bbox']['top'].to_f
      region_left   = a['bbox']['left'].to_f
      region_bottom = a['bbox']['bottom'].to_f
      region_right  = a['bbox']['right'].to_f

      if region_left >= region_right
        abort "Failure! Left coordinate (#{region_left}) is >= to right coordinate (#{region_right}) for region #{region}.".color(:red)
      elsif region_bottom >= region_top
        abort "Failure! Bottom coordinate (#{region_bottom}) is >= to top coordinate (#{region_top}) for region #{region}.".color(:red)
      end

      a['cities'].each do |city, b|
        top     = b['bbox']['top'].to_f
        left    = b['bbox']['left'].to_f
        bottom  = b['bbox']['bottom'].to_f
        right   = b['bbox']['right'].to_f

        # make sure the city bbox is valid
        if left >= right
          abort "Failure! Left coordinate (#{left}) is >= to right coordinate (#{right}) for city #{city}.".color(:red)
        elsif bottom >= top
          abort "Failure! Bottom coordinate (#{bottom}) is >= to top coordinate (#{top})for city #{city}.".color(:red)

        # make sure the city bbox falls inside the region bbox
        elsif left < region_left
          abort "Failure! Left coordinate (#{left}) is < region left coordinate (#{region_left}) for city #{city} and region #{region}.".color(:red)
        elsif bottom < region_bottom
          abort "Failure! Bottom coordinate (#{bottom}) is < region bottom coordinate (#{region_bottom}) for city #{city} and region #{region}.".color(:red)
        elsif top > region_top
          abort "Failure! Top coordinate (#{top}) is > region top coordinate (#{region_top}) for city #{city} and region #{region}.".color(:red)
        elsif right > region_right
          abort "Failure! Right coordinate (#{right}) is > region right coordinate (#{region_right}) for city #{city} and region #{region}.".color(:red)
        end
      end
    end
    puts 'OK'.color(:green)
  end
end
