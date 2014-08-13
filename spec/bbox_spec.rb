#!/usr/bin/env rake

require 'json'
require 'rainbow/ext/string'

namespace :test do
  desc 'Validate Bounding Boxes'
  task :bbox do
    json_file = File.read('cities.json')

    puts 'Validating cities.json bbox\'s'.color(:blue)
    json = JSON.parse(json_file)
    json['regions'].each do |region, a|
      a['cities'].each do |city, b|
        top     = b['bbox']['top'].to_f
        left    = b['bbox']['left'].to_f
        bottom  = b['bbox']['bottom'].to_f
        right   = b['bbox']['right'].to_f

        if left >= right
          abort "Failure! Left coordinate (#{left}) is >= to right coordinate (#{right}) for city #{city}.".color(:red)
        elsif bottom >= top
          abort "Failure! Bottom coordinate (#{bottom}) is >= to top coordinate (#{top})for city #{city}.".color(:red)
        end
      end
    end
    puts 'Syntax OK'.color(:green)
  end
end
