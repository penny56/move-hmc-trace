#! /bin/bash

# UPdated on Jun. 20 2019 --- Use work directory variable
# Created on Jun. 18 2019

# parameters
hostname=`hostname`
workDir="/tmp/yj/"

function usage() {
    echo
    echo "Move the trace files to target."
    echo "Optionally, we need open \"Perform Console Trace\" task to generate iqzdtrac.trm trace."
    echo "And then, we run hmcdebuginfo to generate the hmcdebuginfo...tgz and iqyy trace."
    echo "Usage: $0"
    echo
}

# run the hmcdebuginfo
echo "hmcdebuginfo ..."
`hmcdebuginfo`
echo "hmcdebuginfo ... done"
sleep 1s

# remove and new create work directory
echo "create $workDir directory ..."
`rm -rf $workDir`
`mkdir $workDir`
echo "create $workDir directory ... done"
sleep 1s

# move and tar the iqzdtrac.trm file, generated from Perform Console Trace task
echo "move and tar iqzdtrac.trm ..."
if [[ -f /ffdc/trace/iqzdtrac.trm ]]
then
    `cp /ffdc/trace/iqzdtrac.trm $workDir`
    zipname="iqzdtrac-"$hostname".trm.gz"
    `tar -zcvPf $workDir$zipname ${workDir}iqzdtrac.trm`
fi
echo "move and tar iqzdtrac.trm ... done"
sleep 1s

# move and tar the iqyy log, generated from hmcdebuginfo
echo "move and tar iqyy log ..."
`cp /console/data/iqyy*.log  $workDir`
zipname="iqyy-"$hostname".tar.gz"
`tar -zcvPf $workDir$zipname ${workDir}iqyy*.log`
echo "move and tar iqyy log ... done"
sleep 1s

# remove the useless log files and show
`rm -f ${workDir}*.log`
`rm -f ${workDir}*.trm`
echo
echo "The traces:"
echo "$(ls -lh $workDir)"
