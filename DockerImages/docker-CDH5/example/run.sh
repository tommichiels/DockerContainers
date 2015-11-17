NN=10.0.1.1
RM=10.0.1.2
S1=10.0.1.3
S2=10.0.1.4
Ss=$(echo $S1,$S2)

IMAGE="tommichiels/hadoop"

if [[ $1 == "-master" ]]; then
    HOSTNAME="master"
	HOSTNAMEIP=$NN;
    CMD=$1
fi

if [[ $1 == "-slave1" ]]; then
    HOSTNAME="slave1"
	HOSTNAMEIP=$S1
    CMD="-slave"
fi
if [[ $1 == "-slave2" ]]; then
    HOSTNAME="slave2"
	HOSTNAMEIP=$S2
    CMD="-slave"
fi


#sudo weave run $HOSTNAME/16 -it -h=$HOSTNAME -e NAMENODE=$NN -e RESOURCEMANAGER=$RM  -e SLAVES=$Ss $IMAGE /etc/bootstrap.sh $CMD
#docker run -d --name=master -e WEAVE_CIDR=10.0.1.1/24 -e NAMENODE=10.0.1.1 -e RESOURCEMANAGER=10.0.1.1  -e SLAVES=10.0.1.3 -p 8020:8020 -p 50070:50070 -p 50010:50010 -p 50020:50020 -p 50075:50075 -p 8030:8030 -p 8031:8031 -p 8032:8032 -p 8033:8033 -p 8088:8088 -p 8040:8040 -p 8042:8042 -p 10020:10020 -p 19888:19888 -p 11000:11000 -p 8888:8888 -p 18080:18080 -p 9999:9999 tommichiels/hadoop /usr/bin/run-hadoop.sh -master
#docker run -d --name=slave1 -e WEAVE_CIDR=10.0.1.3/24 -e NAMENODE=10.0.1.1 -e RESOURCEMANAGER=10.0.1.1  -e SLAVES=10.0.1.3 tommichiels/hadoop /usr/bin/run-hadoop.sh -slave

d.run "ReverseProxy",
       image: "httpd:2.4",
       args: " -i -t -v /httpd/conf/httpd.pr.conf:/usr/local/apache2/conf/httpd.conf -p 80:80"

docker run -d -e WEAVE_CIDR=10.0.1.10/24 --name=proxy -v /home/docker/httpd/httpd.conf:/usr/local/apache2/conf/httpd.conf -p 80:80 httpd:2.4

docker run -d --name=$HOSTNAME -e NAMENODE=$NN -e RESOURCEMANAGER=$RM  -e SLAVES=$Ss $IMAGE /usr/bin/run-hadoop.sh $CMD