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
  commons=(components mixins)

  # Common components on root path
  components=( $(jq ".commons.components.modules" $filename) )

  # Copy common components
  if [[ $components != null ]]; then
    copyModules components $filename
  fi

  # does components categories exists
  iscomponentscat=( $(jq ".commons.components.categories" $filename) )

  # Copy common components category wise
  if [[ $iscomponentscat != null && $iscomponentscat != '' ]]; then
    # Common components categories
    componentscat=( $(jq ".commons.components.categories[]" $filename) )
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

  # does mixins categories exists
  ismixinscat=( $(jq ".commons.mixins.categories" $filename) )

  # Copy common mixins category wise
  if [[ $ismixinscat != '' && $ismixinscat != null ]]; then
    # Common mixins categories
    mixinscat=( $(jq ".commons.mixins.categories[]" $filename) )
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

  # does models categories exists
  ismodelscat=( $(jq ".commons.models.categories" $filename) )

  # Copy common models category wise
  if [[ $ismodelscat != null && $ismodelscat != '' ]]; then
    # Common models categories
    modelscat=( $(jq ".commons.models.categories[]" $filename) )
    for (( i=0; i<${#modelscat[@]}; ++i )); do
      # remove trailing quotes from string
      category="${modelscat[${i}]%\"}"
      category="${category#\"}"
      copyModules models $filename $category
    done
  fi

  # Common services on root path
  services=( $(jq ".commons.services.modules" $filename) )

  # Copy services mixins
  if [[ $services != null && $services != '' ]]; then
    copyModules services $filename
  fi

  # does services categories exists
  isservicescat=( $(jq ".commons.services.categories" $filename) )

  # Copy common services category wise
  if [[ $isservicescat != null && $isservicescat != '' ]]; then
    # Common services categories
    servicescat=( $(jq ".commons.services.categories[]" $filename) )

    for (( i=0; i<${#servicescat[@]}; ++i )); do
      # remove trailing quotes from string
      category="${servicescat[${i}]%\"}"
      category="${category#\"}"
      copyModules services $filename $category
    done
  fi

  # Common helpers on root path
  helpers=( $(jq ".commons.helpers.modules" $filename) )

  # Copy helpers
  if [[ $helpers != null && $helpers != '' ]]; then
    copyModules helpers $filename
  fi

  # does helpers categories exists
  ishelperscat=( $(jq ".commons.helpers.categories" $filename) )

  # Copy common helpers category wise
  if [[ $ishelperscat != null && $ishelperscat != '' ]]; then
    # Common helpers categories
    helperscat=( $(jq ".commons.helpers.categories[]" $filename) )

    for (( i=0; i<${#helperscat[@]}; ++i )); do
      # remove trailing quotes from string
      category="${helperscat[${i}]%\"}"
      category="${category#\"}"
      copyModules helpers $filename $category
    done
  fi

  # Common adapters on root path
  adapters=( $(jq ".commons.adapters.modules" $filename) )

  # Copy adapters
  if [[ $adapters != null && $adapters != '' ]]; then
    copyModules adapters $filename
  fi

  # does adapters categories exists
  isadapterscat=( $(jq ".commons.adapters.categories" $filename) )

  # Copy common adapters category wise
  if [[ $isadapterscat != null && $isadapterscat != '' ]]; then
    # Common adapters categories
    adapterscat=( $(jq ".commons.adapters.categories[]" $filename) )

    for (( i=0; i<${#adapterscat[@]}; ++i )); do
      # remove trailing quotes from string
      category="${adapterscat[${i}]%\"}"
      category="${category#\"}"
      copyModules adapters $filename $category
    done
  fi

  # Common serializers on root path
  serializers=( $(jq ".commons.serializers.modules" $filename) )

  # Copy serializers
  if [[ $serializers != null && $serializers != '' ]]; then
    copyModules serializers $filename
  fi

  # does serializers categories exists
  isserializerscat=( $(jq ".commons.serializers.categories" $filename) )

  # Copy common serializers category wise
  if [[ $isserializerscat != null && $isserializerscat != '' ]]; then
    # Common serializers categories
    serializerscat=( $(jq ".commons.serializers.categories[]" $filename) )

    for (( i=0; i<${#serializerscat[@]}; ++i )); do
      # remove trailing quotes from string
      category="${serializerscat[${i}]%\"}"
      category="${category#\"}"
      copyModules serializers $filename $category
    done
  fi

  # Common styles on root path
  styles=( $(jq ".commons.styles.modules" $filename) )

  # Copy styles
  if [[ $styles != null && $styles != '' ]]; then
    copyModules styles $filename
  fi

  # does styles categories exists
  isstylescat=( $(jq ".commons.styles.categories" $filename) )

  # Copy common styles category wise
  if [[ $isstylescat != null && $isstylescat != '' ]]; then
    # Common styles categories
    stylescat=( $(jq ".commons.styles.categories[]" $filename) )

    for (( i=0; i<${#stylescat[@]}; ++i )); do
      # remove trailing quotes from string
      category="${stylescat[${i}]%\"}"
      category="${category#\"}"
      copyModules styles $filename $category
    done
  fi

}

# Initialize Copy
initCopy
