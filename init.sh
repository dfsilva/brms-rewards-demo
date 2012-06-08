#!/bin/sh 
JBOSS_HOME=./target/brms-standalone-5.3.0
SERVER_DIR=$JBOSS_HOME/jboss-as/server/default
SRC_DIR=./installs
BRMS=brms-p-5.3.0.GA-standalone.zip


echo
echo Setting up the JBoss Enterprise BRMS 5.3 Rewards Demo environment...
echo

# make some checks first before proceeding.	
if [[ -x $SRC_DIR/$BRMS || -L $SRC_DIR/$BRMS ]]; then
	echo BRMS sources are present...
	echo
else
	echo Need to download $BRMS package from the Customer Support Portal 
	echo and place it in the $SRC_DIR directory to proceed...
	echo
	exit
fi

# Create the target directory if it does not already exist.
if [ ! -x target ]; then
	echo "  - creating the target directory..."
	echo
  mkdir target
else
	echo "  - detected target directory, moving on..."
	echo
fi

# Move the old JBoss instance, if it exists, to the OLD position.
if [ -x $JBOSS_HOME ]; then
	echo "  - existing JBoss Enterprise BRMS 5.3.0 detected..."
	echo
	echo "  - moving existing JBoss Enterprise BRMS 5.3.0 aside..."
	echo
  rm -rf $JBOSS_HOME.OLD
  mv $JBOSS_HOME $JBOSS_HOME.OLD

	# Unzip the JBoss BRMS instance.
	echo Unpacking JBoss Enterprise BRMS 5.3.0...
	echo
	unzip -q -d target $SRC_DIR/$BRMS
else
	# Unzip the JBoss BRMS instance.
	echo Unpacking new JBoss Enterprise BRMS 5.3.0...
	echo
	unzip -q -d target $SRC_DIR/$BRMS
fi


# Add execute permissions to the run.sh script.
echo "  - making sure run.sh for server is executable..."
echo
chmod u+x $JBOSS_HOME/jboss-as/bin/run.sh

echo "  - enabling demo accounts logins in brms-users.properties file..."
echo
cp support/brms-users.properties $SERVER_DIR/conf/props

echo "  - enabling demo accounts role setup in brms-roles.properties file..."
echo
cp support/brms-roles.properties $SERVER_DIR/conf/props

echo "  - enabling demo users for human tasks in jbpm-human-task.war web.xml file..."
echo
cp support/jbpm-human-task-war-web.xml $SERVER_DIR/deploy/jbpm-human-task.war/WEB-INF/web.xml

echo JBoss Enterprise BRMS 5.3 Rewards Demo Setup Complete.
echo

