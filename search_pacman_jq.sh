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

# Use pacman to search for 'firefox' related packages
pacman -Ss $1 |

	# Use jq to parse and structure the output
	jq -Rs '
  # Split the input by newline, filter out empty lines, and then reduce it
  reduce (split("\n") | .[] | select(. != "")) as $line ([]; 

    # Check if the line starts with spaces (typically descriptions in pacman output)
    if ($line | startswith("    "))
    then
      # If there are already items in the result array
      if (length > 0)
      then 
        # Add the description to the last package in the result array
        .[-1].description = ($line | ltrimstr("    "))
      else 
        .
      end
    else
      # Construct the package info object
      {
        "repository": ($line | split("/")[0]),                                       # Extract the repository name
        "package": ($line | split("/")[1] | split(" ")[0]),                           # Extract the package name
        "version": ($line | split(" ")[1] | split("-")[0]),                           # Extract the version
        "group": (if $line | contains("(") and contains(")")                          # Extract the group if available
                 then ($line | split(" ")[2] | split("(")[1] | split(")")[0]) 
                 else null end),
        "installed": ($line | contains("[installed") | tostring),                      # Check if the package is installed
        "installed_version": (if $line | contains("[installed: ")                     # Extract the installed version if available
                             then ($line | split("[installed: ")[1] | split("]")[0])
                             else null end)
      } as $package_info | 

      # Append the package info to the result array
      . + [$package_info]
    end
  )
'
