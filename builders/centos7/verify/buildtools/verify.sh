sudo yum -y install /packages/tungsten-${VERSION}-*.x86_64.rpm
tungsten /usr/share/tungsten/materialtest/materialtest.json -d /verify-output -o tungsten-$VERSION.png
