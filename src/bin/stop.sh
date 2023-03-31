#!/usr/bin/env bash
#source $(dirname $0)/../../env.sh
base_dir=$(dirname $0)
cd ${base_dir}
cd ..
SERVERJAR=`ls *.jar`

if [ -r "$base_dir/setenv.sh" ]; then
	 echo -e "come get data start"
    . "$base_dir/setenv.sh"
	echo -e "come get data end "
fi

PID=$(ps -ef | grep "$SERVERJAR" | grep -v grep | awk '{ print $2}')

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

        if [ "$LOOPS" -gt 180 ]; then
            echo "$Stop server cost time over 180 seconds. Now force stop it."
            kill -9 $PID && echo "Force stop successful."
            break;
        else
            echo "Cost $LOOPS seconds."
        fi

        let LOOPS=LOOPS+1
        sleep 1
    done
fi