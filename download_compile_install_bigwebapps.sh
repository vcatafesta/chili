#!/usr/bin/env bash
# -*- coding: utf-8 -*-
# shellcheck shell=bash disable=SC1091,SC2039,SC2166
#
#  download_compile_install_bigwebapps.sh
#  Created: 2024/07/08 - 14:35
#  Altered: 2024/07/16 - 10:32
#
#  Copyright (c) 2024-2024, Vilmar Catafesta <vcatafesta@gmail.com>
#  All rights reserved.
#
#  Redistribution and use in source and binary forms, with or without
#  modification, are permitted provided that the following conditions
#  are met:
#  1. Redistributions of source code must retain the above copyright
#     notice, this list of conditions and the following disclaimer.
#  2. Redistributions in binary form must reproduce the above copyright
#     notice, this list of conditions and the following disclaimer in the
#     documentation and/or other materials provided with the distribution.
#
#  THIS SOFTWARE IS PROVIDED BY THE AUTHOR AS IS'' AND ANY EXPRESS OR
#  IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
#  OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
#  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
#  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
#  NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
#  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
#  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
#  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
#  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
##############################################################################
#export LANGUAGE=pt_BR
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=download_compile_install_bigwebapps.sh

#debug
export PS4='[1m[38;5;196mbash[1m[32m[download_compile_install_bigwebapps.sh][35m[15](B[m '
#set -x
set -e
shopt -s extglob

#system
readonly APP="bash"
readonly _VERSION_='1.0.0-20240713 - 11:26'
readonly distro=voidlinux
readonly DEPENDENCIES=(grep)

if mkdir -p /tmp/bigcontrolcenter-base-install; then
	cd /tmp/bigcontrolcenter-base-install || exit 1
	[[ -e PKGBUILD ]] && rm PKGBUILD
	if wget https://raw.githubusercontent.com/vcatafesta/bigcontrolcenter-base/main/pkgbuild/PKGBUILD; then
		sed -i 's|url="https://github.com/biglinux/$pkgname"|url="https://github.com/vcatafesta/$pkgname"|'g PKGBUILD
		makepkg --force --install --clean --cleanbuild --syncdeps --noconfirm || exit 1
	fi
fi

if mkdir -p /tmp/biglinux-webapps-install; then
	cd /tmp/biglinux-webapps-install || exit 1
	[[ -e PKGBUILD ]] && rm PKGBUILD
	if wget https://raw.githubusercontent.com/vcatafesta/biglinux-webapps/main/pkgbuild/PKGBUILD; then
		sed -i 's|url="https://github.com/biglinux/$pkgname"|url="https://github.com/vcatafesta/$pkgname"|'g PKGBUILD
		makepkg --force --install --clean --cleanbuild --syncdeps --noconfirm || exit 1
	fi
fi

if mkdir -p /tmp/biglinux-config-install; then
	cd /tmp/biglinux-config-install || exit 1
	[[ -e PKGBUILD ]] && rm PKGBUILD
	if wget https://raw.githubusercontent.com/vcatafesta/biglinux-config/main/pkgbuild/PKGBUILD; then
		sed -i 's|url="https://github.com/biglinux/$pkgname"|url="https://github.com/vcatafesta/$pkgname"|'g PKGBUILD
		makepkg --force --install --clean --cleanbuild --syncdeps --noconfirm || exit 1
	fi
fi

if mkdir -p /tmp/auto-tweaks-browser-install; then
	cd /tmp/auto-tweaks-browser-install || exit 1
	[[ -e PKGBUILD ]] && rm PKGBUILD
	if wget https://raw.githubusercontent.com/vcatafesta/auto-tweaks-browser/main/pkgbuild/PKGBUILD; then
		sed -i 's|url="https://github.com/biglinux/$pkgname"|url="https://github.com/vcatafesta/$pkgname"|'g PKGBUILD
		makepkg --force --install --clean --cleanbuild --syncdeps --noconfirm || exit 1
	fi
fi
