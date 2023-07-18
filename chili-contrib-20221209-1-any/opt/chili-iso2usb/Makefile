###############################################
#           build options                     #
###############################################
#
####### Building iso2usb support ########
#
#

SHELL=/bin/bash
DESTDIR=
BINDIR=${DESTDIR}/opt/chili-iso2usb
INFODIR=${DESTDIR}/usr/share/doc/chili-iso2usb
MODE=775
DIRMODE=755

.PHONY: build

install:
	mkdir -p ${BINDIR}
	install -m ${MODE} chili-iso2usb ${BINDIR}/
	install -m ${MODE} pendrive.png ${BINDIR}/
	install -m ${MODE} chili-iso2usb.desktop ${BINDIR}/
	install -m ${MODE} chili-iso2usb.desktop ${DESTDIR}/usr/share/applications/chili-iso2usb.desktop
	mkdir -p ${INFODIR}
	cp ChangeLog.txt INSTALL LICENSE MAINTAINERS README.md ${INFODIR}/
	@echo "Software was installed in ${BINDIR}"

uninstall:
	rm ${BINDIR}/chili-iso2usb
	rm ${BINDIR}/pendrive.png
	rm ${BINDIR}/chili-iso2usb.desktop
	rm ${DESTDIR}/usr/share/applications/chili-iso2usb.desktop
	rm -rf ${INFODIR}
	@echo "Software was removed."


