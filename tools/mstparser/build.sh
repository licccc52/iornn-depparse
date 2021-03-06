#!/bin/sh

echo
echo "MST Parser Build System"
echo "-------------------"
echo

export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64/
export PATH=$PATH:/home/ubuntu/workspace/io-rnn/tools/mstparser/

if [ "$JAVA_HOME" = "" ] ; then
  echo "ERROR: JAVA_HOME not found in your environment."
  echo
  echo "Please, set the JAVA_HOME variable in your environment to match the"
  echo "location of the Java Virtual Machine you want to use."
  exit 1
fi

if [ `echo $OSTYPE | grep -n cygwin` ]; then
  PS=";"
else
  PS=":"
fi

LOCALCLASSPATH=$JAVA_HOME/lib/tools.jar
# add in the dependency .jar files
DIRLIBS=lib/*.jar
for i in ${DIRLIBS}
do
    if [ "$i" != "${DIRLIBS}" ] ; then
        LOCALCLASSPATH=$LOCALCLASSPATH${PS}"$i"
    fi
done
ANT_HOME=./lib

echo Deleting old folders
rm -r output

echo Building with classpath $LOCALCLASSPATH
echo

echo Starting Ant...
echo

$JAVA_HOME/bin/java -Dant.home=$ANT_HOME -classpath $LOCALCLASSPATH org.apache.tools.ant.Main $*

echo copy classes to the current dir
cp -r output/classes/mstparser/ ./
