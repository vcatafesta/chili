#!/bin/bash

retour=$(yad 						\
	--form 							\
	--center						\
	--field="BTN":BTN				\
	--field="CB":CB 				\
	--field="CBE":CBE 				\
	--field="CDIR":CDIR 			\
	--field="CE":CE 				\
	--field="CHK":CHK 				\
	--field="CLR":CLR 				\
	--field="DIR":DIR 				\
	--field="DT":DT 				\
	--field="FBTN":FBTN 			\
	--field="FL":field				\
	--field="FN":FBTN				\
	--field="H":H "gtk-cancel:1"	\
	"Valeur 1\!Valeur 2\!^Valeur 3\!Valeur 4"	\
	"Valeur 1\!Valeur 2\!Valeur 3\!Valeur 4"	\
	"$HOME/Documents/"							\
	"Texte libre."								\
	"TRUE"										\
	"#FA892F"									\
	"$HOME/Documents/"							\
	"12/11/2018"								\
	"Firefox"									\
	"$HOME/Documents/fichier.txt"				\
	"Sans Bold 12" "motdepasse")
echo "$retour"
