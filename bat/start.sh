#!/bin/bash
# $Id: start.sh 6196 2022-03-15 14:29:43Z maess $

called=$_
if [ -z "$BATDIR" ] ; then
    if [ $called != $0 ] ; then
        BATDIR=`dirname $BASH_SOURCE`                  # relative
    else
        BATDIR=`dirname $0`                            # relative
    fi
    export BATDIR=`(builtin cd $BATDIR && pwd )`/  # absolutized and normalized
    if [ -z "$BATDIR" ] ; then
        # error; for some reason, the path is not accessible
        # to the script (e.g. permissions re-evaled after suid)
        exit 1  # fail
    fi
fi
export DDIR=`(builtin cd $BATDIR/../.. && pwd )`/  # normalized
export EXPNAME=mirror
export EXPSUBJ=mr
export TEMP=`(builtin cd $BATDIR/.. && pwd )`/  # normalized
export EXPDIR=${DDIR}

echo "EXPDIR:   " $EXPDIR " EXPNAME: " $EXPNAME " EXPSUBJ: " $EXPSUBJ
export BATDIR=${TEMP}bat/
echo "BATDIR:   " $BATDIR
export CFGDIR=${TEMP}cfg/
echo "CFGDIR:   " $CFGDIR
export MATLAB_VERSION=9.13
export MATLAB_REV=R2022b
export MATLAB_PREFDIR=${EXPDIR}.matlab_${USER}/${MATLAB_REV}
MATLAB -v $MATLAB_VERSION matlab

#MLPTEMP=${EXPDIR}matlab
#if [ -h $MLPTEMP ]
#then 
#   cd `readlink $MLPTEMP`
#   export MATLABPATH=${MATLABPATH}:`pwd`
#   cd -
#else 
#   export MATLABPATH=${MATLABPATH}:${EXPDIR}matlab:${EXPDIR}matlab/lib
#fi

#echo " "
#echo "Matlab activated - Version: ${MATLAB_VERSION} (${MATLAB_REV})"
#echo " "

hoststr=`host $HOSTNAME`
hostip=`perl -e 'printf "%s",$ARGV[3];' $hoststr`
network=`perl -e '@a=split(/\./,$ARGV[0]); printf"%s.%s.%s",$a[0],$a[1],$a[2]' $hostip`

#source /afs/cbs.mpg.de/software/scripts/MATLAB -v $MATLAB_VERSION
if [[ "$0" == "$called" ]]; then
cd $TEMP
$SHELL
fi

