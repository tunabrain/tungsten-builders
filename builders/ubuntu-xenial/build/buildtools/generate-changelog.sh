set -eu
NOW=`date '+%a, %d %b %Y %H:%M:%S +0000'`
DESC=$(git log `git describe --tags --abbrev=0`..HEAD --oneline --no-merges --pretty=format:'  * %s')
echo "tungsten (${VERSION}) xenial; urgency=low"
echo ""
git log `git describe --tags --abbrev=0`..HEAD --oneline --no-merges --pretty=format:'  * %s'
echo "\n"
echo " -- Benedikt Bitterli <benedikt.bitterli@gmail.com>  ${NOW}"
