#!/bin/sh

if [ $# != 2 ]; then
echo "Usage: $0 [packagefilter] [makedepend]"
exit 0
fi

PKGNAMES=$(package-query -SAs -f "%n" "$1")
for PKGNAME in ${PKGNAMES}; do
{
wget -q -O - https://aur.archlinux.org/packages/${PKGNAME:0:2}/${PKGNAME}/PKGBUILD;
echo
echo "for dep in \"\${makedepends[@]}\"; do if [ \"\$dep\" == \"$2\" ]; then echo $PKGNAME; fi; done";
} | bash
done
