#!/usr/bin/env rake

require 'json'
require 'rainbow/ext/string'

desc 'Run integration tests'
task :build do
  puts "Validating json".color(:blue)

  begin
    JSON.load(File.read('cities.json'))
    puts 'Syntax OK'.color(:green)
    exit 0
  rescue JSON::ParserError
    puts 'Syntax Error!'.color(:red)
    exit 1
  end
end

task default: 'build'
