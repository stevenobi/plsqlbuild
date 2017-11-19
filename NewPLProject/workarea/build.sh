#!/bin/bash
########################################################################
#
# Build SQL and PL/SQL Bundles
#
# @date: 2017/11/18
# @author: Stefan Obermeyer
#
# @description: Purpose fo this script is to build one install.sql bundle
# from a project or a set of install scripts that run in specific order
# to fulfill dependencies (see THIS_MODULES) . SQL Installs should run
# non-desctructive, so if objects are found they will not be replaced,
# except some drop_* option is specified.
#
# This script will create a running buildnumber in a file defined by
# THIS_BUILDFILE and commit this file together with it's GitLog to the
# Repository this project lives in. If You wanna reset Your builds,
# just edit or remove THIS_BUILDFILE which contains a JSON that describes
# this application build. The final Buildversion is made up in this format:
# Version_BuildNumber.Timestamp, f.e. Version 1.0.0_0027.1711190000
#
# DISCLAIMER: this script comes "as is" and no gurantees are provided,
# so always make a backup of your data before using this install script!
#
# @requires: Oracle SQLCL (sql shell), git (cmd bash) and md5 (macosx)
#            in current PATH environment.
#            User's profile is sourced.
#
#set -x
########################################################################

clear

########################################################################

THIS_PACKAGE="APX"
THIS_VERSION="1.0.0"
THIS_MODEL="Application Modules"
## Provide a Build Comment here or as 1st arg on commandline
[[ -z ${1} ]] && THIS_BUILD_COMMENT="New Build"|| \
 THIS_BUILD_COMMENT=`echo ${1}`;
## Runtime will work on these scripts in the order tehy are specified //build.drop.sql
THIS_MODULES="build.sql ./model/sql_drop.sql ./model/sql_create.sql"

########################################################################

HOME=`echo ${HOME}`
PROFILE=${HOME}/.bash_profile

USR=apxusr
PWD=${USR} ## don't do this in production!!!
CONN=ol7:1522/apex51 ## using SQLCL EZConnect Syntax

########################################################################

THIS_BANNER="${THIS_PACKAGE} ${THIS_MODEL}";

########################################################################

source ${PROFILE}

BIN=${HOME}/bin
SQL=${BIN}/sqlcl/bin/sql
GIT=`which git`
MD5=`which md5`
BLD="build"

########################################################################

THIS_DIR="`pwd`";
THIS_BUILDFILE="./.${BLD}file";
THIS_GIT_LOG="./.buildgit";
THIS_DATE=`date "+%y%m%d%H%M"`;

########################################################################

[[ -a ${THIS_BUILDFILE} ]] && {
    ## replacing leading 0's and "" globally to convert build to integer
    THIS_BUILD="`cat ${THIS_BUILDFILE}|grep "${BLD}"|grep -v grep|cut -f2 -d:| \
    cut -f1 -d,|awk '{$1=$1};1'| sed -e 's/"//g' -e 's/^0*//'`";
    THIS_BUILD=`echo $((THIS_BUILD+1))`;
    THIS_BUILD=$(printf %04d ${THIS_BUILD});

} || {
    THIS_BUILD=0001;
    touch ${THIS_BUILDFILE};
    [[ -x ${GIT} ]] && ${GIT} add ${THIS_BUILDFILE};
}

########################################################################

[[ -x ${MD5} ]] && \
THIS_CHECKSUM=`echo "${THIS_BANNER}.${THIS_VERSION}.${THIS_BUILD}.${THIS_DATE}" | ${MD5}` ||
THIS_CHECKSUM="${THIS_BUILD}.${THIS_DATE}";
THIS_BUILD_COMMENT="${THIS_BUILD_COMMENT}";

echo '{ "application": "'${THIS_BANNER}'",'              > ${THIS_BUILDFILE}
echo '  "version": "'${THIS_VERSION}'",'                >> ${THIS_BUILDFILE}
echo '  "release": '                                    >> ${THIS_BUILDFILE}
echo '    { "build": "'${THIS_BUILD}'",'                >> ${THIS_BUILDFILE}
echo '      "comment": "'${THIS_BUILD_COMMENT}'",'      >> ${THIS_BUILDFILE}
echo '      "checksum": "'${THIS_CHECKSUM}'" '          >> ${THIS_BUILDFILE}
echo '    }'                                            >> ${THIS_BUILDFILE}
echo '}'                                                >> ${THIS_BUILDFILE}

THIS_VERSION="${THIS_VERSION}_${THIS_BUILD}.${THIS_DATE}";

########################################################################
## making Gitty move :-)

[[ -x ${GIT} ]] && ${GIT} add ${THIS_BUILDFILE}
#[[ -x ${GIT} ]] && ${GIT} commit -m "${THIS_BUILD_COMMENT}: ${THIS_VERSION}" ${THIS_BUILDFILE} \
echo "${THIS_BUILD_COMMENT}: " > ${THIS_GIT_LOG}
# create build.json for later review or use by node.js or similar
cp -p ${THIS_BUILDFILE} ./${BLD}.json;
[[ -x ${GIT} && -a ${BLD}.json ]] && ${GIT} add ${BLD}.json;
#[[ -x ${GIT} ]] && ${GIT} commit -m "Latest Build: ${THIS_VERSION} ${THIS_CHECKSUM}" ${BLD}.json \
# > ${THIS_GIT_LOG}
[[ -x ${GIT} && -a ${THIS_GIT_LOG} ]] && ${GIT} add ${THIS_GIT_LOG};
# commit all changes in this sub/directory first
[[ -x ${GIT} ]] && ${GIT} commit -m "Pre Build Commit: ${THIS_BUILD_COMMENT}: ${THIS_VERSION}" . \
 > ${THIS_GIT_LOG}

[[ -x ${GIT} && -a ${THIS_GIT_LOG} ]] && THIS_COMMIT=`cat ${THIS_GIT_LOG} | head -n1 |cut -f1-2 -d\ `;

########################################################################

echo "" && echo "`date "+%d.%m.%Y %H:%M:%S"` *** ${THIS_BANNER} \
Install | Build: ${THIS_VERSION} | Commit: ${THIS_COMMIT} ***" && \
echo "" | tee -a ${THIS_GIT_LOG}

########################################################################

for m in ${THIS_MODULES}; do
  $SQL -s ${USR}/${PWD}@${CONN} @${m} "${THIS_BANNER}" "${THIS_VERSION}"
done;

########################################################################

echo "" && echo "`date "+%d.%m.%Y %H:%M:%S"` *** DONE Status ($?)" && \
echo "" && echo "*** $? ${THIS_BANNER} \
Install End | Build: ${THIS_VERSION} | Commit: ${THIS_COMMIT} ***" && \
echo "" | tee -a ${THIS_GIT_LOG}

# commit all changes from this build
[[ -x ${GIT} ]] && ${GIT} commit -m "Latest Build Commit: ${THIS_VERSION}" ${THIS_GIT_LOG} >/dev/null;

########################################################################

exit $?
