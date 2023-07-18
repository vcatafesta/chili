str="python-zope-proxy-4.3.5-1-x86_64.chi.zst"

block1="${str//-[0-9].*/}"
block2="${str//${block1}-/}"
block2="${block2%-*}"
block3="${block2%%-*}"
block4="${block2#*-}"
block5="${str//${block1}-${block2}-/}"
block5="${block5%%.*}"

echo "block1:${block1}:"
echo "block2:${block2}:"
echo "block3:${block3}:"
echo "block4:${block4}:"
echo "block5:${block5}:"

for str in "python-4.3.5-1-x86_64.chi.zst" "python-zope-4.3.5-1-x86_64.chi.zst" "python-zope-proxy-4.3.5-1-x86_64.chi.zst"
do
	echo "+++++++++++ ${str}"
	block1="${str//-[0-9].*/}"
	block2="${str//${block1}-/}"
	block2="${block2%-*}"
	block3="${block2%%-*}"
	block4="${block2#*-}"
	block5="${str//${block1}-${block2}-/}"
	block5="${block5%%.*}"

	echo "block1:${block1}:"
	echo "block2:${block2}:"
	echo "block3:${block3}:"
	echo "block4:${block4}:"
	echo "block5:${block5}:"
done
