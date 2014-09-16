#!/usr/bin/env rake

task :test do
  Rake::Task['test:ruby'].invoke
  Rake::Task['test:bbox'].invoke
  Rake::Task['test:json'].invoke
  Rake::Task['test:whitespace'].invoke
  Rake::Task['test:geojson'].invoke
end
