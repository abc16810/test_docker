#!/bin/bash
set -e

source ${RUNTIME_DIR}/functions

case ${1} in
  start)
    initialize_system
    rm -rf /var/run/supervisor.sock
    exec /usr/bin/supervisord -nc /etc/supervisord.conf
    ;;
  app:help)
    echo "Available options:"
    echo " app:start        - Starts the gitlab server (default)"
    echo " app:init          "
    echo " app:sanitize     - Fix repository/builds directory permissions."
    echo " app:rake <task>  - Execute a rake task."
    echo " app:help         - Displays the help"
    echo " [command]        - Execute the specified command, eg. bash."
    ;;
  *)
    exec "$@"
    ;;
esac
