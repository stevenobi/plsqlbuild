#!/bin/bash
########################################################################
#
# Build SQL and PL/SQL Bundles
#
# @date: 2017/11/18
# @author: Stefan Obermeyer
#
# @description: Purpose fo this script is to build one build.sql bundle
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
# @requires: sed, cat, tee, chmod
#
#set -x
########################################################################

clear

########################################################################

SED=`which sed`
TEE=`which tee`
CAT=`which cat`
BLD="build"
BUILDFILE=${BLD}".lst"
SQLBUILD=${BLD}".sql"
THIS_DATE=`date "+%y.%m.%d %H:%M"`;

[ ! -z ${1} ] && PRJ=${1} || PRJ="Project"
[ ! -z ${2} ] && SQLDROPFILE=${2} || SQLDROPFILE="sql_drop.sql"
[ ! -z ${3} ] && SQLCREATEFILE=${3} || SQLCREATEFILE="sql_create.sql"

########################################################################


echo "${THIS_DATE} ${SQLCREATEFILE} "

${CAT} ${SQLCREATEFILE} | grep @ | egrep -v ^-| cut -f2 -d@ | \
${SED} -e 's/ /\\\ /g' -e 's/^"//' -e 's/"$//' -e 's/^/cat /g' > ${BUILDFILE}

chmod +x ${BUILDFILE}

## create ${SQLBUILD} file
echo "" | ${TEE} ${SQLBUILD}
echo "---------------------------------------------------------------" | ${TEE} -a ${SQLBUILD}
echo "       ---- ${THIS_DATE} Begin of SQL Build ${PRJ} ----" | ${TEE} -a ${SQLBUILD}
echo "" >> ${SQLBUILD}
echo "whenever oserror exit" >> ${SQLBUILD}
echo "whenever sqlerror exit sql.sqlcode;" >> ${SQLBUILD}

${CAT} ${SQLDROPFILE} >> ${SQLBUILD}
echo "" >> ${SQLBUILD}
./${BUILDFILE} >> ${SQLBUILD}

echo "" >> ${SQLBUILD}
echo "       ---- ${THIS_DATE}  End of SQL Build ${PRJ}  ----" | ${TEE} -a ${SQLBUILD}
echo "---------------------------------------------------------------" | ${TEE} -a ${SQLBUILD}
echo "" | ${TEE} -a ${SQLBUILD}

exit ${?}
