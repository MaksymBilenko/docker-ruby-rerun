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
	SERVER=${2%:*}
	SERVER=${SERVER#*@}
	ssh-keyscan $SERVER >> ~/.ssh/known_hosts
	git clone $2
	while true; do
		git pull
		sleep 15
	done
	;;

	*)
	exec "$@"
	;;
esac