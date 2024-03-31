#!/usr/bin/env bash

# Extrair os valores das chaves do arquivo XML usando awk
pkgname=$(awk -F'[<>]' '/<key>pkgname<\/key>/{getline; print $3}' props.plist)
pkgver=$(awk -F'[<>]' '/<key>pkgver<\/key>/{getline; print $3}' props.plist)
short_desc=$(awk -F'[<>]' '/<key>short_desc<\/key>/{getline; print $3}' props.plist)
homepage=$(awk -F'[<>]' '/<key>homepage<\/key>/{getline; print $3}' props.plist)
maintainer=$(awk -F'[<>]' '/<key>maintainer<\/key>/{getline; print $3}' props.plist)
license=$(awk -F'[<>]' '/<key>license<\/key>/{getline; print $3}' props.plist)

# Imprimir os valores extraídos
echo "pkgname: $pkgname"
echo "pkgver: $pkgver"
echo "short_desc: $short_desc"
echo "homepage: $homepage"
echo "maintainer: $maintainer"
echo "license: $license"
