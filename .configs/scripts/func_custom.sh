#!/bin/bash

patch_of_sync () {
	sed -i 's/repo init --depth=1 -u $MIN_MANIFEST -b $TWRP_BRANCH;/repo init --depth=1 --no-repo-verify -u $MIN_MANIFEST -b $TWRP_BRANCH -g default,-mips,-darwin,-notdefault;/g' ./orangefox_sync.sh
	sed -i 's/repo sync;/repo sync -c --force-sync --optimized-fetch --no-tags --no-clone-bundle --prune -j$(nproc --all);/g' ./orangefox_sync.sh
}

patch_of_update () {
	sed -i 's/cd $MANIFEST_DIR && repo sync;/repo sync -c --force-sync --optimized-fetch --no-tags --no-clone-bundle --prune -j$(nproc --all);/g' ./update_fox.sh
}

repo_init_custom () {
	git clone --depth 1 https://gitlab.com/OrangeFox/sync.git ${ROMNAME}_sync
	cd ${ROMNAME}_sync

	patch_of_sync
}

repo_sync_custom () {
	local is_init="$1"
	local is_update="$2"
	if [ "$is_init" = true ];
	then
		./orangefox_sync.sh --branch $BRANCH --path $ROMBASE
	elif [ "$is_update" = true ];
	then
		patch_of_sync
		
		patch_of_update
		
		./update_fox.sh --path $ROMBASE
	fi
	is_init=
	is_update=
}

update_repo_manifest () {
	# Update sync (and sync again failed sync)
	cd $ROMBASE/${ROMNAME}_sync
	git reset --hard
	git clean -f
	git pull 2>/dev/null
	if [ $? != 0 ];
	then
		if [ "$FORCEINIT" = true ];
		then
			cd $ROMBASE
			echo "git failed to update ${ROMNAME}_sync. Do git clone again..."
			rm -Rf ${ROMNAME}_sync
		
			git clone --depth 1 https://gitlab.com/OrangeFox/sync.git ${ROMNAME}_sync
			cd ${ROMNAME}_sync
		fi
	fi
}

build_custom () {
	lunch $LUNCHCOMMAND
	
	buildtarget="adbd recoveryimage"
	buildout="recovery.img;$ROMNAME*$DEVICE.zip"
	outdir="$OUTDIR"
	build_and_copy "$buildtarget" "$buildout" "$outdir"
	
	buildtarget=
	buildout=
	outdir=
}
