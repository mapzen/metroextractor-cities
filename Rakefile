#!/usr/bin/env rake

require 'json'
require 'rainbow/ext/string'

desc 'Run integration tests'
task :build do
  json_file    = File.read('cities.json')
  geojson_file = File.read('cities.geojson')

  # Prepare sandbox
  #
  sandbox = File.join(File.dirname(__FILE__), %w(tmp))
  prepare_sandbox(sandbox)

  # Check ruby syntax
  #
  puts 'Running rubocop'.color(:blue)
  sh "rubocop #{File.dirname(sandbox)}/tmp"

  # Validate cities.json
  #
  puts 'Validating cities.json'.color(:blue)
  begin
    JSON.load(json_file)
    puts 'Syntax OK'.color(:green)
  rescue JSON::ParserError
    puts 'Syntax Error!'.color(:red)
    exit 1
  end

  # Validate cities.geojson
  #
  puts 'Validating cities.geojson syntax'.color(:blue)
  begin
    JSON.load(geojson_file)
    puts 'Syntax OK'.color(:green)
  rescue JSON::ParserError
    puts 'Syntax Error!'.color(:red)
    exit 1
  end

  puts 'Validating cities.geojson bbox\'s'.color(:blue)
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

  # Produce new cities.geojson
  #
  if ENV['CIRCLECI'] == 'true'
    if ENV['CIRCLE_BRANCH'] == 'master'
      puts 'Building cities.geojson'.color(:blue)
      sh <<-EOH
        bin/json2geojson.rb
        git diff --exit-code
        if [ $? != 0 ]
        then
          echo 'Changes found, committing and pushing'
          git config user.email 'circle@circleci'
          git config user.name 'circle'
          git commit -am 'COMMITTED VIA CIRCLECI: cities.geojson update'
          git push origin master
        else
          echo "No changes found, we're done here"
        fi
      EOH
    end
  end
end

task default: 'build'

def prepare_sandbox(sandbox)
  files = %w(Rakefile *.md *.rb)

  puts 'Preparing sandbox'.color(:blue)
  rm_rf sandbox
  mkdir_p sandbox
  cp_r Dir.glob("{#{files.join(',')}}"), sandbox
end
