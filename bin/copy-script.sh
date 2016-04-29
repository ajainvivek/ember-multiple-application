#!/bin/bash

# copy_script
# This script moves the common libs from commons app
# Author: Ajain Vivek

app=$1
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
    local i
    filetype=(js scss hbs)
    filepath=(/components /styles/components /templates/components)

    for (( i=0; i<3; ++i )); do
      if [[ -e "./apps/common/app${filepath[$i]}${category}/$1.${filetype[$i]}" ]]; then
        mkdir "./apps/$app/lib/common/app${filepath[$i]}" 2> /dev/null
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
      mkdir "./apps/$app/lib/common/app${filepath}" 2> /dev/null
      mkdir "./apps/$app/lib/common/app${filepath}${category}" 2> /dev/null
      touch "./apps/$app/lib/common/app${filepath}${category}/$1.${filetype}"
      cp "./apps/common/app${filepath}${category}/$1.${filetype}"  "./apps/$app/lib/common/app${filepath}${category}/$1.${filetype}"
    else
      echo "${red} ERROR: $1.${filetype} model missing ${reset}"
    fi
  }

  # copy common mixins
  copyMixins () {
    filetype=js
    filepath=/mixins

    if [[ -e "./apps/common/app${filepath}${category}/$1.${filetype}" ]]; then
      mkdir "./apps/$app/lib/common/app${filepath}" 2> /dev/null
      mkdir "./apps/$app/lib/common/app${filepath}${category}" 2> /dev/null
      touch "./apps/$app/lib/common/app${filepath}${category}/$1.${filetype}"
      cp "./apps/common/app${filepath}${category}/$1.${filetype}"  "./apps/$app/lib/common/app${filepath}${category}/$1.${filetype}"
    else
      echo "${red} ERROR: $1.${filetype} mixin missing ${reset}"
    fi
  }

  # copy common services
  copyServices () {
    filetype=js
    filepath=/services

    if [[ -e "./apps/common/app${filepath}${category}/$1.${filetype}" ]]; then
      mkdir "./apps/$app/lib/common/app${filepath}" 2> /dev/null
      mkdir "./apps/$app/lib/common/app${filepath}${category}" 2> /dev/null
      touch "./apps/$app/lib/common/app${filepath}${category}/$1.${filetype}"
      cp "./apps/common/app${filepath}${category}/$1.${filetype}"  "./apps/$app/lib/common/app${filepath}${category}/$1.${filetype}"
    else
      echo "${red} ERROR: $1.${filetype} service missing ${reset}"
    fi
  }

  # copy common helpers
  copyHelpers () {
    filetype=js
    filepath=/helpers

    if [[ -e "./apps/common/app${filepath}${category}/$1.${filetype}" ]]; then
      mkdir "./apps/$app/lib/common/app${filepath}" 2> /dev/null
      mkdir "./apps/$app/lib/common/app${filepath}${category}" 2> /dev/null
      touch "./apps/$app/lib/common/app${filepath}${category}/$1.${filetype}"
      cp "./apps/common/app${filepath}${category}/$1.${filetype}"  "./apps/$app/lib/common/app${filepath}${category}/$1.${filetype}"
    else
      echo "${red} ERROR: $1.${filetype} helper missing ${reset}"
    fi
  }

  # copy common adapters
  copyAdapters () {
    filetype=js
    filepath=/adapters

    if [[ -e "./apps/common/app${filepath}${category}/$1.${filetype}" ]]; then
      mkdir "./apps/$app/lib/common/app${filepath}" 2> /dev/null
      mkdir "./apps/$app/lib/common/app${filepath}${category}" 2> /dev/null
      touch "./apps/$app/lib/common/app${filepath}${category}/$1.${filetype}"
      cp "./apps/common/app${filepath}${category}/$1.${filetype}"  "./apps/$app/lib/common/app${filepath}${category}/$1.${filetype}"
    else
      echo "${red} ERROR: $1.${filetype} adapter missing ${reset}"
    fi
  }

  # copy common serializers
  copySerializers () {
    filetype=js
    filepath=/serializers

    if [[ -e "./apps/common/app${filepath}${category}/$1.${filetype}" ]]; then
      mkdir "./apps/$app/lib/common/app${filepath}" 2> /dev/null
      mkdir "./apps/$app/lib/common/app${filepath}${category}" 2> /dev/null
      touch "./apps/$app/lib/common/app${filepath}${category}/$1.${filetype}"
      cp "./apps/common/app${filepath}${category}/$1.${filetype}"  "./apps/$app/lib/common/app${filepath}${category}/$1.${filetype}"
    else
      echo "${red} ERROR: $1.${filetype} serializer missing ${reset}"
    fi
  }

  # copy common styles
  copyStyles () {
    filetype=scss
    filepath=/styles

    if [[ -e "./apps/common/app${filepath}${category}/$1.${filetype}" ]]; then
      mkdir "./apps/$app/lib/common/app${filepath}" 2> /dev/null
      mkdir "./apps/$app/lib/common/app${filepath}${category}" 2> /dev/null
      touch "./apps/$app/lib/common/app${filepath}${category}/$1.${filetype}"
      cp "./apps/common/app${filepath}${category}/$1.${filetype}"  "./apps/$app/lib/common/app${filepath}${category}/$1.${filetype}"
    else
      echo "${red} ERROR: $1.${filetype} styles missing ${reset}"
    fi
  }

  local i
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
      services)
        copyServices $module;;
      helpers)
        copyHelpers $module;;
      adapters)
        copyAdapters $module;;
      serializers)
        copySerializers $module;;
      styles)
        copyStyles $module;;
    	*)
    		echo "${red} ERROR: unknown type of category ${reset}"
    esac
  done
}

# Initialize
initCopy () {
  # Categories commons
  commons=(components mixins models services helpers adapters serializers styles)

  for (( i=0; i<${#commons[@]}; ++i )); do
    # Common modules on root path
    mods=( $(jq ".commons.${commons[$i]}.modules" $filename) )

    # Copy common modules
    if [[ $mods != null ]]; then
      copyModules ${commons[$i]} $filename
    fi

    # does modules categories exists
    iscat=( $(jq ".commons.${commons[$i]}.categories" $filename) )

    # Copy common modules category wise
    if [[ $iscat != null && $iscat != '' ]]; then
      # Common modules categories
      modscat=( $(jq ".commons.${commons[$i]}.categories[]" $filename) )
      for (( j=0; j<${#modscat[@]}; ++j )); do
        # remove trailing quotes from string
        category="${modscat[${j}]%\"}"
        category="${category#\"}"
        copyModules ${commons[$i]} $filename $category
      done
    fi
  done
}

# Initialize Copy
initCopy
