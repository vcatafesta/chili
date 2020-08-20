

try:
    from urllib import parse
except ImportError:
    from urllib2 import urlparse as parse
