import glob
import os


def tree(folder):
	for i in glob.glob(os.path.join(folder, '*')):
		print(i)

if __name__ == '__main__':
	import sys
	tree(sys.argv[1])
