wget https://bootstrap.pypa.io/get-pip.py
sudo python2.7 get-pip.py

python -m pip uninstall pip
python -m pip install pip==9.0.3

from pip._internal import main
if __name__ == '__main__':
    sys.exit(main())


