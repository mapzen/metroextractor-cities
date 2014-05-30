#!/usr/bin/env ruby

require 'json'

json = File.read('cities.json')
data = JSON.parse(json)
output = { 'type' => 'FeatureCollection', 'features' => [] }

data['regions'].each do |k, v|
  v['cities'].each do |city, val|
    c = { 'type' => 'Feature' }
    c['properties'] = { 'name' => city }
    c['bbox'] = [
      val['bbox']['left'].to_f,
      val['bbox']['bottom'].to_f,
      val['bbox']['right'].to_f,
      val['bbox']['top'].to_f
    ]
    c['geometry'] = { 'type' => 'Polygon', 'coordinates' => [] }
    c['geometry']['coordinates'].push([
      [val['bbox']['left'].to_f, val['bbox']['top'].to_f],
      [val['bbox']['right'].to_f, val['bbox']['top'].to_f],
      [val['bbox']['right'].to_f, val['bbox']['bottom'].to_f],
      [val['bbox']['left'].to_f, val['bbox']['bottom'].to_f],
      [val['bbox']['left'].to_f, val['bbox']['top'].to_f]
    ])
    output['features'].push(c)
  end
end

File.open('cities.geojson', 'w') do |file|
  file.write(JSON.pretty_generate(output))
end
