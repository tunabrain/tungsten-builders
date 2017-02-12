set -eu
. /etc/lsb-release
NOW=`date '+%a, %d %b %Y %H:%M:%S +0000'`
echo "tungsten (${VERSION}~${DISTRIB_CODENAME}1) ${DISTRIB_CODENAME}; urgency=low"
echo ""
git log `git describe --tags --abbrev=0`..HEAD --oneline --no-merges --pretty=format:'  * %s'
echo "\n"
echo " -- Benedikt Bitterli <benedikt.bitterli@gmail.com>  ${NOW}"
