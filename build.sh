#!/bin/bash

PLUGIN_NAME="spawn-point-manager"

cd scripting
spcomp $PLUGIN_NAME.sp -i include -o ../plugins/$PLUGIN_NAME.smx
