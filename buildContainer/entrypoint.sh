#!/bin/sh

# Usage jenkins-agent.sh [options] -url http://jenkins [SECRET] [AGENT_NAME]
# Optional environment variables :
# * JENKINS_JAVA_BIN : Java executable to use instead of the default in PATH or obtained from JAVA_HOME
# * JENKINS_JAVA_OPTS : Java Options to use for the remoting process, otherwise obtained from JAVA_OPTS
# * JENKINS_TUNNEL : HOST:PORT for a tunnel to route TCP traffic to jenkins host, when jenkins can't be directly accessed over network
# * JENKINS_URL : alternate jenkins URL
# * JENKINS_SECRET : agent secret, if not set as an argument
# * JENKINS_AGENT_NAME : agent name, if not set as an argument
# * JENKINS_AGENT_WORKDIR : agent work directory, if not set by optional parameter -workDir
# * JENKINS_WEB_SOCKET: true if the connection should be made via WebSocket rather than TCP
# * JENKINS_DIRECT_CONNECTION: Connect directly to this TCP agent port, skipping the HTTP(S) connection parameter download.
#                              Value: "<HOST>:<PORT>"
# * JENKINS_INSTANCE_IDENTITY: The base64 encoded InstanceIdentity byte array of the Jenkins master. When this is set,
#                              the agent skips connecting to an HTTP(S) port for connection info.
# * JENKINS_PROTOCOLS:         Specify the remoting protocols to attempt when instanceIdentity is provided.

if [ $# -eq 1 ] && [ "${1#-}" = "$1" ] ; then

	# if `docker run` only has one arguments and it is not an option as `-help`, we assume user is running alternate command like `bash` to inspect the image
	exec "$@"

else

    # Let's first start IS
    cd /
    ./opt/softwareag/IntegrationServer/bin/startContainer.sh&

    # if -tunnel is not provided, try env vars
	case "$@" in
		*"-tunnel "*) ;;
		*)
		if [ ! -z "$JENKINS_TUNNEL" ]; then
			TUNNEL="-tunnel $JENKINS_TUNNEL"
		fi ;;
	esac

	# if -workDir is not provided, try env vars
	if [ ! -z "$JENKINS_AGENT_WORKDIR" ]; then
		case "$@" in
			*"-workDir"*) echo "Warning: Work directory is defined twice in command-line arguments and the environment variable" ;;
			*)
			WORKDIR="-workDir $JENKINS_AGENT_WORKDIR" ;;
		esac
	fi

	if [ -n "$JENKINS_URL" ]; then
		URL="-url $JENKINS_URL"
	fi

	if [ -n "$JENKINS_NAME" ]; then
		JENKINS_AGENT_NAME="$JENKINS_NAME"
	fi

	if [ "$JENKINS_WEB_SOCKET" = true ]; then
		WEB_SOCKET=-webSocket
	fi

	if [ -n "$JENKINS_PROTOCOLS" ]; then
		PROTOCOLS="-protocols $JENKINS_PROTOCOLS"
	fi

	if [ -n "$JENKINS_DIRECT_CONNECTION" ]; then
		DIRECT="-direct $JENKINS_DIRECT_CONNECTION"
	fi

	if [ -n "$JENKINS_INSTANCE_IDENTITY" ]; then
		INSTANCE_IDENTITY="-instanceIdentity $JENKINS_INSTANCE_IDENTITY"
	fi

	if [ "$JENKINS_JAVA_BIN" ]; then
		JAVA_BIN="$JENKINS_JAVA_BIN"
	else
		# if java home is defined, use it
		JAVA_BIN="java"
		if [ "$JAVA_HOME" ]; then
			JAVA_BIN="$JAVA_HOME/bin/java"
		fi
	fi

	if [ "$JENKINS_JAVA_OPTS" ]; then
		JAVA_OPTIONS="$JENKINS_JAVA_OPTS"
	else
		# if JAVA_OPTS is defined, use it
		if [ "$JAVA_OPTS" ]; then
			JAVA_OPTIONS="$JAVA_OPTS"
		fi
	fi

	# if both required options are defined, do not pass the parameters
	OPT_JENKINS_SECRET=""
	if [ -n "$JENKINS_SECRET" ]; then
		case "$@" in
			*"${JENKINS_SECRET}"*) echo "Warning: SECRET is defined twice in command-line arguments and the environment variable" ;;
			*)
			OPT_JENKINS_SECRET="${JENKINS_SECRET}" ;;
		esac
	fi
	
	OPT_JENKINS_AGENT_NAME=""
	if [ -n "$JENKINS_AGENT_NAME" ]; then
		case "$@" in
			*"${JENKINS_AGENT_NAME}"*) echo "Warning: AGENT_NAME is defined twice in command-line arguments and the environment variable" ;;
			*)
			OPT_JENKINS_AGENT_NAME="${JENKINS_AGENT_NAME}" ;;
		esac
	fi

    exec $JAVA_BIN $JAVA_OPTIONS -cp /usr/share/jenkins/agent.jar hudson.remoting.jnlp.Main -headless $TUNNEL $URL $WORKDIR $WEB_SOCKET $DIRECT $PROTOCOLS $INSTANCE_IDENTITY $OPT_JENKINS_SECRET $OPT_JENKINS_AGENT_NAME "$@"

fi