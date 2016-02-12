#!/usr/bin/env rake

require 'json'
require 'rainbow/ext/string'
require 'set'

namespace :test do
  desc 'Check for duplicates'
  task :duplicates do
    puts 'Checking cities.json for duplicate names'.color(:blue)

    names_seen = Set.new
    json = JSON.parse(CitiesJSON)
    json['regions'].each_value do |region|
      region['cities'].each_key do |city|
        if names_seen.include?(city)
          abort "Failure! City with name #{city.inspect} appears twice.".color(:red)
        else
          names_seen.add(city)
        end
      end
    end
    puts 'OK'.color(:green)
  end
end
