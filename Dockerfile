FROM			ruby:latest

ENV				APP_HOME 			/opt/app
ENV				APP_MAIN			lib/main.rb
ENV				RERUN_OPTS			''

ADD				entrypoint.sh		/entrypoint.sh
ENTRYPOINT		['/entrypoint.sh']
CMD				['']