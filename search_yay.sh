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

#                          _ __     __         _____
#                         | |\ \   / /        |  __ \
#  ___  ___  __ _ _ __ ___| |_\ \_/ /_ _ _   _| |__) |___ _ __   ___
# / __|/ _ \/ _` | '__/ __| '_ \   / _` | | | |  _  // _ \ '_ \ / _ \
# \__ \  __/ (_| | | | (__| | | | | (_| | |_| | | \ \  __/ |_) | (_) |
# |___/\___|\__,_|_|  \___|_| |_|_|\__,_|\__, |_|  \_\___| .__/ \___/
#                                         __/ |          | |
#                                        |___/           |_|

# Example of usage, first declare variable, after call function:
# YayPkgName="gimp" getYayInfoByPkgName
# By default use this functions only generate variables and arrays
# Nothing is printed on screen
# See in the end of file an example of usage like this:
# TestYayInfoByPkgName=true PkgName=firefox ./search_yay.sh

# Declare an associative array to hold package search results
declare -A SearchYay

# Function to search for packages using Yay
function searchYayRepo {
	# Run the yay search command and store its output
	CommandOutput=$(LANGUAGE=C yay --repo --bottomup -Ss $PkgName)
	# Initialize an empty variable for the package name
	PackageName=""

	# Loop through each line of the command output
	while IFS= read -r line; do
		# Check if the line starts with an alphabet (usually means it's a package name)
		if [[ "${line:0:1}" = [a-zA-Z] ]]; then
			# Example of line:
			# extra/firefox 117.0-1 (62.3 MiB 220.6 MiB) (Installed)

			# Extract extra/firefox
			Key="${line%% *}"

			# Add to SearchYayIndex array, to faster way to search
			# Store the repository name for the package in example: extra
			SearchYayIndex+=("$Key")
			SearchYay["$Key:Repository"]="${line%/*}"

			# Store the repository version of the package
			RepositoryVersionToClean="${line#* }"
			RepositoryVersion="${RepositoryVersionToClean%% *}"
			SearchYay["$Key:RepositoryVersion"]="$RepositoryVersion"

			# Store the size of the download and the installed package
			SizeToClean="${RepositoryVersionToClean#*(}"
			SizeToClean="${SizeToClean%%)*}"
			SearchYay["$Key:Size:Download"]="${SizeToClean%%B*}B"
			SearchYay["$Key:Size:Installed"]="${SizeToClean#*B }"

			# Check and store if the package is installed or not, and its installed version if applicable
			if [[ "$line" =~ " (Installed)" ]]; then
				SearchYay["$Key:Installed"]='true'
				SearchYay["$Key:InstalledVersion"]="$RepositoryVersion"
			elif [[ "$line" =~ " (Installed:" ]]; then
				SearchYay["$Key:Installed"]='upgradeable'
				InstalledVersionToClean=${RepositoryVersionToClean##* }
				SearchYay["$Key:InstalledVersion"]="${InstalledVersionToClean/)/}"
			else
				SearchYay["$Key:Installed"]='false'
				SearchYay["$Key:InstalledVersion"]=''
			fi

			# Store any extra information about the package if present
			if [[ "$line" =~ \] ]]; then
				SearchYay["$Key:ExtraInfo"]="${line%%]*}"
				SearchYay["$Key:ExtraInfo"]="${SearchYay[$Key]##*\[}"
			else
				SearchYay["$Key:ExtraInfo"]=''
			fi

		else
			# Store the description of the package
			SearchYay["$Key:Description"]="${line#    }"
		fi
	done <<<"$CommandOutput"
}

# Function to display all package information
function showAllYayInfo {
	# Loop through each package name to show its information
	for pkgName in "${SearchYayIndex[@]}"; do
		echo -e "Repository:           ${SearchYay["$pkgName:Repository"]}"
		echo -e "Package Name:         $pkgName"
		echo -e "Repository Version:   ${SearchYay["$pkgName:RepositoryVersion"]}"
		echo -e "Installed:            ${SearchYay["$pkgName:Installed"]}"
		echo -e "Installed Version:    ${SearchYay["$pkgName:InstalledVersion"]}"
		echo -e "Size Download:        ${SearchYay["$pkgName:Size:Download"]}"
		echo -e "Size Installed:       ${SearchYay["$pkgName:Size:Installed"]}"
		echo -e "Extra Info:           ${SearchYay["$pkgName:ExtraInfo"]}"
		echo -e "Description:          ${SearchYay["$pkgName:Description"]}"
		echo -e "------------------------------------------------------------------------------------------------------------------"
	done
}

# Test the function if the TestSearchYay variable is set to "true"
if [[ "$TestSearchYay" = "true" ]]; then
	searchYayRepo
	showAllYayInfo
fi

# TestSearchYay=true PkgName=firefox ./search_yay.sh
