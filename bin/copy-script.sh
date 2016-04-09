#!/bin/bash

# copy_script
# This script moves the common libs from commons app
# Author: Ajain Vivek

filename="app1/commons.json"

# Get the common modules based on type
copyModules () {
  modules=( $(jq ".commons.${1}.modules[]" $2) )

  for (( i=0; i<${#modules[@]}; ++i )); do
    # remove trailing quotes from string
    module="${modules[${i}]%\"}"
    module="${module#\"}"

    if [[ -e "commons/$module.txt" ]]; then
    	echo $module
    else
    	echo "Module Missing"
    fi
  done
}

# Initialize
initCopy () {
  controls=( $(jq ".commons.controls" $filename) )

  # Copy common components
  if [[ $controls != null ]]; then
    copyModules controls $filename
  fi
}


initCopy
