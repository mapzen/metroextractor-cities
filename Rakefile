#!/usr/bin/env rake

require 'json'
require 'rainbow/ext/string'

desc 'Run integration tests'
task :build do
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
  puts 'Validating json'.color(:blue)

  begin
    JSON.load(File.read('cities.json'))
    puts 'Syntax OK'.color(:green)
  rescue JSON::ParserError
    puts 'Syntax Error!'.color(:red)
    exit 1
  end

  # Produce new cities.geojson
  #
  if ENV['CIRCLECI'] == 'true'
    puts 'Building  cities.geojson'.color(:blue)
    sh 'bin/json2geojson.rb'
    sh 'git diff --exit-code; if [ $? = 0 ]; then exit 0; fi'
    sh "git config user.email 'circle@circleci'"
    sh "git config user.name 'circle'"
    sh "git commit -am 'cities.geojson update'"
    sh 'git push origin master'
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
