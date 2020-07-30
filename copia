#!/bin/sh
source /etc/bashrc

function copyp()
{
    for x in {a..z}
    do
       log_info_msg "Trabalhando em ${x}"
		 cd /github/ChiliOS/packages/${x}
		 xcopy /tmp/${x}* /github/ChiliOS/packages/${x}
       evaluate_retval
    done
}

copyp
