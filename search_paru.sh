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

#                          _     _____                 _____
#                         | |   |  __ \               |  __ \
#  ___  ___  __ _ _ __ ___| |__ | |__) |_ _ _ __ _   _| |__) |___ _ __   ___
# / __|/ _ \/ _` | '__/ __| '_ \|  ___/ _` | '__| | | |  _  // _ \ '_ \ / _ \
# \__ \  __/ (_| | | | (__| | | | |  | (_| | |  | |_| | | \ \  __/ |_) | (_) |
# |___/\___|\__,_|_|  \___|_| |_|_|   \__,_|_|   \__,_|_|  \_\___| .__/ \___/
#                                                                | |
#                                                                |_|

# Example of usage, first declare variable, after call function:
# ParuPkgName="gimp" getParuInfoByPkgName
# By default use this functions only generate variables and arrays
# Nothing is printed on screen
# See in the end of file an example of usage like this:
# TestParuInfoByPkgName=true PkgName=firefox ./search_paru.sh

# Declare an associative array to hold package search results
declare -A SearchParuInfo

# Declare a simple array to hold package names
declare -a ParuPackageNames

# Function to search for packages using Paru
function searchParuRepo {
	# Run the paru search command and store its output
	CommandOutput=$(LANGUAGE=C paru --repo --bottomup -Ss $PkgName)
	# Initialize an empty variable for the package name
	PackageName=""

	# Loop through each line of the command output
	while IFS= read -r line; do
		# Check if the line starts with an alphabet (usually means it's a package name)
		if [[ "${line:0:1}" = [a-zA-Z] ]]; then
			# Extract the package name from the line
			PackageName="${line#*/}"
			PackageName="${PackageName%% *}"
			# Add the package name to the ParuPackageNames array
			ParuPackageNames+=("$PackageName")

			# Store the repository name for the package
			key="${PackageName}:Repository"
			SearchParuInfo["$key"]="${line%/*}"

			# Store the repository version of the package
			key="${PackageName}:RepositoryVersion"
			RepositoryVersionToClean="${line#* }"
			RepositoryVersion="${RepositoryVersionToClean%% *}"
			SearchParuInfo["$key"]="$RepositoryVersion"

			# Store the size of the download and the installed package
			key="${PackageName}:Size"
			SizeToClean="${RepositoryVersionToClean#*[}"
			SizeToClean="${SizeToClean%%]*}"
			SearchParuInfo["$key:Download"]="${SizeToClean%% *}"
			SearchParuInfo["$key:Installed"]="${SizeToClean##* }"

			# Check and store if the package is installed or not, and its installed version if applicable
			key="${PackageName}:Installed"
			if [[ "$line" =~ " [Installed]" ]]; then
				SearchParuInfo["$key"]='true'
				SearchParuInfo["${PackageName}:InstalledVersion"]="$RepositoryVersion"
			elif [[ "$line" =~ " [Installed:" ]]; then
				SearchParuInfo["$key"]='upgradeable'
				InstalledVersionToClean=${RepositoryVersionToClean##* }
				SearchParuInfo["${PackageName}:InstalledVersion"]="${InstalledVersionToClean/]/}"
			else
				SearchParuInfo["$key"]='false'
				SearchParuInfo["${PackageName}:InstalledVersion"]=''
			fi

			# Store any extra information about the package if present
			key="${PackageName}:ExtraInfo"
			if [[ "$line" =~ \) ]]; then
				SearchParuInfo["$key"]="${line%%)*}"
				SearchParuInfo["$key"]="${SearchParuInfo[$key]##*\(}"
			else
				SearchParuInfo["$key"]=''
			fi

		else
			# Store the description of the package
			key="${PackageName}:Description"
			SearchParuInfo["$key"]="${line#    }"
		fi
	done <<<"$CommandOutput"
}

# Function to display all package information
function showAllParuInfo {
	# Loop through each package name to show its information
	for pkgName in "${ParuPackageNames[@]}"; do
		echo -e "Repository:           ${SearchParuInfo["$pkgName:Repository"]}"
		echo -e "Package Name:         $pkgName"
		echo -e "Repository Version:   ${SearchParuInfo["$pkgName:RepositoryVersion"]}"
		echo -e "Installed:            ${SearchParuInfo["$pkgName:Installed"]}"
		echo -e "Installed Version:    ${SearchParuInfo["$pkgName:InstalledVersion"]}"
		echo -e "Size Download:        ${SearchParuInfo["$pkgName:Size:Download"]}"
		echo -e "Size Installed:       ${SearchParuInfo["$pkgName:Size:Installed"]}"
		echo -e "Extra Info:           ${SearchParuInfo["$pkgName:ExtraInfo"]}"
		echo -e "Description:          ${SearchParuInfo["$pkgName:Description"]}"
		echo -e "------------------------------------------------------------------------------------------------------------------"
	done
}

# Test the function if the TestSearchParu variable is set to "true"
if [[ "$TestSearchParu" = "true" ]]; then
	searchParuRepo
	showAllParuInfo
fi

TestSearchParu=true PkgName=firefox ./search_paru.sh
