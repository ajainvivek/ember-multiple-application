#!/bin/bash

# copy_script
# This script moves the common libs from commons app
# Author: Ajain Vivek

app="app1"
filename="apps/$app/commons.json"
root="./apps/";
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

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
        echo "${red} ERROR: $1.${filetype[$i]} component missing ${reset}"
      fi
    done
  }

  # copy common routes
  copyModels () {
    filetype=js
    filepath=/models
    if [[ -e "./apps/common/app${filepath}${category}/$1.${filetype}" ]]; then
      mkdir "./apps/$app/lib/common/app${filepath}${category}" 2> /dev/null
      touch "./apps/$app/lib/common/app${filepath}${category}/$1.${filetype}"
      cp "./apps/common/app${filepath}${category}/$1.${filetype}"  "./apps/$app/lib/common/app${filepath}${category}/$1.${filetype}"
    else
      echo "${red} ERROR: $1.${filetype} models missing ${reset}"
    fi
  }

  # copy common mixins
  copyMixins () {
    filetype=js
    filepath=/mixins

    if [[ -e "./apps/common/app${filepath}${category}/$1.${filetype}" ]]; then
      mkdir "./apps/$app/lib/common/app${filepath}${category}" 2> /dev/null
      touch "./apps/$app/lib/common/app${filepath}${category}/$1.${filetype}"
      cp "./apps/common/app${filepath}${category}/$1.${filetype}"  "./apps/$app/lib/common/app${filepath}${category}/$1.${filetype}"
    else
      echo "${red} ERROR: $1.${filetype} mixins missing ${reset}"
    fi
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
    	mixins)
    		copyMixins $module;;
    	models)
        copyModels $module;;
    	*)
    		echo "unknown type"
    esac
  done
}

# Initialize
initCopy () {
  # Categories commons
  commons=(components mixins)

  # Common components on root path
  components=( $(jq ".commons.components.modules" $filename) )

  # Copy common components
  if [[ $components != null ]]; then
    copyModules components $filename
  fi

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

  # Common mixins on root path
  mixins=( $(jq ".commons.mixins.modules" $filename) )

  # Copy common mixins
  if [[ $mixins != null && $mixins != '' ]]; then
    copyModules mixins $filename
  fi

  # Common mixins categories
  mixinscat=( $(jq ".commons.mixins.categories[]" $filename) )

  # Copy common mixins category wise
  if [[ $mixinscat != '' && $mixinscat != null ]]; then
    for (( i=0; i<${#mixinscat[@]}; ++i )); do
      # remove trailing quotes from string
      category="${mixinscat[${i}]%\"}"
      category="${category#\"}"
      copyModules mixins $filename $category
    done
  fi


  # Common models on root path
  models=( $(jq ".commons.models.modules" $filename) )

  # Copy models mixins
  if [[ $models != null && $models != '' ]]; then
    copyModules models $filename
  fi

  # Common models categories
  modelscat=( $(jq ".commons.models.categories[]" $filename) )

  # Copy common models category wise
  if [[ $modelscat != null && $modelscat != '' ]]; then
    for (( i=0; i<${#modelscat[@]}; ++i )); do
      # remove trailing quotes from string
      category="${modelscat[${i}]%\"}"
      category="${category#\"}"
      copyModules models $filename $category
    done
  fi


}


initCopy
