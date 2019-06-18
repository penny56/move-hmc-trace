# move
Run the hmcdebuginfo, then move and tar the log files
### Quickstart
Run the script directly without option
```sh
[hmcmanager@M257-/home/hmcmanager]./trace.sh
==> hmcdebuginfo ...
==> hmcdebuginfo ... done
==> create /tmp/yj directory ...
==> create /tmp/yj directory ... done
==> move and tar iqzdtrac.trm ...
./trace.sh: line 36: /tmp/yj/iqzdtrac.trm: Permission denied
==> move and tar iqzdtrac.trm ... done
==> move and tar iqyy log ...
./trace.sh: line 48: /tmp/yj/iqyyalt.log: Permission denied
==> move and tar iqyy log ... done

==> The traces:
total 86M
-rw-r--r--. 1 hmcmanager nobody 74M Jun 18 05:34 iqyy-M257.tar.gz
-rw-r--r--. 1 hmcmanager nobody 13M Jun 18 05:34 iqzdtrac-M257.trm.gz
[hmcmanager@M257-/home/hmcmanager]
```
