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
    puts 'Building cities.geojson'.color(:blue)
    sh <<-EOH
      BRANCH=$(git rev-parse --abbrev-ref HEAD)
      if [ ${BRANCH} -eq 'master' ]
      then
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
      else
        echo "Branch isn't master, not doing anything fancy"
      fi
    EOH
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
