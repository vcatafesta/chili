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

# Import functions
# To verify if package is installed
source verify_pkg_installed.sh

#             _                            _                            _____        __      ____        _____    _
#            | |     /\                   | |                          |_   _|      / _|    |  _ \      |_   _|  | |
#   __ _  ___| |_   /  \   _ __  _ __  ___| |_ _ __ ___  __ _ _ __ ___   | |  _ __ | |_ ___ | |_) |_   _  | |  __| |
#  / _` |/ _ \ __| / /\ \ | '_ \| '_ \/ __| __| '__/ _ \/ _` | '_ ` _ \  | | | '_ \|  _/ _ \|  _ <| | | | | | / _` |
# | (_| |  __/ |_ / ____ \| |_) | |_) \__ \ |_| | |  __/ (_| | | | | | |_| |_| | | | || (_) | |_) | |_| |_| || (_| |
#  \__, |\___|\__/_/    \_\ .__/| .__/|___/\__|_|  \___|\__,_|_| |_| |_|_____|_| |_|_| \___/|____/ \__, |_____\__,_|
#   __/ |                 | |   | |                                                                 __/ |
#  |___/                  |_|   |_|                                                                |___/

# Example of usage, first declare variable, after call function:
# AppId="org.gimp.GIMP" PackageType="flatpak" getAppstreamInfo
# AppId="org.gimp.GIMP" PackageType="native" getAppstreamInfo
# By default use this functions only generate variables and arrays
# Nothing is printed on screen
# See in the end of file an example of usage like this:
# TestAppstreamInfoById=true PackageType="native" AppId="org.gimp.GIMP" ./read_appstream.sh

function getAppstreamInfoById {
	# Run the appstreamcli command and capture its output
	CommandOutput=$(LANGUAGE=C appstreamcli get --details "$AppId")

	# Read the output line by line
	# Filter and save the values in variables
	# When a line starts with a space, it is a continuation of the previous line
	# When a line starts with "---", it is the end of the output
	# When a line starts with a letter, it is a new key
	while IFS= read -r line; do

		# After Provided Items, remove the first two spaces to get the correct value
		if [[ "$AfterProvidedItems" = "true" && "${line:0:2}" = "  " ]]; then
			line=${line:2}
		fi

		# Verify if first character of line is a letter
		if [[ "${line:0:1}" = [a-zA-Z] ]]; then
			unset NextLineInVariable

			# Variables
			case $line in
			"Identifier:"*)
				# if line starts with Identifier, get the value after ":"
				# and save in variable AppstreamID
				# same for all variables below
				AppstreamID=${line#*:}
				;;
			"Internal ID:"*)
				AppstreamInternalID=${line#*:}
				;;
			"Name:"*)
				AppstreamName=${line#*:}
				;;
			"Summary:"*)
				AppstreamSummary=${line#*:}
				;;
			"Bundle:"*)
				AppstreamBundle=${line#*:}
				# Verify if Bundle is flatpak
				# If yes, set AppstreamPackageType to flatpak
				# If not, set AppstreamPackageType to native
				if [[ "$AppstreamBundle" = " flatpak:"* ]]; then
					AppstreamPackageType=flatpak
				else
					AppstreamPackageType=native
				fi
				;;
			"Package:"*)
				AppstreamPackage=${line#*:}
				;;
			"Homepage:"*)
				AppstreamHomepage=${line#*:}
				;;
			"Icon:"*)
				AppstreamIcon=${line#*:}
				;;
			"Default Screenshot URL:"*)
				AppstreamDefaultScreenshot=${line#*:}
				;;
			"Developer:"*)
				AppstreamDeveloper=${line#*:}
				;;
			"Provided Items:"*)
				AfterProvidedItems=true
				;;
			"License:"*)
				AppstreamLicense=${line#*:}
				;;
			"Binaries:"*)
				AppstreamBinaries=${line#*:}
				;;
			"Component:"*)
				AppstreamComponent=${line#*:}
				;;
			"Description:"*)
				# The variable NextLineInVariable is used
				# To call the next line in the array
				# This is used alter elif in another case
				# To read multi line variables
				# Aame for arrays below
				NextLineInVariable=AppstreamDescription
				;;
			"Categories:"*)
				NextLineInVariable=AppstreamCategories
				;;
			"Media types:"*)
				NextLineInVariable=AppstreamMediaTypes
				;;
			esac

		# Multi Line variables and arrays
		elif [[ "${line:0:2}" = "  " ]]; then
			case $NextLineInVariable in
			"AppstreamDescription")
				AppstreamDescription+=$line
				;;
			"AppstreamCategories")
				AppstreamCategories+=("${line#*- }")
				;;
			"AppstreamMediaTypes")
				AppstreamMediaTypes+=("${line#*- }")
				;;
			esac

		# If have --- have a next option to install with same id, but from another package type
		elif [[ "${line:0:1}" = "-" && "$AppstreamPackageType" = "$PackageType" ]]; then
			break
		elif [[ "${line:0:1}" = "-" && "$AppstreamPackageType" != "$PackageType" ]]; then
			# unset all variables and arrays to read next package type
			unset AppstreamID AppstreamInternalID AppstreamName AppstreamSummary AppstreamBundle \
				AppstreamPackageType AppstreamHomepage AppstreamIcon AppstreamDeveloper AppstreamDescription \
				AppstreamLicense AppstreamCategories AppstreamMediaTypes AppstreamDefaultScreenshot \
				AppstreamBinaries AppstreamComponent NextLineInVariable AfterProvidedItems
		fi

	done <<<$CommandOutput
}

#  ______                           _
# |  ____|                         | |
# | |__  __  ____ _ _ __ ___  _ __ | | ___  ___
# |  __| \ \/ / _` | '_ ` _ \| '_ \| |/ _ \/ __|
# | |____ >  < (_| | | | | | | |_) | |  __/\__ \
# |______/_/\_\__,_|_| |_| |_| .__/|_|\___||___/
#                            | |
#                            |_|

# By default use this functions only generate variables and arrays
# Nothing is printed on screen, on example below all variables and arrays are printed

# To run test use this command
# Change AppId variable to test another package
# Pass PackageType variable to test native or flatpak package
# TestAppstreamInfoById=true PackageType="native" AppId="org.gimp.GIMP" ./read_appstream.sh

if [[ "$TestAppstreamInfoById" = "true" ]]; then
	# Call function to get appstream info by id
	# Using AppId variable and PackageType variable
	# Passed in command line
	getAppstreamInfoById

	# If Package type is native, test if installed
	if [[ "$AppstreamPackageType" = "native" ]]; then
		nativePackage="$AppstreamPackage" verifyNativePackageInstalled
		echo "NativePackageInstalled:      $NativePackageInstalled"
	fi

	echo "AppstreamID:                $AppstreamID"
	echo "AppstreamInternalID:        $AppstreamInternalID"
	echo "AppstreamName:              $AppstreamName"
	echo "AppstreamSummary:           $AppstreamSummary"
	echo "AppstreamBundle:            $AppstreamBundle"
	echo "AppstreamPackage:           $AppstreamPackage"
	echo "AppstreamPackageType:       $AppstreamPackageType"
	echo "AppstreamHomepage:          $AppstreamHomepage"
	echo "AppstreamIcon:              $AppstreamIcon"
	echo "AppstreamDefaultScreenshot: $AppstreamDefaultScreenshot"
	echo "AppstreamDeveloper:         $AppstreamDeveloper"
	echo "AppstreamLicense:           $AppstreamLicense"
	echo "AppstreamBinaries:          $AppstreamBinaries"
	echo "AppstreamComponent:         $AppstreamComponent"
	echo "AppstreamDescription:       $AppstreamDescription"
	echo "AppstreamCategories:        ${AppstreamCategories[@]}"
	echo "AppstreamMediaTypes:        ${AppstreamMediaTypes[@]}"
fi
