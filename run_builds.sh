ROOTDIR=`pwd`
BUILDER_ROOT=$ROOTDIR/builders
BUILD_ROOT=$ROOTDIR/builds
BUILDERS=`for i in builders/* ; do basename $i ; done`

mkdir -p $BUILD_ROOT

git clone https://github.com/tunabrain/tungsten $BUILD_ROOT/tungsten
cd $BUILD_ROOT/tungsten
VERSION=$(git describe --tags | grep -o -P "[0-9]+\\.[0-9]+\\.[0-9]+(-[0-9]+)?" | sed 's/-/+/')
cd $ROOTDIR
TUNGSTEN_DIR=tungsten-$VERSION
TUNGSTEN_PATH=$BUILD_ROOT/$TUNGSTEN_DIR
rm -rf $TUNGSTEN_PATH
mv $BUILD_ROOT/tungsten $TUNGSTEN_PATH

for BUILDER in $BUILDERS; do
    mkdir -p $BUILD_ROOT/$BUILDER/logs
    mkdir -p $BUILD_ROOT/$BUILDER/packages
    mkdir -p $BUILD_ROOT/$BUILDER/renders
    docker run --privileged --rm -w "/home/tungsten" -v $TUNGSTEN_PATH:/tungsten:ro                -v $BUILDER_ROOT/$BUILDER/build/buildtools:/buildtools:ro  -v $BUILD_ROOT/$BUILDER/packages:/build-output -e VERSION=$VERSION tungsten-$BUILDER-build  &>$BUILD_ROOT/$BUILDER/logs/${VERSION}-build.log
    docker run              --rm -w "/home/tungsten" -v $BUILD_ROOT/$BUILDER/packages:/packages:ro -v $BUILDER_ROOT/$BUILDER/verify/buildtools:/buildtools:ro -v $BUILD_ROOT/$BUILDER/renders:/verify-output -e VERSION=$VERSION tungsten-$BUILDER-verify &>$BUILD_ROOT/$BUILDER/logs/${VERSION}-verify.log
done

rm -rf $TUNGSTEN_PATH
