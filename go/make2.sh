#!/bin/bash

source out1.sh

###

# Results
ootb_goarches_32=()
ootb_goarches_64=()
ootb_platforms_32=()
ootb_platforms_64=()

for ootb_platform in "${ootb_platforms[@]}"; do
	ootb_goos=${ootb_platform%/*}
	ootb_goarch=${ootb_platform#*/}
	GOOS="${ootb_goos}" GOARCH="${ootb_goarch}" go build -o /dev/null 3-main2.go >/dev/null 2>&1
	if [ $? -eq 0 ]; then
		ootb_goarches_64+=(${ootb_goarch})
		ootb_platforms_64+=(${ootb_platform})
	else
		ootb_goarches_32+=(${ootb_goarch})
		ootb_platforms_32+=(${ootb_platform})
	fi
done
ootb_goarches_32=($(printf -- '%s\n' "${ootb_goarches_32[@]}" | sort | uniq))
ootb_goarches_64=($(printf -- '%s\n' "${ootb_goarches_64[@]}" | sort | uniq))

###

# Usage:
# print_array $array_name
print_array() {
	array_name="$1"
	array_ref="$array_name[@]"
	printf -- '%s=(\n' "$array_name"
	printf -- '    %s\n' "${!array_ref}"
	printf -- ')\n\n'
}

###

{
	print_array 'ootb_goarches_32'
	print_array 'ootb_goarches_64'
	print_array 'ootb_platforms_32'
	print_array 'ootb_platforms_64'
} >out2.sh
