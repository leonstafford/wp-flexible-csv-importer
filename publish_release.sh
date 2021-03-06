#!/bin/bash

PROJECT_ROOT=$(pwd)
SVN_ROOT=/home/leon/svn-csv-plugin
NEW_TAG=0.1

# run from project root

# copy all files to svn trunk
cp -r $PROJECT_ROOT/* $SVN_ROOT/trunk/

# remove files only used in development
rm $SVN_ROOT/trunk/*.sh
rm $SVN_ROOT/trunk/*.ini
rm $SVN_ROOT/trunk/Dockerfile
rm $SVN_ROOT/trunk/readme.md
rm -r $SVN_ROOT/trunk/wpassets

# image assets (for WP official pages) need to go into /assets, not /trunk
cp -r $PROJECT_ROOT/wpassets/* $SVN_ROOT/assets/

cd $SVN_ROOT

# tell svn to add the files
svn add trunk/*

# svn commit trunk
svn ci -m "adding files for release $NEW_TAG"

# svn create tag
svn cp trunk tags/$NEW_TAG

# push tag up
svn ci -m "new tag $NEW_TAG"
