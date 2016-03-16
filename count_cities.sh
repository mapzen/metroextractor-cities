#!/usr/bin/env bash

for sha in `git rev-list --all`
  do
    date=`git --no-pager show -s --format=%ci $sha`
    count=`git --no-pager show $sha:cities.geojson | grep '"type": "Feature"' | wc -l`
    if [ "$count" -gt "0" ]
      then
      echo $date,$count >> 'countlist.csv'
    fi
done
