#!/bin/bash
# /etc/init.d/minecraft
# version 0.5 2011-09-24 (YYYY-MM-DD)

### BEGIN INIT INFO
# Provides:   minecraft
# Required-Start: $local_fs $remote_fs
# Required-Stop:  $local_fs $remote_fs
# Should-Start:   $network
# Should-Stop:    $network
# Default-Start:  2 3 4 5
# Default-Stop:   0 1 6
# Short-Description:    Minecraft server
# Description:    Starts the minecraft server
### END INIT INFO

#Settings
SERVICE='craftbukkit-beta_1.4.6-R0.3.jar'
USERNAME="minecraft"
MCSTORE='/home/minecraft/minecraft'
MCPATH='/home/minecraft/minecraft_ramdisk'
CPU_COUNT=1
INVOCATION="java -Xmx2048M -Xms2048M -XX:+UseConcMarkSweepGC -XX:+CMSIncrementalPacing -XX:ParallelGCThreads=$CPU_COUNT -XX:+AggressiveOpts -jar $SERVICE"
BACKUPPATH='/home/minecraft/minecraft_backups/'


ME=`whoami`
as_user() {  
  if [ "$ME" == "$USERNAME" ] ; then
    bash -c "$1"
  else
    su - $USERNAME -c "$1"
  fi
}

mc_start() {
  if ps ax | grep -v grep | grep -v -i SCREEN | grep $SERVICE > /dev/null
  then
    echo "Tried to start but $SERVICE was already running!"
  else
    echo "$SERVICE was not running... starting."
    chown $USERNAME:$USERNAME $MCPATH   
    if [ ! -f "$MCPATH/$SERVICE" ]
    then 
      echo "Ram drive empty...  prepping."
      as_user "cp -R $MCSTORE/* $MCPATH/"
    fi
    as_user "cd $MCPATH && screen -dmS minecraft $INVOCATION"
    sleep 30
    if ps ax | grep -v grep | grep -v -i SCREEN | grep $SERVICE > /dev/null
    then
      echo "$SERVICE is now running."
    else
      echo "Could not start $SERVICE."
    fi
  fi
}

mc_saveoff() {
        if ps ax | grep -v grep | grep -v -i SCREEN | grep $SERVICE > /dev/null
        then
                echo "$SERVICE is running... suspending saves"
                as_user "screen -p 0 -S minecraft -X eval 'stuff \"say SERVER BACKUP STARTING. Server going readonly...\"\015'"
                as_user "screen -p 0 -S minecraft -X eval 'stuff \"save-off\"\015'"
                as_user "screen -p 0 -S minecraft -X eval 'stuff \"save-all\"\015'"
                sync
                sleep 10
        else
                echo "$SERVICE was not running. Not suspending saves."
        fi
}

mc_saveon() {
        if ps ax | grep -v grep | grep -v -i SCREEN | grep $SERVICE > /dev/null
        then
                echo "$SERVICE is running... re-enabling saves"
                as_user "screen -p 0 -S minecraft -X eval 'stuff \"save-on\"\015'"
                as_user "screen -p 0 -S minecraft -X eval 'stuff \"say SERVER BACKUP ENDED. Server going read-write...\"\015'"
        else
                echo "$SERVICE was not running. Not resuming saves."
        fi
}

mc_stop() {
        if ps ax | grep -v grep | grep -v -i SCREEN | grep $SERVICE > /dev/null
        then
                echo "$SERVICE is running... stopping."
                as_user "screen -p 0 -S minecraft -X eval 'stuff \"say SERVER SHUTTING DOWN IN 5 SECONDS. Saving map...\"\015'"
                as_user "screen -p 0 -S minecraft -X eval 'stuff \"save-all\"\015'"
                sleep 5
                as_user "screen -p 0 -S minecraft -X eval 'stuff \"stop\"\015'"
                sleep 5
        else
                echo "$SERVICE was not running."
        fi
        if ps ax | grep -v grep | grep -v -i SCREEN | grep $SERVICE > /dev/null
        then
                echo "$SERVICE could not be shut down... still running."
        else
                echo "$SERVICE is shut down."
        fi
}


#mc_update() {
#  if ps ax | grep -v grep | grep -v -i SCREEN | grep $SERVICE > /dev/null
#  then
#    echo "$SERVICE is running! Will not start update."
#  else
#    MC_SERVER_URL=http://minecraft.net/`wget -q -O - http://www.minecraft.net/download.jsp | grep minecraft_server.jar\</a\> | cut -d \" -f 2`
#    as_user "cd $MCPATH && wget -q -O $MCPATH/minecraft_server.jar.update $MC_SERVER_URL"
#    if [ -f $MCPATH/minecraft_server.jar.update ]
#    then
#      if `diff $MCPATH/minecraft_server.jar $MCPATH/minecraft_server.jar.update >/dev/null`
#        then 
#          echo "You are already running the latest version of $SERVICE."
#        else
#          as_user "mv $MCPATH/minecraft_server.jar.update $MCPATH/minecraft_server.jar"
#          echo "Minecraft successfully updated."
#      fi
#    else
#      echo "Minecraft update could not be downloaded."
#    fi
#  fi
#}

mc_backup() {
   echo "Backing up minecraft files"
   BACKUPFILE="$BACKUPPATH/MCBKUP_`date +%Y.%m.%d_%H:%M:%S`.tar.gz"
   if [ -f "$BACKUPFILE" ]
   then
     echo "Backup already exists. Bad times!"
   else
     as_user "cd $MCSTORE && tar zcf $BACKUPFILE ."
   fi
   echo "Backup complete"
}

mc_disksaverun() {

  if ps ax | grep -v grep | grep -v -i SCREEN | grep $SERVICE > /dev/null
  then
   echo "Saving ramdrive to disk."
   if [ ! -f $MCPATH/$SERVICE ]
   then
     echo "Error.. Minecraft not in ram"
   else
     #if [ -d $MCSTORE/world2 ]
     #then
     #  as_user "rm -r $MCSTORE/world2"
     #fi
     #if [ -d $MCSTORE/world ]
     #then
     #as_user "mv $MCSTORE/world $MCSTORE/world2"
     #fi

     mc_saveoff
     as_user "cp -R $MCPATH/* $MCSTORE/"
     mc_saveon

     #if [ -d $MCSTORE/world2 ]
     #then
     #  as_user "rm -r $MCSTORE/world2"
     #fi
   fi
  else
  echo "Service is not running"
 fi

}

mc_disksavehalt() {
   echo "Saving ramdrive to disk."
   if [ ! -f $MCPATH/$SERVICE ]
   then 
     echo "Error.. Minecraft not in ram"
   else
     #if [ -d $MCSTORE/world2 ]
     #then
     #  as_user "rm -r $MCSTORE/world2"
     #fi
     #if [ -d $MCSTORE/world ]
     #then
     #as_user "mv $MCSTORE/world $MCSTORE/world2"
     #fi

     echo "Saving, screen session closed"
     as_user "cp -R $MCPATH/* $MCSTORE/"

     #if [ -d $MCSTORE/world2 ]
     #then
     #  as_user "rm -r $MCSTORE/world2"
     #fi
   fi


}


#Start-Stop here
case "$1" in
  start)
    mc_start
    ;;
  stop)
    mc_stop
    mc_disksavehalt
    ;;
  restart)
    mc_stop
    mc_disksavehalt
    mc_start
    ;;
  #update)
  #  mc_stop
  #  mc_backup
  #  mc_update
  #  mc_start
  #  ;;
  backup)
    mc_disksaverun
    mc_saveoff
    mc_backup
    mc_saveon
    ;;
  status)
    if ps ax | grep -v grep | grep -v -i SCREEN | grep $SERVICE > /dev/null
    then
      echo "$SERVICE is running."
    else
      echo "$SERVICE is not running."
    fi
    ;;

  *)
  #echo "Usage: /etc/init.d/minecraft {start|stop|update|backup|status|restart|disksaverun}"
  echo "Usage: /etc/init.d/minecraft {start|stop|backup|status|restart}"
  exit 1
  ;;
esac
