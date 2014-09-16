#!/usr/bin/env rake

require 'json'
require 'rainbow/ext/string'

namespace :test do
  desc 'Check for whitespace'
  task :whitespace do
    puts 'Checking cities.json for invalid whitespace'.color(:blue)
    json_file = File.read('cities.json')
    json_file.each_line do |line|
      if line =~ /"\s+\d+|"\s+-|\d+\s+"/
        puts 'Syntax Error!'.color(:red)
        abort line.color(:yellow)
      end
    end
    puts 'Whitespace OK'.color(:green)
  end

  desc 'Validate JSON'
  task :json do
    json_file = File.read('cities.json')

    puts 'Validating cities.json syntax'.color(:blue)
    begin
      JSON.load(json_file)
      puts 'JSON syntax OK'.color(:green)
    rescue JSON::ParserError
      abort 'JSON syntax error!'.color(:red)
    end
  end
end
