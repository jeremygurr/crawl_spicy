#!/bin/sh

WEBBASE=/usr/local/apache2/htdocs
RCDIR=$WEBBASE/rcs/
INPROGRESSDIR=$WEBBASE/rcs/running
TTYRECDIR=$WEBBASE/rcs/ttyrecs/$1
DEFAULT_RC=$WEBBASE/init.txt
PLAYERNAME=$1

mkdir -p $RCDIR
mkdir -p $INPROGRESSDIR
mkdir -p $TTYRECDIR

if [ ! -f ${RCDIR}/${PLAYERNAME}.rc ]; then
    cp ${DEFAULT_RC} ${RCDIR}/${PLAYERNAME}.rc
fi
