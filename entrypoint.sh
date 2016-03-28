#!/bin/bash
set -e
mkdir $APP_HOME
case $1 in
	'')
	cd $APP_HOME
	bundle install --system
	rerun "${RERUN_OPTS} ${APP_MAIN}"
	;;

	'git-puller')
	cd $APP_HOME
	mkdir ~/.ssh
	chmod 700 ~/.ssh
	ln -s /run/secrets/git/id.rsa ~/.ssh/id_rsa
	echo 'yes' | git clone /run/secrets/git/id.rsa $2
	while true; do
		git pull
		sleep 15
	done
	;;

	*)
	exec "$@"
	;;
esac