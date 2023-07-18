for i in {a..z}
do
	cd $i
	rm *.pkg.tar.zst
	cd ../
done
