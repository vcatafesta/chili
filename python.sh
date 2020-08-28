#! / usr / bin / env bash
# ================================================= ==============================
#
#           FILE: python.sh
#
#          USAGE: python.sh
#
#    DESCRIPTION: instale o python e outros utilitários que o python usa.
#
#        OPÇÕES: ---
#   REQUISITOS: ---
#           BUGS: ---
#          NOTAS: ---
#         AUTOR: Gregg Jensen (), gjensen@devops.center
#                 Bob Lozano (), bob@devops.center
#   ORGANIZAÇÃO: devops.center
#        CRIADO: 21/11/2016 15:13:37
#       REVISÃO: ---
#
# Copyright 2014-2017 devops.center llc
#
# Licenciado sob a Licença Apache, Versão 2.0 (a "Licença");
# você não pode usar este arquivo, exceto em conformidade com a Licença.
# Você pode obter uma cópia da Licença em
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# A menos que exigido por lei aplicável ou acordado por escrito, software
# distribuído sob a Licença é distribuído em uma base "COMO ESTÁ",
# SEM GARANTIAS OU CONDIÇÕES DE QUALQUER TIPO, expressas ou implícitas.
# Veja a Licença para o idioma específico que governa as permissões e
# limitações sob a licença.
#
# ================================================= ==============================

# set -o nounset # Trate as variáveis ​​não configuradas como um erro
set -o errexit       # exit imediatamente se o comando sair com um status diferente de zero
set -x              # essencialmente modo de depuração
set -o verbose

echo  " ============================ Elemento de construção: python ================ ==== "
echo  " PATH = / usr / local / opt / python / bin: $ PATH "  | sudo tee -a / etc / environment

sudo apt-get -qq update && apt-get -qq -y instala o python-software-properties software-propriedades-comum && \
    sudo add-apt-repository " deb http://gb.archive.ubuntu.com/ubuntu $ ( lsb_release -sc ) universo "  && \
    sudo apt-get -qq update

sudo add-apt-repositório -y ppa: saiarcot895 / myppa && \
    sudo apt-get -qq update && \
    sudo apt-get -qq -y instala o apt-fast

exportar GIT_VERSION = 2.21.0
exportar PYTHON_VERSION = 2.7.16

sudo apt-fast -qq update
sudo apt-fast -qq -y instalar o wget sudo vim curl build-essential

sudo apt-fast -qq -y instalar libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev libf-dev python-dev
pushd / tmp
sudo wget --quiet https://www.kernel.org/pub/software/scm/git/git-2.17.0.tar.gz
sudo tar -xvf git-2.17.0.tar.gz
pushd git-2.17.0
sudo make --silent prefixo = / usr / local todos && sudo make --silent prefixo = / usr / local install
popd
popd

sudo apt-fast -qq -y instalar sqlite3 libsqlite3-dev libssl-dev zlib1g-dev libxml2-dev libxslt-dev libbz2-dev gfortran libopenblas-dev liblapack-dev libatlas-dev subversion

pushd / tmp
sudo wget --quiet https://www.python.org/ftp/python/ $ {PYTHON_VERSION} / Python- $ {PYTHON_VERSION} .tgz -O / tmp / Python- $ {PYTHON_VERSION} .tgz
sudo tar -xvf Python- $ {PYTHON_VERSION} .tgz
pushd Python- $ {PYTHON_VERSION}
sudo ./configure CFLAGSFORSHARED = " -fPIC " CCSHARED = " -fPIC " --quiet CCSHARED = " -fPIC " --prefixo = / usr / local / opt / python --exec-prefixo = / usr / local / opt / python CCSHARED = " -fPIC " \
            && make clean && make --silent -j3 && sudo make - instalação suave
popd

sudo ln -s / usr / local / opt / python / bin / python / usr / local / bin / python

qual python && python --version

pushd / tmp
sudo wget --quiet https://bootstrap.pypa.io/get-pip.py && sudo python get-pip.py
sudo ln -s / usr / local / opt / python / bin / pip / usr / local / bin / pip

sudo pip instalar -U setuptools-git wheel virtualenv

sudo mkdir -p / casa do leme

# ipython
sudo apt-fast -qq -y instala libncurses5-dev
sudo pip install readline == 6.2.4.1

# Crie um diretório de rascunho, se ele ainda não existir
se [[ !  -e / data / scratch]] ;  então
    sudo mkdir -p / data / scratch
    sudo chmod -R 777 / data / scratch
fi
echo  " ============================ Elemento final: python ================ ==== "
