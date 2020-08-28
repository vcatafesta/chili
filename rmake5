#!/bin/bash
source /etc/bashrc
WDIR=/src/plasma

while read -r line; do

    # Get the file name, ignoring comments and blank lines
    if $(echo $line | grep -E -q '^ *$|^#' ); then continue; fi
    file=$(echo $line | cut -d" " -f2)

    pkg=$(echo $file|sed 's|^.*/||')          # Remove directory
    packagedir=$(echo $pkg|sed 's|\.tar.*||') # Package directory

    name=$(echo $pkg|sed 's|-5.*$||') # Isolate package name

    nfile=$(echo $file | sed 's/\// /g' | awk '{print $NF}'|sed 's/-/_/g'| sed 's/\(.*\)_/\1 /'|sed 's/ /-/g')
    npackagedir=$(echo $packagedir | sed 's/\// /g' | awk '{print $NF}'|sed 's/-/_/g'| sed 's/\(.*\)_/\1 /'|sed 's/ /-/g')
    echo
    echo "$packagedir =>  $npackagedir"

    log_info_msg "Aguarde, descompactando pacote $packagedir"
    tar -xf $file  >/dev/null 2>&1
    evaluate_retval
    [[ $? != 0 ]] && exit 1

    log_info_msg "Aguarde, renomeando diretorio $packagedir para $npackedir"
    mv $packagedir/ $npackagedir/  >/dev/null 2>&1
    pushd $npackagedir  >/dev/null 2>&1
    evaluate_retval
    [[ $? != 0 ]] && exit 1

    log_info_msg "Aguarde, construindo pacote $packagedir"
    # Fix some build issues when generating some configureation files
       case $name in
         plasma-workspace)
           sed -i '/set.HAVE_X11/a set(X11_FOUND 1)' CMakeLists.txt
         ;;

         khotkeys)
           sed -i '/X11Extras/a set(X11_FOUND 1)' CMakeLists.txt
         ;;

         plasma-desktop)
           sed -i '/X11.h)/i set(X11_FOUND 1)' CMakeLists.txt
         ;;
       esac

      mkdir build  >/dev/null 2>&1
      cd    build  >/dev/null 2>&1

      cmake -DCMAKE_INSTALL_PREFIX=$KF5_PREFIX \
            -DCMAKE_PREFIX_PATH=$QT5DIR        \
            -DCMAKE_BUILD_TYPE=Release         \
            -DBUILD_TESTING=OFF                \
            -Wno-dev ..  >/dev/null 2>&1

      make  >/dev/null 2>&1
      evaluate_retval
      [[ $? != 0 ]] && exit 1

      log_info_msg "Aguarde, instalando pacote $packagedir"
      as_root make install  >/dev/null 2>&1
      evaluate_retval
      [[ $? != 0 ]] && exit 1

      log_info_msg "Aguarde, gerando pacote $packagedir"
      pushd $WDIR/$npackagedir  >/dev/null 2>&1
      as_root gen  >/dev/null 2>&1
      evaluate_retval
      [[ $? != 0 ]] && exit 1

      log_info_msg "Aguarde, instalando pacote $packagedir em DESTDIR"
      popd  >/dev/null 2>&1
      pushd $WDIR/$npackagedir/build  >/dev/null 2>&1
      as_root make install DESTDIR=/lfs/build/$npackagedir  >/dev/null 2>&1
      evaluate_retval
      [[ $? != 0 ]] && exit 1

      log_info_msg "Aguarde, gerando pacote $packagedir em DESTDIR"
      popd  >/dev/null 2>&1
      pushd /lfs/build/$npackagedir  >/dev/null 2>&1
      as_root bcp  >/dev/null 2>&1
      evaluate_retval
      [[ $? != 0 ]] && exit 1

      log_info_msg "Aguarde, instalando pacote $packagedir via DESTDIR"
      as_root ban  >/dev/null 2>&1
      evaluate_retval
      [[ $? != 0 ]] && exit 1
      popd  >/dev/null 2>&1
      popd  >/dev/null 2>&1
      echo
#      as_root rm -rf $npackagedir  >/dev/null 2>&1
      as_root /sbin/ldconfig  >/dev/null 2>&1
done < plasma-5.15.5.md5

install -dvm 755 /usr/share/xsessions &&
cd /usr/share/xsessions/              &&
[ -e plasma.desktop ]                 ||
as_root ln -sfv $KF5_PREFIX/share/xsessions/plasma.desktop
