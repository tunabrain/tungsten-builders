ROOTDIR=`pwd`
BUILDER_ROOT=$ROOTDIR/builders
BUILD_ROOT=$ROOTDIR/builds
DO_VERIFY=true
DO_BUILD=true
BUILDERS=

while [ "$1" != "" ]; do
    case $1 in
        -v | --verify )         DO_BUILD=false;;
        -b | --build )          DO_VERIFY=false;;
        * )                     BUILDERS="$BUILDERS $1"
    esac
    shift
done

if [ ${#BUILDERS[@]} -eq 0 ]; then
    BUILDERS=`for i in builders/* ; do basename $i ; done`
fi

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
    if $DO_BUILD;  then docker run --privileged --rm -w "/home/tungsten" -v $TUNGSTEN_PATH:/tungsten:ro                -v $BUILDER_ROOT/$BUILDER/build/buildtools:/buildtools:ro  -v $BUILD_ROOT/$BUILDER/packages:/build-output -e VERSION=$VERSION tungsten-$BUILDER-build  &>$BUILD_ROOT/$BUILDER/logs/${VERSION}-build.log  ; fi
    if $DO_VERIFY; then docker run              --rm -w "/home/tungsten" -v $BUILD_ROOT/$BUILDER/packages:/packages:ro -v $BUILDER_ROOT/$BUILDER/verify/buildtools:/buildtools:ro -v $BUILD_ROOT/$BUILDER/renders:/verify-output -e VERSION=$VERSION tungsten-$BUILDER-verify &>$BUILD_ROOT/$BUILDER/logs/${VERSION}-verify.log ; fi
done

rm -rf $TUNGSTEN_PATH
