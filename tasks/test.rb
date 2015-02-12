#!/usr/bin/env rake

task :test do
  Rake::Task['test:ruby'].invoke
  Rake::Task['test:bbox'].invoke
  Rake::Task['test:bbox_size'].invoke
  Rake::Task['test:bbox_numeric'].invoke
  Rake::Task['test:bbox_precision'].invoke
  Rake::Task['test:json'].invoke
  Rake::Task['test:whitespace'].invoke
  Rake::Task['test:geojson'].invoke
end
