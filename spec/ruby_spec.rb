#!/usr/bin/env rake

require 'rainbow/ext/string'

namespace :test do
  desc 'Validate Ruby Syntax'
  task :ruby do
    sandbox = File.join(File.dirname(__FILE__), %w(tmp))
    prepare_sandbox(sandbox)

    puts 'Running rubocop'.color(:blue)
    sh "rubocop #{File.dirname(sandbox)}/tmp"
  end

  def prepare_sandbox(sandbox)
    files = %w(Rakefile *.md *.rb spec/*.rb tasks/*.rb)

    puts 'Preparing sandbox'.color(:blue)
    rm_rf sandbox
    mkdir_p sandbox
    cp_r Dir.glob("{#{files.join(',')}}"), sandbox
  end
end
