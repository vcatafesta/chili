#!/bin/bash

app=$1
rm -v "$app.pot"
mkdir -p locale
/usr/lib/python3.11/Tools/i18n/pygettext.py -o "locale/python.pot" *.py
bash --dump-po-strings "$app" >>locale/bash-files.pot
xgettext --package-name="$app" --no-location -L PO -o "locale/bash.pot" -i "locale/bash-files.pot"

rm locale/bash-files.pot
msgcat locale/*.pot >locale/"$app.pot"
rm locale/bash.pot locale/python.pot

for lang in {"en","es"}; do
	mkdir -p locale/$lang/$LC_MESSAGES
	if [ -e "locale/$lang/LC_MESSAGES/$app.po" ]; then
		msgmerge -o "locale/$lang/LC_MESSAGES/$app.po" "locale/$lang/LC_MESSAGES/$app.po" "locale/$app.pot"
		msgfmt -v "locale/$lang/LC_MESSAGES/$app.po" -o "locale/$lang/LC_MESSAGES/$app.mo"
		sudo install "locale/$lang/LC_MESSAGES/$app.mo" "/usr/share/locale/$lang/LC_MESSAGES/$app.mo"
	else
		msginit --no-translator -l "$lang" -i "locale/$app.pot" -o "locale/$lang/LC_MESSAGES/$app.po"
		sed -i 's|Content-Type: text/plain; charset=ASCII|Content-Type: text/plain; charset=utf-8|g' "locale/$lang/LC_MESSAGES/$app.po"
		msgfmt -v "locale/$lang/LC_MESSAGES/$app.po" -o "locale/$lang/LC_MESSAGES/$app.mo"
		sudo install "locale/$lang/LC_MESSAGES/$app.mo" "/usr/share/locale/$lang/LC_MESSAGES/$app.mo"
	fi
done
exit
