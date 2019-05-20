#!/bin/bash

gap -b -q < makedoc.g && \
cd gh-pages && \
cp -f ../PackageInfo.g ../README* . && \
cp -f ../doc/*.{css,html,js,txt,png} doc/ && \
gap update.g && \
git add PackageInfo.g README* doc/ _data/package.yml && \
echo "Everything worked."
echo "Now do this:"
echo ""
echo "  cd gh-pages"
echo "  git commit -m 'Updating website with...'"
echo "  git push"
echo "  cd .."

