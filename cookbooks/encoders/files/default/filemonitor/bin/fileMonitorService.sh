#!/bin/sh

# SEE http://stackoverflow.com/questions/7687159/how-to-convert-a-java-program-to-daemon-with-jsvc
# SEE http://blog.widenhome.com/2011/06/28/how-to-install-jsvc-on-linux/

# Setup variables
EXEC=/usr/bin/jsvc
JAVA_HOME=/usr/java/jdk
PROJECT_HOME=/data/apps/filemonitor
CLASS_PATH=$PROJECT_HOME/lib/commons-daemon-1.0.3.jar:$(echo $PROJECT_HOME/lib/*.jar | tr ' ' ':')
CLASS=com.clearchannel.customtalk.ingester.util.FileMonitor
USER=converter
PID=/tmp/filemonitor.pid
CONFIG=-DconfigFile=/Utility/Config/filemonitors.cfg
LOG_OUT=/var/log/filemonitor/filemonitor.log
LOG_ERR=/var/log/filemonitor/filemonitor.error.log
#LOG_OUT=./out.log
#LOG_ERR=./error.log


echo $CLASS_PATH

do_exec()
{
    $EXEC   -home "$JAVA_HOME" -cp $CLASS_PATH $CONFIG  -Xdebug -Xnoagent -Xrunjdwp:transport=dt_socket,address=8000,server=y,suspend=n -user $USER -outfile $LOG_OUT -errfile $LOG_ERR -pidfile $PID $1 $CLASS
    #$EXEC -debug   -home "$JAVA_HOME" -cp $CLASS_PATH  -user $USER  -pidfile $PID $1 $CLASS
}

case "$1" in
    start)
        do_exec
            ;;
    stop)
        do_exec "-stop"
            ;;
    restart)
        if [ -f "$PID" ]; then
            do_exec "-stop"
            do_exec
        else
            echo "service not running, will do nothing"
            exit 1
        fi
            ;;
    *)
            echo "usage: daemon {start|stop|restart}" >&2
            exit 3
            ;;
esac
