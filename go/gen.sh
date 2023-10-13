#!/bin/bash

source out1.sh
source out2.sh

###

# This list is based on:
# https://github.com/golang/go/blob/master/src/go/build/syslist.go
gooses=(
    aix android darwin dragonfly freebsd hurd illumos ios js \
    linux nacl netbsd openbsd plan9 solaris windows zos
)
gooses=($(printf -- '%s\n' "${gooses[@]}" | sort))

# This list is based on:
# https://github.com/golang/go/blob/master/src/go/build/syslist.go
goarches=(
    386 amd64 amd64p32 arm armbe arm64 arm64be ppc64 ppc64le \
    loong64 mips mipsle mips64 mips64le mips64p32 mips64p32le \
    ppc riscv riscv64 s390 s390x sparc sparc64 wasm
)
goarches=($(printf -- '%s\n' "${goarches[@]}" | sort))

# This list is based on my knowledge, the result of 4-make2.sh, and the link below:
# https://golang.org/doc/install/source
goarches_32=(
    386 amd64p32 arm armbe mips mipsle \
    mips64p32 mips64p32le ppc riscv s390 sparc
)
goarches_32=($(printf -- '%s\n' "${goarches_32[@]}" | sort))

# This list is based on my knowledge, the result of 4-make2.sh, and the link below:
# https://golang.org/doc/install/source
goarches_64=(
    amd64 arm64 arm64be ppc64 ppc64le loong64 \
    mips64 mips64le riscv64 s390x sparc64 wasm
)
goarches_64=($(printf -- '%s\n' "${goarches_64[@]}" | sort))

###

#############################
# Functions for Computation #
#############################

# Usage:
# is_in_array $target ${array[@]}
is_in_array()
{
    target="$1"
    shift

    array=("$@")
    for item in "${array[@]}"
    do
        if [ "$item" = "$target" ]
        then
            return 0
        fi
    done

    return 1
}

# Usage:
# cmp_arrays $len_base_array ${base_array[@]} ${filtered_array[@]}
cmp_arrays()
{
    len_base_array=$1
    shift

    base_array=()
    for ((i=0; i<len_base_array; i++))
    do
        base_array+=("$1")
        shift
    done

    filtered_array=("$@")
    len_filtered_array=${#filtered_array[@]}

    i=0
    for item in "${base_array[@]}"
    do
        if [ $i -lt $len_filtered_array -a "$item" = "${filtered_array[i]}" ]
        then
            printf -- '1\n'
            ((++i))
        else
            printf -- '0\n'
        fi
    done
}

# Usage:
# cmp3_arrays $len_base_array ${base_array[@]} $len_filtered_array1 ${filtered_array1[@]} ${filtered_array2[@]}
cmp3_arrays()
{
    len_base_array=$1
    shift

    base_array=()
    for ((i=0; i<len_base_array; i++))
    do
        base_array+=("$1")
        shift
    done

    len_filtered_array1=$1
    shift

    filtered_array1=()
    for ((i=0; i<len_filtered_array1; i++))
    do
        filtered_array1+=("$1")
        shift
    done

    filtered_array2=("$@")
    len_filtered_array2=${#filtered_array2[@]}

    i=0
    j=0
    for item in "${base_array[@]}"
    do
        if [ $i -lt $len_filtered_array1 -a "$item" = "${filtered_array1[i]}" ]
        then
            if [ $j -lt $len_filtered_array2 -a "$item" = "${filtered_array2[j]}" ]
            then
                printf -- '1\n'
                ((++j))
            else
                printf -- '2\n'
            fi
            ((++i))
        else
            printf -- '0\n'
        fi
    done
}

# Usage:
# add_prefix_to_array $prefix ${array[@]}
add_prefix_to_array()
{
    prefix="$1"
    shift

    array=("$@")
    for item in "${array[@]}"
    do
        printf -- '%s%s\n' "$prefix" "$item"
    done
}

# Usage:
# filter_array_by_prefix $prefix ${array[@]}
filter_array_by_prefix()
{
    prefix="$1"
    len_prefix=${#prefix}
    shift

    array=("$@")
    for item in "${array[@]}"
    do
        if [ "${item:0:$len_prefix}" = "$prefix" ]
        then
            printf -- '%s\n' "$item"
        fi
    done
}

###

# Results
platforms=()
platforms_32=()
platforms_64=()

platforms=($(go tool dist list))
platforms=($(printf -- '%s\n' "${platforms[@]}" | sort))

for platform in "${platforms[@]}"
do
    goarch="${platform#*/}"
    if is_in_array "$goarch" "${goarches_32[@]}"
    then
        platforms_32+=("$platform")
    else
        platforms_64+=("$platform")
    fi
done

###

#################################
# Functions for Printing Result #
#################################

repeat()
{
    ch="$1"
    n=$2
    for ((i=0; i<n; i++))
    do
        printf -- '%s' "$ch"
    done
}

left()
{
    n=$1
    printf -- ':'
    repeat '-' $((n-1))
}

right()
{
    n=$1
    repeat '-' $((n-1))
    printf -- ':'
}

center()
{
    n=$1
    printf -- ':'
    repeat '-' $((n-2))
    printf -- ':'
}

code()
{
    printf -- '`%s`\n' "$@"
}

bold()
{
    printf -- '**%s**\n' "$@"
}

bold_code()
{
    printf -- '**`%s`**\n' "$@"
}

###

# Usage:
# print_table $col_count row_count headers... alignments... is_bools... col1... col2... ...
print_table()
{
    has_footer=$1
    col_count=$2
    row_count=$3
    shift 3

    headers=()
    for ((c=0; c<col_count; c++))
    do
        headers+=("$1")
        shift
    done

    if [ $has_footer -ne 0 ]
    then
        footers=()
        for ((c=0; c<col_count; c++))
        do
            if [ "${headers[c]}" = '' ]
            then
                footers+=('')
                continue
            fi
            footers+=($(bold "${headers[c]}"))
        done
    fi

    alignments=()
    for ((c=0; c<col_count; c++))
    do
        alignments+=("$1")
        shift
    done

    is_bools=()
    for ((c=0; c<col_count; c++))
    do
        is_bools+=($1)
        shift
    done

    body=("$@")

    lens=()
    for ((c=0; c<col_count; c++))
    do
        maxlen=${#headers[c]}
        for ((r=0; r<row_count; r++))
        do
            len=${#body[c*row_count+r]}
            if [ $len -gt $maxlen ]
            then
                maxlen=$len
            fi
        done
        if [ $maxlen -lt 3 ]
        then
            maxlen=3
        fi
        lens+=($maxlen)
    done

    fmts=()
    for ((c=0; c<col_count; c++))
    do
        if [ ${is_bools[c]} -eq 0 ]
        then
            fmt=$(printf -- '| %%-%ds ' ${lens[c]})
        else
            fmt=$(printf -- '| %%s%%-%ds ' $((lens[c] - 1)))    # -1 for the length of $ootb
        fi
        # Last column
        if [ $c -eq $((col_count - 1)) ]
        then
            fmt+='|\n'
        fi
        fmts+=("$fmt")
    done
    fmt=$(printf -- '%s' "${fmts[@]}")

    # Print Header
    _headers=()
    for ((c=0; c<col_count; c++))
    do
        if [ ${is_bools[c]} -eq 0 ]
        then
            _headers+=("${headers[c]}")
        else
            _headers+=('' "${headers[c]}")
        fi
    done
    printf -- "$fmt" "${_headers[@]}"

    # Print Separator
    seps=()
    for ((c=0; c<col_count; c++))
    do
        if [ ${is_bools[c]} -eq 0 ]
        then
            seps+=("$(${alignments[c]} ${lens[c]})")
        else
            seps+=('' "$(${alignments[c]} ${lens[c]})")
        fi
    done
    printf -- "$fmt" "${seps[@]}"

    # Print Body
    for ((r=0; r<row_count; r++))
    do
        row=()
        for ((c=0; c<col_count; c++))
        do
            cell="${body[c*row_count+r]}"
            if [ ${is_bools[c]} -eq 0 ]
            then
                row+=("$cell")
            else
                if [ $cell -eq 0 ]
                then
                    row+=(' ' '')
                elif [ $cell -eq 1 ]
                then
                    row+=('✅' '')      # This counts 3 bytes in printf, so it must be handled separately
                elif [ $cell -eq 2 ]
                then
                    row+=('☑️' '')      # This counts 3 bytes in printf, so it must be handled separately
                else
                    # Panic
                    printf -- 'Unknown value of $cell: %d\n' $cell
                    exit
                fi
            fi
        done
        printf -- "$fmt" "${row[@]}"
    done

    # Print Footer
    if [ $has_footer -ne 0 ]
    then
        printf -- '| %s ' "${footers[@]}"
        printf -- '|\n'
    fi

    printf -- '\n'
}

print_list()
{
    arr=("$@")
    fmt='"%s"'
    printf -- '```text\n'
    for elem in "${arr[@]}"
    do
        printf -- "$fmt" "$elem"
        fmt=', "%s"'
    done
    printf -- '\n```\n\n'
}

print_gooses_table()
{
    headers=('GOOS' 'Out of the Box')
    alignments=(left center)
    is_bools=(0 1)
    col1=($(code "${gooses[@]}"))
    col2=($(cmp_arrays ${#gooses[@]} "${gooses[@]}" "${ootb_gooses[@]}"))
    col_count=${#headers[@]}
    row_count=${#col1[@]}
    print_table 0 $col_count $row_count \
        "${headers[@]}" "${alignments[@]}" ${is_bools[@]} \
        "${col1[@]}" ${col2[@]}
}

print_goarches_table()
{
    headers=('GOARCH' 'Out of the Box' '32-bit' '64-bit')
    alignments=(left center center center)
    is_bools=(0 1 1 1)
    col1=($(code "${goarches[@]}"))
    col2=($(cmp_arrays ${#goarches[@]} "${goarches[@]}" "${ootb_goarches[@]}"))
    col3=($(cmp_arrays ${#goarches[@]} "${goarches[@]}" "${goarches_32[@]}"))
    col4=($(cmp_arrays ${#goarches[@]} "${goarches[@]}" "${goarches_64[@]}"))
    col_count=${#headers[@]}
    row_count=${#col1[@]}
    print_table 0 $col_count $row_count \
        "${headers[@]}" "${alignments[@]}" ${is_bools[@]} \
        "${col1[@]}" ${col2[@]} ${col3[@]} ${col4[@]}
}

print_platforms_table()
{
    headers=('Platform' 'Out of the Box' '32-bit' '64-bit')
    alignments=(left center center center)
    is_bools=(0 1 1 1)
    col1=($(code "${platforms[@]}"))
    col2=($(cmp_arrays ${#platforms[@]} "${platforms[@]}" "${ootb_platforms[@]}"))
    col3=($(cmp_arrays ${#platforms[@]} "${platforms[@]}" "${platforms_32[@]}"))
    col4=($(cmp_arrays ${#platforms[@]} "${platforms[@]}" "${platforms_64[@]}"))
    col_count=${#headers[@]}
    row_count=${#col1[@]}
    print_table 0 $col_count $row_count \
        "${headers[@]}" "${alignments[@]}" ${is_bools[@]} \
        "${col1[@]}" ${col2[@]} ${col3[@]} ${col4[@]}
}

grid_column()
{
    prefix="$1/"
    base_column=($(add_prefix_to_array "$prefix" "${goarches[@]}"))
    filtered_column1=($(filter_array_by_prefix "$prefix" "${platforms[@]}"))
    filtered_column2=($(filter_array_by_prefix "$prefix" "${ootb_platforms[@]}"))
    col=($(cmp3_arrays ${#base_column[@]} "${base_column[@]}" "${#filtered_column1[@]}" "${filtered_column1[@]}" "${filtered_column2[@]}"))
    printf -- '%s\n' "${col[@]}"
}

print_support_grid_1()
{
    oses=(android darwin ios js linux windows)
    headers=('' $(code "${oses[@]}") '')
    footers=('' $(bold_code "${oses[@]}") '')
    alignments=(right center center center center center center left)
    is_bools=(0 1 1 1 1 1 1 0)
    col1=($(bold_code "${goarches[@]}"))
    col2=($(grid_column "${oses[0]}"))
    col3=($(grid_column "${oses[1]}"))
    col4=($(grid_column "${oses[2]}"))
    col5=($(grid_column "${oses[3]}"))
    col6=($(grid_column "${oses[4]}"))
    col7=($(grid_column "${oses[5]}"))
    # col8=("${col1[@]}")
    col_count=${#headers[@]}
    row_count=${#col1[@]}
    print_table 1 $col_count $row_count \
        "${headers[@]}" "${alignments[@]}" ${is_bools[@]} \
        "${col1[@]}" ${col2[@]} ${col3[@]} ${col4[@]} \
        ${col5[@]} ${col6[@]} ${col7[@]} "${col1[@]}"
}

print_support_grid_2()
{
    oses=(aix dragonfly freebsd hurd illumos nacl netbsd openbsd plan9 solaris zos)
    oses_abbr=(a d f h i m n o p s z)
    headers=('' $(code "${oses_abbr[@]}") '')
    footers=('' $(bold_code "${oses_abbr[@]}") '')
    alignments=(right center center center center center center center center center center center left)
    is_bools=(0 1 1 1 1 1 1 1 1 1 1 1 0)
    col1=($(bold_code "${goarches[@]}"))
    col2=($(grid_column "${oses[0]}"))
    col3=($(grid_column "${oses[1]}"))
    col4=($(grid_column "${oses[2]}"))
    col5=($(grid_column "${oses[3]}"))
    col6=($(grid_column "${oses[4]}"))
    col7=($(grid_column "${oses[5]}"))
    col8=($(grid_column "${oses[6]}"))
    col9=($(grid_column "${oses[7]}"))
    col10=($(grid_column "${oses[8]}"))
    col11=($(grid_column "${oses[9]}"))
    col12=($(grid_column "${oses[10]}"))
    # col13=("${col1[@]}")
    col_count=${#headers[@]}
    row_count=${#col1[@]}
    print_table 1 $col_count $row_count \
        "${headers[@]}" "${alignments[@]}" ${is_bools[@]} \
        "${col1[@]}" ${col2[@]} ${col3[@]} ${col4[@]} \
        ${col5[@]} ${col6[@]} ${col7[@]} ${col8[@]} \
        ${col9[@]} ${col10[@]} ${col11[@]} ${col12[@]} \
        "${col1[@]}"

    # Print Key
    printf -- '### Key\n'
    printf -- '\n'
    fmt='`%s` = `%s`'
    len=${#oses[@]}
    for ((i=0; i<len; i++))
    do
        printf -- "$fmt" "${oses_abbr[i]}" "${oses[i]}"
        fmt=', `%s` = `%s`'
    done
    printf -- '\n\n'
}

###

printf -- '# Go (Golang) GOOS and GOARCH\n'
printf -- '\n'
printf -- 'All of the following information is based on `%s`.\n' "$(go version)"
printf -- '\n'

###

printf -- '## GOOS Values\n'
printf -- '\n'
print_gooses_table

printf -- 'All GOOS values:\n'
print_list "${gooses[@]}"

printf -- '"Out of the box" GOOS values:\n'
print_list "${ootb_gooses[@]}"

printf -- '> NOTE\n'
printf -- '>\n'
printf -- '> "Out of the box" means the GOOS is supported out of the box, i.e. the stocked `go` command can build the source code without the help of a C compiler, etc.\n'
printf -- '\n'

printf -- '> NOTE\n'
printf -- '>\n'
printf -- '> The full list is based on https://github.com/golang/go/blob/master/src/go/build/syslist.go. The "out of the box" information is based on the result of [2-make1.sh](#file-2-make1-sh) below.\n'
printf -- '\n'

###

printf -- '## GOARCH Values\n'
printf -- '\n'
print_goarches_table

printf -- 'All GOARCH values:\n'
print_list "${goarches[@]}"

printf -- 'All 32-bit GOARCH values:\n'
print_list "${goarches_32[@]}"

printf -- 'All 64-bit GOARCH values:\n'
print_list "${goarches_64[@]}"

printf -- '"Out of the box" GOARCH values:\n'
print_list "${ootb_goarches[@]}"

printf -- '"Out of the box" 32-bit GOARCH values:\n'
print_list "${ootb_goarches_32[@]}"

printf -- '"Out of the box" 64-bit GOARCH values:\n'
print_list "${ootb_goarches_64[@]}"

printf -- '> NOTE\n'
printf -- '>\n'
printf -- '> "Out of the box" means the GOARCH is supported out of the box, i.e. the stocked `go` command can build the source code without the help of a C compiler, etc.\n'
printf -- '\n'

printf -- '> NOTE\n'
printf -- '>\n'
printf -- '> The full list is based on https://github.com/golang/go/blob/master/src/go/build/syslist.go. The "out of the box" information is based on the result of [2-make1.sh](#file-2-make1-sh) below. The "32-bit/64-bit" information is based on the result of [4-make2.sh](#file-4-make2-sh) below and https://golang.org/doc/install/source.\n'
printf -- '\n'

###

printf -- '## Platform Values\n'
printf -- '\n'
print_platforms_table

printf -- 'All Platform values:\n'
print_list "${platforms[@]}"

printf -- 'All 32-bit Platform values:\n'
print_list "${platforms_32[@]}"

printf -- 'All 64-bit Platform values:\n'
print_list "${platforms_64[@]}"

printf -- '"Out of the box" Platform values:\n'
print_list "${ootb_platforms[@]}"

printf -- '"Out of the box" 32-bit Platform values:\n'
print_list "${ootb_platforms_32[@]}"

printf -- '"Out of the box" 64-bit Platform values:\n'
print_list "${ootb_platforms_64[@]}"

printf -- '> NOTE\n'
printf -- '>\n'
printf -- '> "Out of the box" means the platform is supported out of the box, i.e. the stocked `go` command can build the source code without the help of a C compiler, etc.\n'
printf -- '\n'

printf -- '> NOTE\n'
printf -- '>\n'
printf -- '> The full list is based on the result of the command `go tool dist list`. The "out of the box" information is based on the result of [2-make1.sh](#file-2-make1-sh) below. The "32-bit/64-bit" information is based on the result of [4-make2.sh](#file-4-make2-sh) below and https://golang.org/doc/install/source.\n'
printf -- '\n'

###

printf -- '## Support Grid 1\n'
printf -- '\n'
print_support_grid_1

printf -- '## Support Grid 2\n'
printf -- '\n'
print_support_grid_2

printf -- '✅: Supported (out of the box)\n'
printf -- '\n'
printf -- '☑️: Supported (with the help of a C compiler, etc.)\n'
printf -- '\n'
printf -- '(blank): Unsupported\n'
printf -- '\n'

printf -- '> NOTE\n'
printf -- '>\n'
printf -- '> The `nacl` GOOS was dropped since `go version 1.14`\n'
printf -- '>\n'
printf -- '> The `amd64p32` GOARCH, which is related to the `nacl` GOOS, was also dropped since `go version 1.14` (I believe that `mips64p32` and `mips64p32le` are also related, but I could not find any reference)\n'
printf -- '>\n'
printf -- '> Reference: https://golang.org/doc/go1.14#nacl\n'
printf -- '\n'

printf -- '> NOTE\n'
printf -- '>\n'
printf -- '> The `darwin/386` port was dropped since `go version 1.15`\n'
printf -- '>\n'
printf -- '> Reference: https://golang.org/doc/go1.15#darwin\n'
printf -- '\n'

printf -- '> NOTE\n'
printf -- '>\n'
printf -- '> On before `go version 1.16`:\n'
printf -- '> - `darwin/amd64` means **macOS**\n'
printf -- '> - `darwin/arm64` means **iOS**\n'
printf -- '>\n'
printf -- '> With the introduction of Apple Silicon (a.k.a. the M1 chip), on `go version 1.16` or later:\n'
printf -- '> - `darwin/amd64` means **macOS** with Intel CPU\n'
printf -- '> - `darwin/arm64` updates to mean **macOS** with Apple Silicon CPU\n'
printf -- '> - `ios/amd64` is the new port for **iOS Simulator** on macOS with Intel CPU\n'
printf -- '> - `ios/arm64` is the new port for **iOS**\n'
printf -- '>\n'
printf -- '> Reference: https://golang.org/doc/go1.16#darwin\n'
