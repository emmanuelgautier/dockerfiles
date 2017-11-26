#!/bin/bash

PASSWORD_PATH="/root/.hubic_pwd"
HUBIC_BACKUP_PATH="/hubic"

/etc/init.d/dbus start

function dbus_init() {
  eval `dbus-launch --sh-syntax`
}

function hubic_init() {
  [[ -f "${PASSWORD_PATH}" ]] && return 0

  echo $HUBIC_PASSWORD >> $PASSWORD_PATH

  dbus_init
  hubic login --password_path=$PASSWORD_PATH $HUBIC_EMAIL
}

sleep 2

hubic_init

if hubic backup info | awk 'FNR > 1 {print $1}' | grep -Fxq $HUBIC_BACKUP_NAME
then
  echo "Updating backup $HUBIC_BACKUP_NAME config"

  hubic backup attach $HUBIC_BACKUP_NAME $HUBIC_BACKUP_PATH
  hubic backup config --drop_deleted \
    --path=$HUBIC_BACKUP_PATH \
    --frequency=$HUBIC_BACKUP_FREQUENCY \
    --kept_versions=$HUBIC_BACKUP_KEPT_VERSIONS \
    $HUBIC_BACKUP_PATH

  hubic backup update $HUBIC_BACKUP_PATH
else
  echo "Creating backup $HUBIC_BACKUP_NAME"

  hubic backup create --drop_deleted \
    --name=$HUBIC_BACKUP_NAME \
    --frequency=$HUBIC_BACKUP_FREQUENCY \
    --kept_versions=$HUBIC_BACKUP_KEPT_VERSIONS \
    $HUBIC_BACKUP_PATH
fi

dbus_init
hubic main-loop --verbose
