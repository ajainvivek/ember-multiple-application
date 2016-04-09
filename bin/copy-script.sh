#!/bin/bash

# copy_script
# This script moves the common libs from commons app
# Author: Ajain Vivek

app="app1"
filename="apps/$app/commons.json"
root="./apps/";

# Get the common modules based on type
copyModules () {
  jqcategory=""
  category=""
  #if category exists then set category
  if [ $# -eq 3 ]; then
    jqcategory=".$3"
    category="/$3"
  fi
  modules=( $(jq ".commons.${1}${jqcategory}.modules[]" $2) )

  # copy common components
  copyComponents () {
    filetype=(js scss hbs)
    filepath=(/components /styles/components /templates/components)

    for (( i=0; i<3; ++i )); do
      if [[ -e "./apps/common/app${filepath[$i]}${category}/$1.${filetype[$i]}" ]]; then
        mkdir "./apps/$app/lib/common/app${filepath[$i]}${category}" 2> /dev/null
        touch "./apps/$app/lib/common/app${filepath[$i]}${category}/$1.${filetype[$i]}"
        cp "./apps/common/app${filepath[$i]}${category}/$1.${filetype[$i]}"  "./apps/$app/lib/common/app${filepath[$i]}${category}/$1.${filetype[$i]}"
      else
      	echo "$1.${filetype[$i]} component missing"
      fi
    done
  }

  # copy common routes
  copyRoutes () {
    echo "Module Missing"
  }

  # copy common routes
  copyModels () {
    echo "Module Missing"
  }

  # copy common mixins
  copyMixins () {
    echo "Module Missing"
  }

  # copy common services
  copyServices () {
    echo "Module Missing"
  }

  # copy common helpers
  copyHelpers () {
    echo "Module Missing"
  }

  for (( i=0; i<${#modules[@]}; ++i )); do
    # remove trailing quotes from string
    module="${modules[${i}]%\"}"
    module="${module#\"}"

    case $1 in
    	components)
        copyComponents $module;;
    	routes)
    		echo "routes";;
    	models)
    		echo "models";;
    	*)
    		echo "unknown type"
    esac
  done
}

# Initialize
initCopy () {
  # # Common components on root path
  # components=( $(jq ".commons.components.modules" $filename) )
  #
  # # Copy common components
  # if [[ $components != null ]]; then
  #   copyModules components $filename
  # fi

  # Common components categories
  componentscat=( $(jq ".commons.components.categories[]" $filename) )

  # Copy common components category wise
  if [[ $componentscat != null ]]; then
    for (( i=0; i<${#componentscat[@]}; ++i )); do
      # remove trailing quotes from string
      category="${componentscat[${i}]%\"}"
      category="${category#\"}"
      copyModules components $filename $category
    done
  fi
}


initCopy
