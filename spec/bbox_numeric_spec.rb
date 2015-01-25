#!/usr/bin/env rake

require 'json'
require 'rainbow/ext/string'

namespace :test do
  desc 'Validate bounding box input is numeric'
  task :bbox_numeric do
    puts 'Validating cities.json bbox input is numeric'.color(:blue)
    json = JSON.parse(CitiesJSON)

    def valid_input?(input, area)
      true if Float(input)
    rescue
      abort "Failure! Bounding box value for area \"#{area}\" is non-numeric: \"#{input}\".".color(:red)
    end

    boxes = %w(top left bottom right)
    boxes.each do |box|
      json['regions'].each do |region, a|
        valid_input?(a['bbox'][box], region)

        a['cities'].each do |city, b|
          valid_input?(b['bbox'][box], city)
        end
      end
    end
    puts 'OK'.color(:green)
  end
end
