#!/usr/bin/env rake

require 'rainbow/ext/string'

namespace :test do
  desc 'Check for whitespace'
  task :whitespace do
    puts 'Checking cities.json for invalid whitespace'.color(:blue)

    linenum = 0
    CitiesJSON.each_line do |line|
      linenum += 1
      if line =~ /"\s+\d+|"\s+-|\d+\s+"/
        puts "Syntax error on line number #{linenum}!".color(:red)
        abort line.color(:yellow)
      end
    end
    puts 'OK'.color(:green)
  end
end
