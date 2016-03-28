#!/bin/bash
set -e

case $1 in
	'')
	cd $APP_HOME
	bundle install --system
	rerun "${RERUN_OPTS} ${APP_MAIN}"
	;;

	*)
	exec "$@"
	;;
esac