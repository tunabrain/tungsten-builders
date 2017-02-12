set -eu
TUNGSTEN_DIR=tungsten-${VERSION}
cp -R /tungsten $TUNGSTEN_DIR
cp -R /buildtools/debian $TUNGSTEN_DIR
cd $TUNGSTEN_DIR
/buildtools/generate-changelog.sh > debian/changelog
yes | debuild -us -uc -j4
cp ../tungsten*.deb ../tungsten*.dsc ../tungsten*.tar.* /build-output
