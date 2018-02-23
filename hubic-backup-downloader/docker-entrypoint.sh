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
dbus_init

mkdir -p $HUBIC_BACKUP_PATH
hubic backup download $HUBIC_BACKUP_NAME $HUBIC_BACKUP_PATH

hubic main-loop --verbose
