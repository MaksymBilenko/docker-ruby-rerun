#!/bin/bash
set -e

case $1 in
	'')
	#initial sleep for puller
	sleep 15
	cd $APP_HOME
	bundle install --system
	rerun ${RERUN_OPTS} "ruby ${APP_MAIN}"
	;;

	'git-puller')
	REPO=${2%.git}
	REPO=${REPO#*/}
	SERVER=${2%:*}
	SERVER=${SERVER#*@}
	mkdir ~/.ssh
	chmod 700 ~/.ssh
	cat /run/secrets/git/id.rsa > ~/.ssh/id_rsa
	chmod 600 ~/.ssh/id_rsa
	ssh-keyscan $SERVER >> ~/.ssh/known_hosts

	cd /opt
	if [ ! -d $REPO ]; then
		git clone $2
	fi
	cd $REPO
	while true; do
		git pull
		sleep 15
	done
	;;

	'shellinabox')
	sleep 15
	cd $SHELLINABOX_HOME
	bundle install --system
	shellinaboxd -t -v -s "/:root:root:/:${SHELLINABOX_HOME}/${WRAPPER} SELF_URL=\${url} `env`"
	;;

	*)
	exec "$@"
	;;
esac