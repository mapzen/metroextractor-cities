#!/usr/bin/env rake

task :default do
  Rake::Task['test'].invoke
end
