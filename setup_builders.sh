BUILDERS=`for i in builders/* ; do basename $i ; done`
GID=`id -g`

for BUILDER in $BUILDERS; do
    for TYPE in build verify; do
        sed -e s/{GROUPID}/$GID/ -e s/{USERID}/$UID/ builders/$BUILDER/$TYPE/Dockerfile.template > builders/$BUILDER/$TYPE/Dockerfile
        docker build -t tungsten-$BUILDER-$TYPE builders/$BUILDER/$TYPE
    done
done
