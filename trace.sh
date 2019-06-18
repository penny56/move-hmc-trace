#! /bin/bash

# Created on Jun. 18 2019

# parameters for hostname
hostname=`hostname`

function usage() {
    echo
    echo "Move the trace files to target."
    echo "Optionally, we need open \"Perform Console Trace\" task to generate iqzdtrac.trm trace."
    echo "And then, we run hmcdebuginfo to generate the hmcdebuginfo...tgz and iqyy trace."
    echo "Usage: $0"
    echo
}

# run the hmcdebuginfo
echo "==> hmcdebuginfo ..."
`hmcdebuginfo`
echo "==> hmcdebuginfo ... done"
sleep 1s

# remove and new create work directory
echo "==> create /tmp/yj directory ..."
`rm -rf /tmp/yj`
`mkdir /tmp/yj`
echo "==> create /tmp/yj directory ... done"
sleep 1s

# move and tar the iqzdtrac.trm file, generated from Perform Console Trace task
echo "==> move and tar iqzdtrac.trm ..."
if [[ -f /ffdc/trace/iqzdtrac.trm ]]
then
    `cp /ffdc/trace/iqzdtrac.trm /tmp/yj/`
    zipname="iqzdtrac-"$hostname".trm.gz"
    `tar -zcvPf /tmp/yj/$zipname /tmp/yj/iqzdtrac.trm`
    echo "==> move and tar iqzdtrac.trm ... done"
else
    echo "==> move and tar iqzdtrac.trm ... file not exist"
fi

sleep 1s

# move and tar the iqyy log, generated from hmcdebuginfo
echo "==> move and tar iqyy log ..."
`cp /console/data/iqyy*.log  /tmp/yj`
zipname="iqyy-"$hostname".tar.gz"
`tar -zcvPf /tmp/yj/$zipname /tmp/yj/iqyy*.log`
echo "==> move and tar iqyy log ... done"
sleep 1s

# remove the useless log files and show
`rm -f /tmp/yj/*.log`
`rm -f /tmp/yj/*.trm`
echo
echo "==> The traces:"
echo "$(ls -lh /tmp/yj)"
