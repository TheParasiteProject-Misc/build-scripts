#!/bin/bash

# arguments
if [ ! -z "$1" ];
then
	CWD="$1"
fi

# get working directory
if [ -z $CWD ];
then
	echo "No working directory specified"
 	exit 1
fi

source $CWD/options.txt

source $FUNCS
source $FUNCS_CUSTOM

dogitreset=true
patchdir=$PATCHSDIR
apply_patch $dogitreset $patchdir

dogitreset=false
patchdir=$ADDITIONAL_PATCHSDIR
apply_patch $dogitreset $patchdir

dogitreset=
patchdir=

cd $CWD
