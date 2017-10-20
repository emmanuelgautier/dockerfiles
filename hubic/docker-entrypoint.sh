#!/bin/bash

PASSWORD_PATH="/root/.hubic_pwd"

/etc/init.d/dbus start

function dbus_init() {
  eval `dbus-launch --sh-syntax`
}

function hubic_init() {
  [[ -f "${PASSWORD_PATH}" ]] && return 0

  echo $HUBIC_PASSWORD >> $PASSWORD_PATH

  dbus_init
  hubic login --password_path=$PASSWORD_PATH $HUBIC_EMAIL /hubic
  hubic stop
}

sleep 2

hubic_init

dbus_init
hubic main-loop --verbose
