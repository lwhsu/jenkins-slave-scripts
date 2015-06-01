#! /bin/sh

slavename=`/bin/hostname`

cd /usr/local/jenkins/jenkins-slave-scripts || exit 1
while [ ! -f salve.dontstart ]
do
	/bin/date
	# mirror mode, update it if there's a timestamp change on the master
	/usr/bin/fetch -m -o slave.jar http://jenkins-master.freebsd.org/jnlpJars/slave.jar
	/usr/local/bin/java -Djava.net.preferIPv6Addresses=true \
		-jar slave.jar \
		-jnlpUrl http://jenkins-master.freebsd.org/computer/${slavename}/slave-agent.jnlp
	/bin/sleep 30
done
