TAG=$1
cd ~/work/client-libs/java/
export JAVA_HOME=$(/usr/libexec/java_home -v 1.6)
java -version
alias mvn2='~/Vai/Softs/Mac\ Softs/Mavan\ 3.2.5/apache-maven-3.2.5/bin/mvn'
mvn2 clean package
cp target/chargebee-java-$TAG-SNAPSHOT.jar ~/work/client-libs/tests/java/ClientLibsTest/lib/chargebee-java.jar
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
java -version