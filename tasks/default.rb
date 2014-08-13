#!/usr/bin/env rake

task :default do
  Rake::Task['test'].invoke
  Rake::Task['build_geojson'].invoke
end
