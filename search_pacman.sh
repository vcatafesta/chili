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

#             _   _____                                 _____        __      ____        _____  _         _   _
#            | | |  __ \                               |_   _|      / _|    |  _ \      |  __ \| |       | \ | |
#   __ _  ___| |_| |__) |_ _  ___ _ __ ___   __ _ _ __   | |  _ __ | |_ ___ | |_) |_   _| |__) | | ____ _|  \| | __ _ _ __ ___   ___
#  / _` |/ _ \ __|  ___/ _` |/ __| '_ ` _ \ / _` | '_ \  | | | '_ \|  _/ _ \|  _ <| | | |  ___/| |/ / _` | . ` |/ _` | '_ ` _ \ / _ \
# | (_| |  __/ |_| |  | (_| | (__| | | | | | (_| | | | |_| |_| | | | || (_) | |_) | |_| | |    |   < (_| | |\  | (_| | | | | | |  __/
#  \__, |\___|\__|_|   \__,_|\___|_| |_| |_|\__,_|_| |_|_____|_| |_|_| \___/|____/ \__, |_|    |_|\_\__, |_| \_|\__,_|_| |_| |_|\___|
#   __/ |                                                                           __/ |            __/ |
#  |___/                                                                           |___/            |___/

# Example of usage, first declare variable, after call function:
# PacmanPkgName="gimp" getPacmanInfoByPkgName
# By default use this functions only generate variables and arrays
# Nothing is printed on screen
# See in the end of file an example of usage like this:
# TestPacmanInfoByPkgName=true PkgName=firefox ./read_pacman.sh

# Declare an associative array to hold package search results
declare -A SearchPacmanInfo

# Declare a simple array to hold package names
declare -a PackageNames

# Function to search for packages using Pacman
function searchPacman {
	# Run the pacman search command and store its output
	CommandOutput=$(LANGUAGE=C pacman -Ss $PkgName)
	# Initialize an empty variable for the package name
	PackageName=""

	# Loop through each line of the command output
	while IFS= read -r line; do
		# Check if the line starts with an alphabet (usually means it's a package name)
		if [[ "${line:0:1}" = [a-zA-Z] ]]; then
			# Extract the package name from the line
			PackageName="${line#*/}"
			PackageName="${PackageName%% *}"
			# Add the package name to the PackageNames array
			PackageNames+=("$PackageName")

			# Store the repository name for the package
			key="${PackageName}:Repository"
			SearchPacmanInfo["$key"]="${line%/*}"

			# Store the repository version of the package
			key="${PackageName}:RepositoryVersion"
			RepositoryVersionToClean="${line#* }"
			RepositoryVersion="${RepositoryVersionToClean%% *}"
			SearchPacmanInfo["$key"]="$RepositoryVersion"

			# Check and store if the package is installed or not, and its installed version if applicable
			key="${PackageName}:Installed"
			if [[ "$line" =~ " [installed]" ]]; then
				SearchPacmanInfo["$key"]='true'
				SearchPacmanInfo["${PackageName}:InstalledVersion"]="$RepositoryVersion"
			elif [[ "$line" =~ " [installed:" ]]; then
				SearchPacmanInfo["$key"]='upgradeable'
				InstalledVersionToClean=${RepositoryVersionToClean##* }
				SearchPacmanInfo["${PackageName}:InstalledVersion"]="${InstalledVersionToClean/]/}"
			else
				SearchPacmanInfo["$key"]='false'
				SearchPacmanInfo["${PackageName}:InstalledVersion"]=''
			fi

			# Store any extra information about the package if present
			key="${PackageName}:ExtraInfo"
			if [[ "$line" =~ \) ]]; then
				SearchPacmanInfo["$key"]="${line%%)*}"
				SearchPacmanInfo["$key"]="${SearchPacmanInfo[$key]##*\(}"
			else
				SearchPacmanInfo["$key"]=''
			fi

		else
			# Store the description of the package
			key="${PackageName}:Description"
			SearchPacmanInfo["$key"]="${line#    }"
		fi
	done <<<"$CommandOutput"
}

# Function to display all package information
function showAllPackageInfo {
	# Loop through each package name to show its information
	for pkgName in "${PackageNames[@]}"; do
		echo -e "------------------------------------------------------------------------------------------------------------------"
		echo -e "Repository:           ${SearchPacmanInfo["$pkgName:Repository"]}"
		echo -e "Package Name:         $pkgName"
		echo -e "Repository Version:   ${SearchPacmanInfo["$pkgName:RepositoryVersion"]}"
		echo -e "Installed:            ${SearchPacmanInfo["$pkgName:Installed"]}"
		echo -e "Installed Version:    ${SearchPacmanInfo["$pkgName:InstalledVersion"]}" # Added this line
		echo -e "Extra Info:           ${SearchPacmanInfo["$pkgName:ExtraInfo"]}"
		echo -e "Description:          ${SearchPacmanInfo["$pkgName:Description"]}"
	done
}

# Check if the search and display should be triggered (controlled by a variable named "TestSearchPacman")
if [[ "$TestSearchPacman" = "true" ]]; then
	searchPacman
	showAllPackageInfo
fi

# TestSearchPacman=true PkgName=firefox ./search_pacman.sh
