#!/bin/bash

ARG_CCACHE_SUPPORTED=true
ARG_TCACHE_SUPPORTED=true
ARG_CLEAN_SUPPORTED=true
ARG_ACLEAN_SUPPORTED=true
#ARG_BOOTIMG_SUPPORTED=true

# get current working directory
CWD=$(pwd)

source $CWD/options.txt

# Create output directory to store rom zip, img
mkdir -p $OUTDIR

source $FUNCS
source $FUNCS_CUSTOM

# arguments
get_arguments "$@"

if [ ! -d $ROMBASE ];
then
	echo "There's no $ROMBASE directory found! Sync it first!"
	exit 1
fi

# reset back to $ROMNAME directory
cd $ROMBASE

# Clean up cache directory.
clean_all_cache
clean_error_logs

source build/envsetup.sh

# CCache
set_ccache

# Go Cache
custom_go_cache_dir

# ThinLTO Cache
set_thinlto_cache

# Global ThinLTO
set_global_thinlto

# Clean Build
clean_build

# check rom type and assign gapps type and rom type
build_custom

shutdown_system
