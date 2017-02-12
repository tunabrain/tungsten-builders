set -eu
sudo dpkg --unpack /packages/tungsten_${VERSION}*.deb
sudo apt-get install -f -y
tungsten /usr/share/tungsten/materialtest/materialtest.json -d /verify-output -o tungsten-$VERSION.png
