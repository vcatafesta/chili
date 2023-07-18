while read -r i; do
	pages=$(pdfinfo "$i" | grep Pages | awk '{print($2)}')
	printf "$i : $pages\n"
done < <(find -iname "*.pdf")
