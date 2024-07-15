#!/bin/bash

# This list is based on:
# https://github.com/golang/go/blob/master/src/go/build/syslist.go
gooses=(
	aix android darwin dragonfly freebsd hurd illumos ios js
	linux nacl netbsd openbsd plan9 solaris windows zos
)
gooses=($(printf -- '%s\n' "${gooses[@]}" | sort))

# This list is based on:
# https://github.com/golang/go/blob/master/src/go/build/syslist.go
goarches=(
	386 amd64 amd64p32 arm armbe arm64 arm64be ppc64 ppc64le
	loong64 mips mipsle mips64 mips64le mips64p32 mips64p32le
	ppc riscv riscv64 s390 s390x sparc sparc64 wasm
)
goarches=($(printf -- '%s\n' "${goarches[@]}" | sort))

###

# Results
ootb_gooses=()
ootb_goarches=()
ootb_platforms=()

for goos in "${gooses[@]}"; do
	is_goos_ootb=0
	for goarch in "${goarches[@]}"; do
		GOOS="$goos" GOARCH="$goarch" go build -o /dev/null 1-main1.go >out.log 2>err.log
		if [ $? -eq 0 ]; then
			if [ $is_goos_ootb -eq 0 ]; then
				ootb_gooses+=("$goos")
				is_goos_ootb=1
			fi
			ootb_goarches+=("$goarch")
			ootb_platforms+=("$goos/$goarch")
		else
			if grep -qe '^cmd/go: unsupported GOOS/GOARCH pair' err.log; then
				:
			else
				mv err.log $goos-$goarch.err.log
			fi
		fi
		if [ -s out.log ]; then
			mv out.log $goos-$goarch.out.log
		fi
	done
done
ootb_goarches=($(printf -- '%s\n' "${ootb_goarches[@]}" | sort | uniq))
rm -f out.log err.log

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
	print_array 'ootb_gooses'
	print_array 'ootb_goarches'
	print_array 'ootb_platforms'
} >out1.sh
