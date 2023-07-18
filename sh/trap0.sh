#!/bin/bash

quit() {
echo "Do you want to quit ? (y/n)"
  read ctrlc
  if [ "$ctrlc" = 'y' ]; then
    exit
  fi
}

trap quit SIGINT
trap quit SIGTERM

while true; do
    echo -e "\n\e[91mIs everything done ? (y/n)\e[0m"
    read -i "y" -e yn
    case $yn in
        [Nn]* ) continue;;
        [Yy]* ) 

        echo -e "Done"
        break;;
        * ) echo -e "\e[91mPlease answer yes or no.\e[0m";;
    esac
done

