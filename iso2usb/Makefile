###############################################
#           build options                     #
###############################################
#
####### Building iso2usb support ########
#
#

SHELL=/bin/bash
DESTDIR=
BINDIR=${DESTDIR}/opt/iso2usb
INFODIR=${DESTDIR}/usr/share/doc/iso2usb
MODE=775
DIRMODE=755

.PHONY: build

install:
	mkdir -p ${BINDIR}
	install -m ${MODE} src/iso2usb ${BINDIR}/iso2usb
	install -m ${MODE} src/pendrive.png ${BINDIR}/pendrive.png
	install -m ${MODE} src/iso2usb.desktop ${DESTDIR}/usr/share/applications/iso2usb.desktop
	mkdir -p ${INFODIR}
	cp ChangeLog INSTALL LICENSE MAINTAINERS README.md ${INFODIR}/
	@echo "Software was installed in ${BINDIR}"

uninstall:
	rm ${BINDIR}/iso2usb
	rm ${BINDIR}/pendrive.png
	rm ${DESTDIR}/usr/share/applications/iso2usb.desktop
	rm -rf ${INFODIR}
	@echo "Software was removed."


