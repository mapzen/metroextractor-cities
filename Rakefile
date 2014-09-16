#!/usr/bin/env rake

CitiesJSON    = File.read('cities.json')
CitiesGeoJSON = File.read('cities.json')

Dir.glob('tasks/*.rb').each { |r| import r }
Dir.glob('spec/*_spec.rb').each { |r| import r }
