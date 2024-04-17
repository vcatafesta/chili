#!/usr/bin/env bash
# shellcheck shell=bash disable=SC1091,SC2039,SC2166
#
#  chili-makebash
#  Created: 2024/04/16
#  Altered: 2024/04/16
#
#  Copyright (c) 2022-2024, Vilmar Catafesta <vcatafesta@gmail.com>
#  All rights reserved.
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
##############################################################################
#export LANGUAGE=pt_BR
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=chili-makebash

#debug
export PS4='${red}${0##*/}${green}[$FUNCNAME]${pink}[$LINENO]${reset} '
#set -x
#set -e

#system
readonly APP="${0##*/}"
readonly _VERSION_='1.0.0-20240416'
readonly distro=$(uname -n)
readonly DEPENDENCIES=(grep)

a=3
b=a

     echo '1 =' $`echo $b`				# a
eval echo '2 =' $`echo $b`				# 3
eval echo '3.1 =' $(echo $b)			# ERRADO
eval echo '3.2 =' $(eval echo '$'"$b") 	# CERTO
eval echo '4 =' \$$(echo $b)			# CERTO
     echo '5 =' ${!b} 					# indireção - indiretamente o valor de b

echo '##################################################################################'

a=3
b=a
echo '1 =' $a
eval echo '2 =' $a
# Correção do erro na linha 3
eval echo '3 =' $(eval echo '$'"$b")
eval echo '4 =' \$$(echo $b)
echo '5 =' ${!b}

echo '##################################################################################'

var='|'
ls $var wc -l 			# erro

#na primeira passada ele vai resolver o $var (vai botar o pipe no meio), e na segunda vai fazer o wc -l
eval ls $var wc -l 		# OK
