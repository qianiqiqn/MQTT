#!/usr/bin/env bash
base_dir=$(dirname $0)
echo ${base_dir}
echo `whoami`
cd ${base_dir}
cd ..

SERVERJAR=`ls *.jar`
DEPLOY_DIR=`pwd`

if [ ! -f "${DEPLOY_DIR}/$SERVERJAR" ];then
echo $SERVERJAR"文件不存在"
exit 1
fi

echo "JAVA_HOME = $JAVA_HOME"

if [ ! -f "$JAVA_HOME/bin/java" ];then
JAVA_HOME=/data/jdk1.8
echo "JAVA_HOME 不存在, 设置为$JAVA_HOME"
if [ ! -f "$JAVA_HOME/bin/java" ];then
JAVA_HOME=/data/jdk1.8
echo "JAVA_HOME 不存在, 退出程序"
exit 1
fi
fi



PID=$(ps -ef | grep "$SERVERJAR" | grep -v grep | awk '{ print $2}')
echo "$PID"

if [ -z "$PID" ]; then
    echo "Application has already stopped."
else
    echo "kill $PID"
    kill -9 $PID && echo "Send stopping signal to server successful."


    #wait server stop

    LOOPS=0
    while(true)
    do
        PID=$(ps -ef | grep "$SERVERJAR" | grep -v grep | awk '{print $2}')
        if [ -z "$PID" ]; then
            echo "Stop server successful! Cost $LOOPS seconds."
            break;
        fi
        #judge time out

        if [ "$LOOPS" -gt 60 ]; then
            echo "$Stop server cost time over 60 seconds. Now force stop it."
            kill -9 $PID && echo "Force stop successful."
            break;
        else
            echo "Cost $LOOPS seconds."
        fi

        let LOOPS=LOOPS+1
        sleep 1
    done
fi

JAVA_OPTS="-server -Xms2g -Xmx2g -Xmn512m -XX:PermSize=128M -XX:MaxNewSize=512m -XX:MaxPermSize=256m -Xss256k -Djava.awt.headless=true -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=${DEPLOY_DIR}/logs/heapdump.dump -XX:+CMSClassUnloadingEnabled -XX:+CMSPermGenSweepingEnabled -Xloggc:${DEPLOY_DIR}/logs/gc.log"

$JAVA_HOME/bin/java $JAVA_OPTS -jar ${DEPLOY_DIR}/$SERVERJAR

echo "start finished!"