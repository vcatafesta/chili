#!/usr/bin/env bash

# Initialise the strings
MENU="Play from a favorite station! bash -c play_favorite|\
Add a station to your favorites! bash -c add_station|\
Display current station name! bash -c show_name"
HINT=" Radio streamer - left-click exit - right click menu "
PIPE=$(mktemp -u /tmp/r_streamer.XXXXXXXX)
ICON=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/streamer.png
PREFIX="$HOME/.config/radio_streamer"
STATION_LIST="/home/$USER/.config/glrp/stations.csv"
MY_FAVORITES="$PREFIX/favorites"

# Make some variables available globally
export STATION_LIST
export MY_FAVORITES
export PIPE
export PREFIX
export ICON

# define functions
first_run() { # set up basic file structure
# check for and create if necessary 
# directory ~/.config/radio-streamer
if ! [ -d "$PREFIX" ]
then
	mkdir "$PREFIX"	# create the directory
fi

# check for and create if necessary 
# the file favorites
if ! [ -s "$MY_FAVORITES" ]
then
	>"$MY_FAVORITES"	# create the empty file
else
	exit 0 # This is not the first run
fi

yad --title "Radio Streamer - First Run" \
	--width=550 \
	--text="    As this is the first time that you have run Radio Streamer\n  \
     You need to choose a default favorite Radio Station\n \
        Please choose from the list that will now be shown" \
		--button="OK:1" \
		--button="Cancel:2"
if [[ $? == "1" ]]
then 
	add_station # add a station to the favorites file
	killall mplayer # play it
    mplayer -nolirc -msglevel all=0 "$s_url" &
    echo $s_url > $PREFIX/current_url # save it for next run
#    show_name
	exit 0
else
	exit 1 # user decided to cancel
fi
}

l_click () { # what to do on left mouse click - exit
	exec 3<> "$PIPE"	# make the redirection available within the function
	yad --title "Radio Streamer" \
		--text=" Do you really want to exit the application? " \
		--button="No:1" \
		--button="Yes:2" 
		
	if [[ $? = "1" ]]
	then
		exit
	else		
		echo "quit" >&3		# send yad the quit command
		killall mplayer
		rm -f "$PIPE"		# remove the fifo
	fi
}

get_station() { # get a station url from the list
chosen=$(cat "$STATION_LIST" |\
	awk -F, '{print $1"\n"$2"\n"$3"\n"$4}' | \
	sed 's/"//g' |\
	yad --list \
	--geometry=800x800 \
	--title='Internet Radio Stations' \
	--column Station_Name \
	--column Station_URL \
	--column Station_Genre \
	--column Station_Location \
	--hide-column=2 \
	--no-markup \
	--ellipsize=END \
	--expand-column=1 \
	--print-column=0 |\
	sed 's/|/,/g')
s_name=$(echo "$chosen" | awk -F, '{print $1}')
s_url=$(echo "$chosen" | awk -F, '{print $2}')
s_genre=$(echo "$chosen" | awk -F, '{print $3}')
s_location=$(echo "$chosen" | awk -F, '{print $4}')

export s_name
export s_url	
export s_genre	
export s_location	
}

play_favorite() { # choose a station to play
current=$(cat "$MY_FAVORITES" | \
	awk '!x[$0]++' | \
	awk -F, '{print $1"\n"$2"\n"$3"\n"$4}' | \
	yad --list \
	--geometry=800x800 \
	--title='Favorite Internet Radio Stations' \
	--column Station_Name \
	--column Station_URL \
	--column Station_Genre \
	--column Station_Location \
	--hide-column=2 \
	--no-markup \
	--ellipsize=END \
	--expand-column=1 \
	--print-column=2 |\
sed 's/|$//'
)	
echo $current > $PREFIX/current_url # save it for next run
killall mplayer
mplayer -nolirc -msglevel all=0 "$current" &
show_name
}

add_station() { # add a station from the list to your favorites
	get_station
    if [ -z $s_name ] # don't add empty lines
    then
        exit
    fi
	echo "$s_name,$s_url,$s_genre,$s_location">>"$MY_FAVORITES"
}

show_name() {
current_name=$(grep $(cat $PREFIX/current_url) $PREFIX/favorites | \
    awk -F, '{print $1}')
notify-send -t 3000 -i $ICON "Now playing from $current_name"
}

# make the functions available globally
export -f l_click
export -f get_station
export -f add_station
export -f play_favorite
export -f show_name

# is this the first run of the script?
if ! (first_run)
then
	exit # the user cancelled
fi

# set up the pipe mechanism
mkfifo "$PIPE"
exec 3<> "$PIPE"
 
# set up the tray object  
yad --notification \
	--kill-parent \
	--listen \
    --image="$ICON" \
    --text="$HINT" \
    --command="bash -c l_click" <&3 & 
 
# send the menu string to the tray object
echo "menu:$MENU" >&3
mplayer -nolirc -msglevel all=0 $(cat $PREFIX/current_url) &
show_name
