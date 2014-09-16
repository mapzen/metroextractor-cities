#!/usr/bin/env rake

require 'json'
require 'rainbow/ext/string'

namespace :test do
  desc 'Validate JSON'
  task :json do
    json_file = File.read('cities.json')

    puts 'Validating cities.json syntax'.color(:blue)
    begin
      JSON.load(json_file)
      puts 'OK'.color(:green)
    rescue JSON::ParserError
      abort 'JSON syntax error!'.color(:red)
    end
  end
end
