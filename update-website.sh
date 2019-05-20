#!/bin/bash

gap -b -q < makedoc.g && \
cd gh-pages && \
cp -f ../PackageInfo.g ../README* . && \
cp -f ../doc/*.{css,html,js,txt,png} doc/ && \
gap update.g && \
git add PackageInfo.g README* doc/ _data/package.yml && \
echo "Everything worked."
echo "Do a git commit and push in the gh-pages folder."

