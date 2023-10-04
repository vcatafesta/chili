#!/usr/bin/env bash

#  2023-2023, Bruno Gonçalves <www.biglinux.com.br>
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
#  THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
#  IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
#  OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
#  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
#  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
#  NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
#  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
#  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
#  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
#  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#                 _  __       _   _       _   _           _____           _                    _____           _        _ _          _
#                (_)/ _|     | \ | |     | | (_)         |  __ \         | |                  |_   _|         | |      | | |        | |
# __   _____ _ __ _| |_ _   _|  \| | __ _| |_ ___   _____| |__) |_ _  ___| | ____ _  __ _  ___  | |  _ __  ___| |_ __ _| | | ___  __| |
# \ \ / / _ \ '__| |  _| | | | . ` |/ _` | __| \ \ / / _ \  ___/ _` |/ __| |/ / _` |/ _` |/ _ \ | | | '_ \/ __| __/ _` | | |/ _ \/ _` |
#  \ V /  __/ |  | | | | |_| | |\  | (_| | |_| |\ V /  __/ |  | (_| | (__|   < (_| | (_| |  __/_| |_| | | \__ \ || (_| | | |  __/ (_| |
#   \_/ \___|_|  |_|_|  \__, |_| \_|\__,_|\__|_| \_/ \___|_|   \__,_|\___|_|\_\__,_|\__, |\___|_____|_| |_|___/\__\__,_|_|_|\___|\__,_|
#                        __/ |                                                       __/ |
#                       |___/                                                       |___/
#
# Example of usage, first declare variable, after call function:
# nativePackage="gimp" verifyNativePackageInstalled
# If installed, AppstreamPackageInstalled return value is true
function verifyNativePackageInstalled {
	if pacman -Qq $nativePackage 2>&-; then
		NativePackageInstalled=true
	else
		NativePackageInstalled=false
	fi
}

# Another example of possible commands to filter installed:
# PacmanInstalledList="$(LANGUAGE=C pacman -Qq)"
# Show only name os packages in $CommandOutput
# CommandOutputOnlyPackages="$(echo "$CommandOutput" | sed -E 's/^[[:graph:]]*\/(.*) .*/\1/g;s| .*||g')"
# echo "$CommandOutputOnlyPackages" | grep -Fxf - <(echo "$PacmanInstalledList")
# echo "$PacmanInstalledList" | sed -E 's/^(.*)/\/\1 /g' | grep -A1 -Ff - <(echo "$CommandOutput") | grep -v '^--'
# echo "$CommandOutputOnlyPackages"
# PacmanInstalledList=${PacmanInstalledList//$'\n'/ }
