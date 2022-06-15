#!/bin/bash

# create folder structure for placing builds
mkdir -p www/{v1,v2,beta,lts}

# change directory
cd simple-react-app

# create copy of package.json for safety reasons
cp package.json package-copy.json

BUILDS=( v1 v2 beta lts )
for i in "${BUILDS[@]}"
do
	echo "Build process started for '$i'"

  # remove previous build if already exists
  echo "Removing build if already exists"
  rm -r ./build

  # step-1 change package.json
  echo "Updating package.json"

  HOMEPAGE="/$i"
  if [ "$i" = "lts" ]; then
    HOMEPAGE="/"
  fi
  CONTENTS="$(jq '.homepage = "'"$HOMEPAGE"'"' package.json)"
  echo -E "$CONTENTS" > package.json


  # step-2 create build
  echo "Building..."
  npm run build

  echo "Copying build to '../www/$i' directory"
  # step-3 copy build to specified directory
  cp -r ./build "../www/$i"

  printf "Successfully copied build copied to '../www/$i'\n"
done

echo "Successfully Created All Builds"

