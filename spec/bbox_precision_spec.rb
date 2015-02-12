#!/usr/bin/env rake

require 'json'
require 'rainbow/ext/string'

namespace :test do
  desc 'Validate bounding box input is carried to 3 decimal place precision'
  task :bbox_precision do
    puts 'Validating cities.json bbox input is carried to three decimal places of precision'.color(:blue)
    json = JSON.parse(CitiesJSON)

    def decimal_precision?(input, area, limit)
      places = input.to_s.split('.')[1].size.to_i
      fail if places != limit
    rescue
      abort "Failure! Bounding box value for area \"#{area}\" is not denoted with 3 decimal places of precision : \"#{input}\".".color(:red)
    end

    boxes = %w(top left bottom right)
    boxes.each do |box|
      json['regions'].each do |region, a|
        decimal_precision?(a['bbox'][box], region, 3)

        a['cities'].each do |city, b|
          decimal_precision?(b['bbox'][box], city, 3)
        end
      end
    end
    puts 'OK'.color(:green)
  end
end
