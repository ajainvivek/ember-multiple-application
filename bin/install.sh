#!/bin/bash

apps=(app1 app2)

do_install()
{
  pushd apps/$1
  npm install
  bower install
  popd
}

# Start building
for (( i=0; i<${#apps[@]}; ++i )); do
  do_install ${apps[$i]}
done
