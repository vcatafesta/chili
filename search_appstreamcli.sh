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

# Example of usage, first declare variable, after call function:
# ParuPkgName="gimp" getParuInfoByPkgName
# By default use this functions only generate variables and arrays
# Nothing is printed on screen
# See in the end of file an example of usage like this:
# TestParuInfoByPkgName=true PkgName=firefox ./search_paru.sh

# Function to search for packages using appstreamcli
function searchAppStream {

	# Declare an associative array to hold package search results
	declare -Ag SearchAppStreamInfo

	# Set local variables
	local Identifier Id Name Summary Icon Package Bundle Type

	# Function to search for packages using appstreamcli
	# Run the appstreamcli search command and store its output
	# After add line with --- to separate packages easily
	CommandOutput=$(
		LANGUAGE=C appstreamcli search $PkgName
		echo ---
	)

	# Loop through each Line of the command output and save the value in variable $Line
	while IFS= read -r Line; do
		# --- is the separator between packages
		if [[ "$Line" != "---" ]]; then
			# Use case to check any line
			case "$Line" in
			# If the Line starts with "Identifier:", it's the package identifier
			Identifier:*)
				# Extract the identifier value using parameter expansion, removing "Identifier: " prefix
				Identifier=${Line#Identifier: }
				;;
			Name:*)
				Name=${Line#Name: }
				;;
			Summary:*)
				Summary=${Line#Summary: }
				;;
			Icon:*)
				Icon=${Line#Icon: }
				;;
			Package:*)
				Package=${Line#Package: }
				;;
			Bundle:*)
				Bundle=${Line#Bundle: }
				;;
			esac
		else

			if [[ $Package ]]; then
				Type=native
				Id=$Package
				SearchAppStreamInfo["$Id:Package"]=$Package
			else
				Type=flatpak
				Id=$Identifier
				SearchAppStreamInfo["$Id:Bundle"]=$Bundle
			fi

			if [[ -z $PackageType ]] || [[ $PackageType = $Type ]]; then
				SearchAppStreamInfo["$Id:Identifier"]=$Identifier
				SearchAppStreamInfo["$Id:Name"]=$Name
				SearchAppStreamInfo["$Id:Summary"]=$Summary
				SearchAppStreamInfo["$Id:Icon"]=$Icon

				AppStreamIndex+=("$Id")
			fi

			# Clean all variables to next iteration
			unset Identifier Id Name Summary Icon Package Bundle Type
		fi
	done <<<"$CommandOutput"
}

# Function to display all package information
function showAllAppStreamInfo {
	# Loop through each package identifier to show its information
	for Id in "${AppStreamIndex[@]}"; do
		echo -e "BigStore Identifier:  $Id"
		echo -e "Identifier:           ${SearchAppStreamInfo["$Id:Identifier"]}"
		echo -e "Name:                 ${SearchAppStreamInfo["$Id:Name"]}"
		echo -e "Summary:              ${SearchAppStreamInfo["$Id:Summary"]}"
		echo -e "Icon:                 ${SearchAppStreamInfo["$Id:Icon"]}"
		echo -e "Package:              ${SearchAppStreamInfo["$Id:Package"]}"
		echo -e "Bundle:               ${SearchAppStreamInfo["$Id:Bundle"]}"
		echo -e "------------------------------------------------------------------------------------------------------------------"
	done
}

# Test the function if the TestSearchAppStream variable is set to "true"
if [[ "$TestSearchAppStream" = "true" ]]; then
	searchAppStream
	showAllAppStreamInfo
fi

# TestSearchAppStream=true PackageType=native PkgName=firefox ./search_appstream.sh
