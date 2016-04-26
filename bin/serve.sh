#!/bin/bash

pushd apps/$1
ember serve
popd
