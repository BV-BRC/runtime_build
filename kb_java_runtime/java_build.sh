#!/bin/sh

# usage: 
#   build_java.sh
#   build_java.sh /kb/runtime
#   build_java.sh -u /kb/runtime
#
# general form:
#  build_java.sh -u <target>
#
# -u 		is optional, it will over-ride java restricted
# <target> 	is optional, it will default to /kb/runtime
restricted="restricted"
while getopts u opt; do
  case $opt in
    u)
      echo "-u was triggered, overridding restricted"
      shift
      restricted="unrestricted"
      ;;
    \?)
      echo "invalid option: -$OPTARG"
      ;;
  esac
done


target="/kb/runtime"
if [ $# -ne 0 ] ; then
	target=$1
	shift
fi
echo "using $target as runtime"

export JAVA_HOME=$target/java
export ANT_HOME=$target/ant
export THRIFT_HOME=$target/thrift
export CATALINA_HOME=$target/tomcat
export GLASSFISH_HOME=$target/glassfish3
export PATH=${JAVA_HOME}/bin:${ANT_HOME}/bin:$target/bin:${THRIFT_HOME}/bin:${CATALINA_HOME}/bin:${PATH}

mkdir -p $target/lib

#
# We don't install this version on the mac; we use the one that
# came with the system.
#
if [ ! -d /Library/Java/Home ] ; then
	echo "Install JDK, restricted set to $restricted"
	if [ "$restricted" = unrestricted ] ;
	then
	  curl http://www.kbase.us/docs/build/jdk1.6.0_30.tar.gz > jdk1.6.0_30.tar.gz
	  #cleanup old
	  rm -rf $target/jdk1.6*
	  rm $target/java
	  #install new 
	  tar zxvf jdk1.6.0_30.tar.gz -C $target
	  ln -s $target/jdk1.6.0_30 $target/java
	else
	  echo "This component is restricted, please download the tarball from the rights holder."
	fi
fi

echo "Install Ant"
curl -O http://www.kbase.us/docs/build/apache-ant-1.8.4-bin.tar.gz
rm -rf $target/apache-ant*
rm $target/ant
tar zxvf apache-ant-1.8.4-bin.tar.gz -C $target
ln -s $target/apache-ant-1.8.4 $target/ant

echo "Install Ivy"
curl -O http://www.kbase.us/docs/build/apache-ivy-2.3.0-rc1-bin.tar.gz 
rm -rf $target/apache-ivy*
tar zxvf apache-ivy-2.3.0-rc1-bin.tar.gz -C $target
ln -s $target/apache-ivy-2.3.0-rc1/ivy-2.3.0-rc1.jar $target/ant/lib/.

echo "Install tomcat"
curl http://kbase.us/docs/build/apache-tomcat-7.0.32.tar.gz > apache-tomcat-7.0.32.tar.gz
rm -rf $target/tomcat*
tar zxvf apache-tomcat-7.0.32.tar.gz -C $target
ln -s $target/apache-tomcat-7.0.32 $target/tomcat

#
# Standard java libraries.
#

echo "Install glassfish"
curl -O http://dlc.sun.com.edgesuite.net/glassfish/3.1.2.2/release/glassfish-3.1.2.2-ml.zip
rm -rf $target/glassfish*
unzip -d $target/ glassfish-3.1.2.2-ml.zip 

jackson=jackson-all-1.9.11.jar

echo "Install jackson"
rm -rf $target/lib/jackson-all*
curl -o $target/lib/$jackson http://jackson.codehaus.org/1.9.11/$jackson
ln -s $target/lib/$jackson $target/lib/jackson-all.jar

