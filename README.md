# Build-Scripts

Sync, build script for OrangeFox recovery project.<br>
Only supports Ubuntu 23.04 and up.<br>
These are not fancy scripts. Just for personal use :P

## Desc

* Edit options.txt to match your own needs.
* Although there's args exist, you can hardcoded those options on `options.txt`<br>
  (e.g. Setting `VERBOSE=true` on `options.txt` will have same effect with arg `-v`)

## sync.sh

* Sync rom sources.
* Automatically install all dependancies.
* If there're any manifests files found under `.configs/additional-manifests` dir,<br>
  those files will be copied under `.repo/local_manifests`.
* If there're any manifests files found under `.configs/device-manifests` dir,<br>
  those files will be copied under `.repo/local_manifests`.
  Make sure `device-manifests` and `additional-manifests` have not same file name or contents.
* If there're no vars set, will use default values.
* If source dir already exists, it will update repos.

### Vars

* ROMNAME: Name of this project. This var will use as folder name, main org name of sources.
* BRANCH: Target branch to sync.
* BUILDBASE: Parent directory of rom sources storage. Default to `$HOME`.<br>
  Will synced under ```$BUILDBASE/android/$ROMNAME```
* FORCEINIT: Enforce initialization when updating manifest fails.<br>
  Default to `true`.

### Args

* `--verbose` or `-v`: Verbose mode. Show all excuted commands while sync.
* `--clean-sync` or `-cs`: Clean sync mode. Remove entire source directory and sync from scratch.

## patch.sh

* Apply patches to rom sources.
* If there're any patch files found under `.configs/additional-patches` dir,<br>
  those patches will be applied to correspond repos.<br>
  You need to follow the naming style. (build/soong -> build+soong)

### Vars

* ROMNAME: Name of this project. This var will use as folder name, main org name of sources.
* BUILDBASE: Parent directory of rom sources storage. Default to `$HOME`.<br>
  Patches will applied to the directories under ```$BUILDBASE/android/$ROMNAME```

## build.sh

* Build rom or boot images and move those under current directory where this script located.
* If there're no vars set, will use default values.
* CCache and ThinLTO Cache are enabled by default.

### Vars

* ROMNAME: Name of this project. This var will use as folder name, main org name of sources.
* BUILDTYPE: Build type of rom to build. Default to `user`.<br>
* DEVICE: Target device of rom to build. Default to `common`.<br>
* LUNCHCOMMAND: Lunch command of rom to build. Default to `twrp_$DEVICE-$BUILDTYPE`.<br>
* BUILDBASE: Parent directory of where rom sources is located. Default to `$HOME`.<br>
  Should be same as `sync.sh`'s `$BUILDBASE`.

### Args

* `--verbose` or `-v`: Verbose mode. Show all excuted commands while sync.
* `--ccache` or `-ec`: Enable CCache.
* `--thinlto-cache` or `-tc`: Enable ThinLTO Cache.
* `--clean` or `-c`: Clean mode. Build rom from scratch instead of dirty build.
* `--aclean` or `-ac`: Clean-up All Cache.
* `--shutdown` or `-s`: Shutdown system after build complete.

## Credits
[switchroot-script-builder](https://github.com/makinbacon21/switchroot-script-builder)
