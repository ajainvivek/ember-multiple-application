#!/bin/bash

scriptPath="$(dirname "$0")"
apps=(app1 app2)

do_build()
{

  # Copy Common Modules
  sh "${scriptPath}/copy-script.sh" $1

  pushd apps/$1

  # Remove dist folder from public/apps dir
  rm -Rf public/apps

  # Build
  ember build --environment=production

  # Move and rename files
  cd dist
  mv index.html $1.html
  cp -Rf * ../../../dist/

  # Cleanup
  cd ..
  rm -Rf dist

  # Reset
  popd
}

# Clean out any old build
rm -Rf dist
mkdir dist

# Start building
for (( i=0; i<${#apps[@]}; ++i )); do
  do_build ${apps[$i]}
done

# Add dist folder from public/apps dir
for (( i=0; i<${#apps[@]}; ++i )); do
  mkdir "apps/${apps[$i]}/public/apps/"
  cp -Rf dist "apps/${apps[$i]}/public/apps/"
done
