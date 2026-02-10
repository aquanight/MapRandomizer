#!/bin/bash
set -eux
COMMIT=${1:-upstream/master}
cd sm-json-data
git fetch upstream
git fetch kjbranch
git checkout ${COMMIT}
git merge -s ours kjbranch/map-rando -m "Merge new upstream version"
git tag new-base
git rebase --onto HEAD base kjbranch/map-rando
git tag -f base new-base
git tag -d new-base
git push kjbranch HEAD:map-rando
git push -f kjbranch base
git checkout kjbranch/map-rando

