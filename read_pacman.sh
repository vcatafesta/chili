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

function getPacmanInfoByPkgName {
	# Run the pacman command and capture its output
	CommandOutput=$(LANGUAGE=C pacman -Sii "$PkgName")

	# Read the output line by line
	# Filter and save the values in variables
	# When a line starts with a space, it is a continuation of the previous line
	# When a line starts with a letter, it is a new key
	while IFS= read -r line; do

		# Verify if first character of line is a letter
		if [[ "${line:0:1}" = [a-zA-Z] ]]; then
			unset NextLineInVariable

			# Variables
			case $line in
			"Repository"*)
				# if line starts with Repository, get the value after ":"
				# and save in variable PacmanPkgRepository
				# same for all variables below
				PacmanPkgRepository=${line#*:}
				;;
			"Name"*)
				PacmanPkgName=${line#*:}
				;;
			"Version"*)
				PacmanPkgVersion=${line#*:}
				;;
			"Description"*)
				PacmanDescription=${line#*:}
				;;
			"Architecture"*)
				PacmanArchitecture=${line#*:}
				;;
			"URL"*)
				PacmanURL=${line#*:}
				;;
			"Download Size"*)
				PacmanDownloadSize=${line#*:}
				;;
			"Installed Size"*)
				PacmanInstalledSize=${line#*:}
				;;
			"Packager"*)
				PacmanPackager=${line#*:}
				;;
			"Build Date"*)
				PacmanBuildDate=${line#*:}
				;;
			"MD5 Sum"*)
				PacmanMD5Sum=${line#*:}
				;;
			"SHA-256 Sum"*)
				PacmanSHA256Sum=${line#*:}
				;;
			"Licenses"*)
				# if line starts with Licenses, get the value after ":"
				# and save in array PacmanLicenses using space as delimiter
				# same for all arrays below
				while IFS=' ' read -r ArrayValue; do
					PacmanLicenses+=($ArrayValue)
				done <<<${line#*:}
				;;
			"Groups"*)
				while IFS=' ' read -r ArrayValue; do
					PacmanGroups+=($ArrayValue)
				done <<<${line#*:}
				;;
			"Provides"*)
				while IFS=' ' read -r ArrayValue; do
					PacmanProvides+=($ArrayValue)
				done <<<${line#*:}
				;;
			"Depends On"*)
				while IFS=' ' read -r ArrayValue; do
					PacmanDependsOn+=($ArrayValue)
				done <<<${line#*:}
				;;
			"Required By"*)
				while IFS=' ' read -r ArrayValue; do
					PacmanRequiredBy+=($ArrayValue)
				done <<<${line#*:}
				;;
			"Optional For"*)
				while IFS=' ' read -r ArrayValue; do
					PacmanOptionalFor+=($ArrayValue)
				done <<<${line#*:}
				;;
			"Conflicts With"*)
				while IFS=' ' read -r ArrayValue; do
					PacmanConflictsWith+=($ArrayValue)
				done <<<${line#*:}
				;;
			"Replaces"*)
				while IFS=' ' read -r ArrayValue; do
					PacmanReplaces+=($ArrayValue)
				done <<<${line#*:}
				;;
			"Signatures"*)
				while IFS=' ' read -r ArrayValue; do
					PacmanSignatures+=($ArrayValue)
				done <<<${line#*:}
				;;
			"Optional Deps"*)
				# Create array PacmanOptionalDeps
				# Maybe have more than one line
				# The variable NextLineInVariable is used
				# To call the next line in the array
				# This is used alter else in another case
				while IFS=' ' read -r ArrayValue; do
					PacmanOptionalDeps+=($ArrayValue)
				done <<<${line#*:}
				NextLineInVariable=PacmanOptionalDeps
				;;
			esac

		# Multi Line arrays
		else
			case $NextLineInVariable in
			# If NextLineInVariable is AppstreamDescription
			# Concatenate the line in the array
			"AppstreamDescription")
				while IFS=' ' read -r ArrayValue; do
					PacmanOptionalDeps+=($ArrayValue)
				done <<<${line}
				;;
			esac
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

# To run test use this command, change PkgName variable to test another package:
# TestPacmanInfoByPkgName=true PkgName=firefox ./read_pacman.sh

if [[ "$TestPacmanInfoByPkgName" = "true" ]]; then
	# Call function to get info from pacman by package name
	# Using PkgName variable passed in command line
	getPacmanInfoByPkgName

	# Test if package is installed
	nativePackage="$PkgName" verifyNativePackageInstalled
	echo "NativePackageInstalled:    $NativePackageInstalled"

	# Show all variables and arrays
	echo "PacmanPkgRepository:      $PacmanPkgRepository"
	echo "PacmanPkgName:            $PacmanPkgName"
	echo "PacmanPkgVersion:         $PacmanPkgVersion"
	echo "PacmanDescription:        $PacmanDescription"
	echo "PacmanArchitecture:       $PacmanArchitecture"
	echo "PacmanURL:                $PacmanURL"
	echo "PacmanDownloadSize:       $PacmanDownloadSize"
	echo "PacmanInstalledSize:      $PacmanInstalledSize"
	echo "PacmanPackager:           $PacmanPackager"
	echo "PacmanBuildDate:          $PacmanBuildDate"
	echo "PacmanMD5Sum:             $PacmanMD5Sum"
	echo "PacmanSHA256Sum:          $PacmanSHA256Sum"
	echo "PacmanLicenses:            ${PacmanLicenses[@]}"
	echo "PacmanGroups:              ${PacmanGroups[@]}"
	echo "PacmanProvides:            ${PacmanProvides[@]}"
	echo "PacmanDependsOn:           ${PacmanDependsOn[@]}"
	echo "PacmanRequiredBy:          ${PacmanRequiredBy[@]}"
	echo "PacmanOptionalFor:         ${PacmanOptionalFor[@]}"
	echo "PacmanConflictsWith:       ${PacmanConflictsWith[@]}"
	echo "PacmanReplaces:            ${PacmanReplaces[@]}"
	echo "PacmanSignatures:          ${PacmanSignatures[@]}"
	echo "PacmanOptionalDeps:        ${PacmanOptionalDeps[@]}"
fi
