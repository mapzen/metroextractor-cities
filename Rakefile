#!/usr/bin/env rake

require 'json'
require 'rainbow/ext/string'

desc 'Run integration tests'
task :build do
  # Check ruby syntax
  #
  puts 'Running rubocop'.color(:blue)
  sh "rubocop ."

  # Validate cities.json
  #
  puts 'Validating json'.color(:blue)

  begin
    JSON.load(File.read('cities.json'))
    puts 'Syntax OK'.color(:green)
    exit 0
  rescue JSON::ParserError
    puts 'Syntax Error!'.color(:red)
    exit 1
  end

  # If json is valid, build geojson and commit/push
  #
  puts 'Building cities.geojson and committing/pushing...'.color(:blue)
  sh "./json2geojson.rb"
  sh "git commit -am 'cities.geojson update'"
  sh "git push origin master"
end

task default: 'build'
