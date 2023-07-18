#!/usr/bin/env bash
echo 'set -- {a..z}'
set -- {a..z}

echo 'echo $@'
echo $@

echo 'echo ${@:0:1}'
echo ${@:0:1}

echo 'echo ${@:1:1}'
echo ${@:1:1}

echo 'echo ${@: -2:5}'
echo ${@: -2:5}

echo 'echo ${@: -5:2}'
echo ${@: -5:2}

echo 'echo ${@: -5:-3} #FAIL, usado somente em string, NOT array ou parametros'
echo ${@: -5:-3} #fail serve somente em string, not array ou parametros


