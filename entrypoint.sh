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
	cat /run/secrets/git/id.rsa > ~/.ssh/id_rsa
	chmod 600 ~/.ssh/id_rsa
	SERVER=${2%:*}
	SERVER=${SERVER#*@}
	ssh-keyscan $SERVER >> ~/.ssh/known_hosts
	REPO=${2%.git}
	REPO=${REPO#*/}
	git clone $2
	cd $REPO
	while true; do
		git pull
		sleep 15
	done
	;;

	*)
	exec "$@"
	;;
esac