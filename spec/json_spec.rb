#!/usr/bin/env rake

require 'json'
require 'rainbow/ext/string'

namespace :test do
  desc 'Validate JSON'
  task :json do
    puts 'Validating cities.json syntax'.color(:blue)
    begin
      JSON.load(CitiesJSON)
      puts 'OK'.color(:green)
    rescue JSON::ParserError
      abort 'JSON syntax error!'.color(:red)
    end
  end
end
