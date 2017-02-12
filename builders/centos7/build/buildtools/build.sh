set -eu
mkdir -p rpmbuild/SOURCES
cd rpmbuild
tar --transform "s,^tungsten/,tungsten-${VERSION}/,g" -cvzf SOURCES/tungsten-$VERSION.tar.gz /tungsten --exclude-vcs
sed s/{VERSION}/$VERSION/g /buildtools/tungsten.spec > tungsten.spec
rpmbuild -bs --define 'dist .centos7' tungsten.spec
/usr/bin/mock -r centos-7-x86_64 /home/tungsten/rpmbuild/SRPMS/tungsten-$VERSION-1.centos7.src.rpm
cat /var/lib/mock/centos-7-x86_64/result/build.log
cp /var/lib/mock/centos-7-x86_64/result/tungsten-$VERSION*.rpm /build-output


