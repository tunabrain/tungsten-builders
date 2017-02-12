set -eu
sudo dpkg --unpack /packages/tungsten_${VERSION}_amd64.deb
sudo apt-get install -f -y
tungsten /usr/share/tungsten/materialtest/materialtest.json -d /verify-output -o tungsten-$VERSION.png
