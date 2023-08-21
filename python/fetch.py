#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# License: MIT                                                              #

#python3 -m venv tutorial_env
#source tutorial_env/bin/activate

#url      = 'http://mazonos.com/packages/'        # Official Repository
url      = 'http://localhost/packages/'          # Official Repository
#url      = 'http://vcatafesta.online/packages/'  # Official Repository
#url     = 'https://github.com/vcatafesta/ChiliOS/tree/master/'           # Official Repository
#filecsv  = '/var/lib/fetch/database.db'          # Repository package list
filecsv = 'database.csv'                         # Repository package list
dircsv  = '/var/lib/fetch/'                      # Folder for the .csv file
dirlist = '/var/lib/banana/list/'                # Folder for the .list file
PRG     = '.chi.zst'
#PRG    = '.mz'

# Flags
found = False
done  = False
fi    = ""
rof   = ""
end   = ""
endef = ""
next  = ""

#define
PKG_FULLNAME     = 0
PKG_ARCH         = 1
PKG_BASE         = 2
PKG_BASE_VERSION = 3
PKG_VERSION      = 4
PKG_BUILD        = 5

#Strings
choose            = ''
textAnimate       = ''
please_connect    = 'No route to server! Check your internet connection!'
package_not_found = 'Package not found.'

# Arrays
switches = [
    's', 'search',
    'i', 'install',
    'r', 'remove',
    'w', 'show',
    'u', 'update',
    'g', 'upgrade',
    'c', 'checkdesc'
    ]

modules = ['requests', 'requests_html', 'bs4', 'argparse', 'consolecolor', 'sty', 'ssl']
import sys
import os
import csv
import threading
import itertools
import time
import re
import sys
import argparse

for module in modules:
    try:
        __import__(module)
    except Exception as e:
        print('Installing modules...')
        os.system('python3 -m pip install ' + str(module))
#        os.system('clear')
    end

import requests
import requests_html
import bs4
import ssl

from urllib.request import urlopen
from bs4 import BeautifulSoup
from requests_html import HTMLSession
from consolecolor import FontColor
from consolecolor import Colors
from sty import fg, bg, ef, rs, RgbFg
#fg.set_style('orange', RgbFg(255, 150, 50))

def version():
    print('''    __      _       _
   / _| ___| |_ ___| |__           Copyright (C) 2019-2020 Vilmar Catafesta <vcatafesta@gmail.com>
  | |_ / _ \ __/ __| '_ \
  |  _|  __/ || (__| | | |         Este programa pode ser redistribuído livremente
  |_|  \___|\__\___|_| |_|         sob os termos da Licença Pública Geral GNU.
fetch 1.00.00.20200817
''')


def check():
    #Checks if the folder exists
    if not os.path.isdir(dircsv):
        os.mkdir(dircsv)
        print('Created folder ' + dircsv + '.')
    fi

    # Checks if the file exists
    if not os.path.isfile(filecsv):
        os.system('touch ' + filecsv)
        print('Created file ' + filecsv + '.')
        os.system('clear')
        update()
    fi


def main():
    try:
        sys.argv[1]
    except IndexError:
        usage()
        exit(1)
    else:
        global choose
        choose = str(sys.argv[1])


def usage():
    print('erro: nenhuma operação especificada (use -h para obter ajuda)')


def usage():
    print('''uso:  fetch <operação> [...]
operações:
fetch {-h --help}
fetch {-V --version}
fetch {-D --database} <opções> <pacote(s)>
fetch {-F --files}    [opções] [pacote(s)]
fetch {-Q --query}    [opções] [pacote(s)]
fetch {-R --remove}   [opções] <pacote(s)>
fetch {-S --sync}     [opções] [pacote(s)]
fetch {-T --deptest}  [opções] [pacote(s)]
fetch {-U --upgrade}  [opções] <arquivo(s)>

use "fetch {-h --help}" com uma operação para ver as opções disponíveis
''')


def internet_on():
    #ssl ignore
#   ctx = ssl.create_default_context()
#   ctx.check_hostname = False
#   ctx.verify_mode = ssl.CERT_NONE

    try:
#       responde = urlopen(url, timeout=10, context=ctx).read()
#       response = urlopen(url, timeout=10)
        requests.get(url, timeout=10)
        return True
    #except:
    except exceptions.ConnectionError:
        return False


def animate():
    for c in itertools.cycle(['|', '/', '-', '\\']):
        if done:
            break
        fi
        sys.stdout.write('\r' + textAnimate + c)
        sys.stdout.flush()
        time.sleep(0.1)
    next
    sys.stdout.write('\r' + textAnimate + 'complete!   \n')


def s():
    search()


def search():
        global found

        if (len(sys.argv) >= 3):
            package = str(sys.argv[2])
        else:
            package = None
        fi

        with open(filecsv, 'r') as f:
            csv_reader = csv.reader(f)
            count      = 0
            linepackage()
            for line in csv_reader:
                if package:
                    if package in line[0]:
                        count += 1
                        print("{}({:04d}) {}{:<30}{} {:<20} {:<40}".format(fg.green, count, fg.orange, line[0].replace(PRG, ''), fg.rs, line[1], line[4]))
                        found = True
                    fi
                else:
                    count += 1
                    print("{}({:04d}) {}{:<30}{} {:<20} {:<40}".format(fg.green, count, fg.orange, line[0].replace(PRG, ''), fg.rs, line[1], line[4]))
                    found = True
                fi
            next
            print('(' + str(count) + ') package(s) found.')

            if not found:
                print(package_not_found)
            fi
        end


def linepackage():
    print(fg.cyan + '       Package                        version              fullname' + fg.rs)
    return


def i():
    install()


def install():
    if internet_on():
        try:
            sys.argv[2]
        except IndexError:
            usage()
            exit(0)
        else:
            global found
            package  = str(sys.argv[2])
            links    = []
            packages = []

            with open(filecsv, 'r') as f:
                csv_reader = csv.reader(f)
                count = 0
                linepackage()
                for line in csv_reader:
                    if package in line[0]:
                       found = True
                       count += 1
                       print("{}({:04d}) {}{:<30}{} {:<20} {:<40}".format(fg.green, count, fg.orange, line[0].replace(PRG, ''), fg.rs, line[1], line[4]))
                       links.append(url + line[4])
                       packages.append(line[3])
                    fi
                next

                if found:
                    pkgcount = packages.__len__()
                    pkglist = ''

                    for p in packages:
                        pkglist += (p + ', ')
                    next
                    pkglist = pkglist[:-2] + '.'
#                   print(str(pkgcount) + ' packages found: ' + pkglist.replace(PRG, ''))
                    print()
                    install = input(':: Continue installation? [Y/n] : ')
                    if install == 'Y' or install == 'y':
                        for p in range(pkgcount):
                            cstr = 'curl'
                            cstr += ' -#'
                            cstr += ' -k'
                            cstr += ' -o /tmp/' + packages[p]
                            cstr += ' -O '      + links[p]
                            os.system(cstr)
                            os.system('(banana -i ' +  '/tmp/' + packages[p] + '2>&1>/dev/null)')
#                           os.system('rm ' + '/tmp/' + packages[p])
                        rof
                    else:
                        exit(0)
                    fi
                else: # if not found
                    print(package_not_found)
                fi
            end
        end
    else:
        print(please_connect)
        exit(0)
    fi


def r():
    remove()


def remove():
    try:
        sys.argv[2]
    except IndexError:
        usage()
        exit(0)
    else:
        global found
        onlyfiles = [f for f in os.listdir(dirlist) if os.path.isfile(os.path.join(dirlist, f))]
        r = re.compile(sys.argv[2] + '.*')
        newlist = list(filter(r.match, onlyfiles))

        if newlist:
            found = True
            for pack in newlist:
                package = pack.replace('.list', '')
                remove  = input('You like remove ' + package + '? [Y/n] : ')
                if remove == 'y' or remove == 'Y':
                    os.system('banana remove ' + package + ' -y')
                else:
                    exit(0)

        if not found:
            print(package_not_found)


def w():
    show()


def show():
    try:
        sys.argv[2]
    except IndexError:
        usage()
        exit(0)
    else:
        global found
        package = str(sys.argv[2])

        with open(filecsv, 'r') as f:
            csv_reader = csv.reader(f)

            for line in csv_reader:
                if package in line[0]:
                    found    = True
                    pkgname  = line[0]
                    version  = line[1]
                    internet = internet_on()
                    lDesc    = False

                    if line[4]:
                        if internet:
                            r = requests.get(url + line[4] + '.desc' )
                            if not r.status_code == 404:
                                lDesc = True
                                text = r.text
                            fi
                        fi
                    fi

                    if not lDesc:
                        maintainer = '(unknown)'
                        desc       = 'Description not available for this package!'

                        if not internet:
                            desc += '\n' + please_connect
                        fi
                    else:
                        maintainer = (re.findall('maintainer.*', text)[0]).replace("'", '').replace('maintainer=', '').replace('"', '')
                        desc       = (re.findall('desc.*', text)[0]).replace("'", '').replace('desc=', '').replace('"', '')
                        #desc       = ((text.split('|')[2]).replace('#', '').replace('=', '').replace('desc"', ''))[:-2]
                    fi
                    print( fg.cyan + text + fg.rs )
#                   print('Package Name: ' + pkgname)
#                   print('Version.....: ' + version)
#                   print('Maintainer..: ' + maintainer)
#                   print('Desc........: ' + desc)
#                   print('#' * 70)
                fi
            next

            if not found:
                print(package_not_found)
            fi
        end
    end


def u():
    update()


def pause( xVar ):
    os.system('clear')
    print( xVar )
    resp = 'S'
    resp = input('Continuar [Y/n] : ')
    if resp == 'Y' or resp == 'y' or resp == 'S' or resp == 's':
        return
    fi
    exit(1)


def update():
    if internet_on():
        global textAnimate
        global done

        if os.path.isfile(filecsv):
            os.system('rm ' + filecsv)
        fi
        result    = requests.get(url)
        src       = result.content
        soup      = BeautifulSoup(src, 'html.parser')
        links     = soup.find_all('a')
        ntotalpkg = 0

        for link in links:
            if '../' in link.text:
                continue
            fi
            if '/' in link.text:
                urls    = url + link.get('href')
                result  = requests.get(urls)
                src     = result.content
                soup    = BeautifulSoup(src, 'html.parser')
                folders = soup.find_all('a')
                folder  = link.text
                ncontapkg  = 0
                for l in folders:
                    pkg        = l.get('href')
                    string     = ''
                    if l.text.endswith((PRG)):
                        ncontapkg  += 1
                        ntotalpkg  += 1
                        string   = pkg
                        pkgsplit = splitpkg(pkg)
                        with open(filecsv, 'a') as f:
                            csv_writer = csv.writer(f)
                            csv_writer.writerow([pkgsplit[PKG_BASE], pkgsplit[PKG_VERSION], pkgsplit[PKG_BUILD], string, folder+string])
                        end
                    fi
                rof
                print("{}::{}Updating... {}({:04d}) {}packages in {}{}{}".format(fg.cyan, fg.rs, fg.cyan, ncontapkg, fg.red, fg.yellow, link.get('href'),fg.rs))
            fi
        rof
        print('')
        print("{}({:04d}) {}packages{} in repo".format(fg.cyan, ntotalpkg, fg.red, fg.rs))
        done = True
    else:
        print(please_connect)
    fi


def splitpkg(cfilename):
    cfullname     = cfilename
    pkg_arch      = cfullname.replace('-any' + PRG,'')
    pkg_arch      = pkg_arch.replace('-x86_64' + PRG,'')
#    pkg_arch      = pkg_arch.replace(PRG,'')
    carch         = cfullname.replace(PRG,'')
    csplit        = pkg_arch.rsplit('-',2)
    cbase         = csplit[0]
    cbase_version = cfilename.rsplit('-',1)[0]
    cbuild        = csplit[2]
    cversion      = csplit[1]
    cversion      += '-'
    cversion      += cbuild
    return( cfullname, carch, cbase, cbase_version, cversion, cbuild)

def g():
    upgrade()

def upgrade():
    print('Upgrading...')

def c():
    checkdesc()

def checkdesc():
    if internet_on():
        update()

        global textAnimate
        global done

        found = False
        nodescs = []

        textAnimate = 'Searching '
        t = threading.Thread(target=animate)
        t.start()

        with open(filecsv, 'r') as f:
            csv_reader = csv.reader(f)

            for line in csv_reader:
                if line[2] == '':
                    found = True
                    nodescs.append(' ' + line[0] + line[1] + '.desc -> not found!')
                fi
            end
            done = True
        end

        if found:
            print('The following packages do not have the .desc file:')
            for n in nodescs:
                print(n)
        else:
            print('All packages are OK!')
        fi
    else:
        print(please_connect)
        exit(1)
    fi

switches = [
    's', 'search',
    'i', 'install',
    'r', 'remove',
    'w', 'show',
    'u', 'update',
    'g', 'upgrade',
    'c', 'checkdesc'
    ]

def indirect(i):
    switcher={
            '-h':usage, '--help':usage,
            '-Sy':update,
            '-Sw':show,
            '-Si':install,
            '-Su':upgrade,
            '-R':remove,
            '-Q':search,
            '-V':version,
            '-f':lambda: 'force',
            '-y':lambda: 'auto'
            }
    func=switcher.get(i, lambda: 'invalid')
    return func()

try:
    check()
    main()
#    if choose in switches:
#        functions = locals()
#        functions[choose]()
#    else:
#        usage()
#        print('Invalid \"' + choose + '\" operation!')
    indirect(sys.argv[1])

except KeyboardInterrupt:
    print('\n')
    exit(0)


def main():
    # (1)
    parser = argparse.ArgumentParser(description='ChiliOS fetch')
    parser.add_argument('-Sy', nargs='*', type=str, default='', required=False, help='Sync')  #(2)
    parser.add_argument('-Su', nargs='*', type=str, default='', required=False, help='Sync')  #(2)
    parser.add_argument('-f', dest='force', nargs='*', type=str, default='', required=False, help='Sync')  #(2)
    parser.add_argument('-y', dest='auto', nargs='*', type=str, default='', required=False, help='Sync')  #(2)
    args = parser.parse_args() #(3)

    choose = 'Sy'
    if choose in switches:
        functions = locals()
        pause( functions )
        functions['update']()
    print("Sy={}".format(args.Sy)) # (4)
    print("Su={}".format(args.Su)) # (4)
    print(" f={}".format(args.force)) # (4)
    print(" y={}".format(args.auto)) # (4)
    return 0

if __name__ == '__main__':
    sys.exit(main())
