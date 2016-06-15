#!/bin/bash
#

usage () {
  echo ""
  echo "[!] Usage: deploy.sh JAR ARTIFACT"
  echo ""
  echo "    Example: deploy.sh android-23.jar android:framework:23"
  echo ""
  exit 0
}

if [ ! -f "$1" ]; then
  usage
elif [ "$2" == "" ]; then
  usage
fi

IFS=':' read -ra ELEMENT <<< "${2}"
for i in "${ELEMENT[@]}"; do
    echo "Element: ${i}"
done

echo "Installing ${1} as ${2}"

mvn org.apache.maven.plugins:maven-install-plugin:2.5.2:install-file -DgroupId="${ELEMENT[0]}" \
  -DartifactId="${ELEMENT[1]}" -Dversion="${ELEMENT[2]}" -Dpackaging=jar -DlocalRepositoryPath="./" \
  -Dfile="${1}"
