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

# Declare a simple array to hold package names
# declare -a SearchYayIndex

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

			IFS=$'/ \()' read -r Repository PackageName RepositoryVersion DownloadSize DownloadUnit InstalledSize InstalledUnit ExtraInfo Installed InstalledVersion <<<$line

			Key="$Repository/$PackageName"

			SearchYayIndex+=($Key)
			SearchYay["$Key:Repository"]=$Repository
			SearchYay["$Key:PackageName"]=$PackageName
			SearchYay["$Key:RepositoryVersion"]=$RepositoryVersion
			SearchYay["$Key:DownloadSize"]="$DownloadSize $DownloadUnit"
			SearchYay["$Key:InstalledSize"]="$InstalledSize $InstalledUnit"
			SearchYay["$Key:ExtraInfo"]=$ExtraInfo
			SearchYay["$Key:Installed"]=$Installed
			SearchYay["$Key:InstalledVersion"]=$InstalledVersion

		else
			# Store the description of the package
			SearchYay["$Key:Description"]="${line#    }"
		fi
	done <<<"$CommandOutput"
}

# Function to display all package information
function showAllYay {
	# Loop through each package name to show its information
	for Key in "${SearchYayIndex[@]}"; do
		echo -e "Repository:           ${SearchYay["$Key:Repository"]}"
		echo -e "PackageName:          ${SearchYay["$Key:PackageName"]}"
		echo -e "RepositoryVersion:    ${SearchYay["$Key:RepositoryVersion"]}"
		echo -e "DownloadSize:         ${SearchYay["$Key:DownloadSize"]}"
		echo -e "InstalledSize:        ${SearchYay["$Key:InstalledSize"]}"
		echo -e "Installed:            ${SearchYay["$Key:Installed"]}"
		echo -e "ExtraInfo:            ${SearchYay["$Key:ExtraInfo"]}"
		echo -e "Installed Version:    ${SearchYay["$Key:InstalledVersion"]}"
		echo -e "Description:          ${SearchYay["$Key:Description"]}"
		echo -e "------------------------------------------------------------------------------------------------------------------"
	done
}

# Test the function if the TestSearchYay variable is set to "true"
if [[ "$TestSearchYay" = "true" ]]; then
	searchYayRepo
	showAllYay
fi

# TestSearchYay=true PkgName=firefox ./search_yay.sh
