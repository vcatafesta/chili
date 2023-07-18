#!/bin/bash
PRG='mz'
file='p/python-zope-component-4.6.2-1-any.chi.zst'
file='p/python-zope-component-4.6.2-1.mz'
file='python-zope-component-4.6.2-1.mz'
file='linux-firmware-20190514-1.mz'
file='python-zope-component-4.6.2-1-any.mz'

#type 1
pkg_folder_dir=${file%/*}
pkg_fullname=${file##*/}
file=$pkg_fullname
pkg_arch=${file%%.${PRG}}
pkg_base_version="${file%%.${PRG}}${pkg_arch%-any*}"
pkg_base_version=${pkg_base_version%-x86_64*}
pkg_build=${pkg_base_version##*-}

pkg_version="${file%-*}"
pkg_version="${pkg_version%-*}"
pkg_base="${pkg_version%-*}"
pkg_version="${pkg_version##*-}-$pkg_build"

echo "pkg_folder_dir   : $pkg_folder_dir"
echo "pkg_fullname     : $pkg_fullname"
echo "pkg_arch         : $pkg_arch"
echo "pkg_base_version : $pkg_base_version"
echo "pkg_build        : $pkg_build"
echo "pkg_version      : $pkg_version"
echo "pkg_base         : $pkg_base"

