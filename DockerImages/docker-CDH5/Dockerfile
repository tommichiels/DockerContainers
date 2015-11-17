FROM tommichiels/base
MAINTAINER tom.michiels@archimiddle.com

#Base image doesn't start in root ######################################################
WORKDIR /

#Add the CDH 5 repository ##############################################################
COPY conf/cloudera.list /etc/apt/sources.list.d/cloudera.list
#Set preference for cloudera packages ##################################################
COPY conf/cloudera.pref /etc/apt/preferences.d/cloudera.pref
#Add repository for python installation ################################################
COPY conf/python.list /etc/apt/sources.list.d/python.list

#Add a Repository Key###################################################################
RUN wget http://archive.cloudera.com/cdh5/ubuntu/trusty/amd64/cdh/archive.key -O archive.key && sudo apt-key add archive.key && \
    sudo apt-get update

#Install CDH package and dependencies ##################################################
RUN sudo apt-get install -y zookeeper-server && \
    sudo apt-get install -y hadoop-conf-pseudo && \
    sudo apt-get install -y oozie && \
	sudo apt-get install -y hive-server2 && \
    sudo apt-get install -y python2.7 && \
    sudo apt-get install -y spark-core spark-history-server spark-python

# passwordless ssh #####################################################################
RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa
RUN cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

#Copy updated config files ###############################################################
COPY conf/core-site.xml /etc/hadoop/conf/core-site.xml.template
COPY conf/hdfs-site.xml /etc/hadoop/conf/hdfs-site.xml
COPY conf/mapred-site.xml /etc/hadoop/conf/mapred-site.xml
COPY conf/hadoop-env.sh /etc/hadoop/conf/hadoop-env.sh
COPY conf/yarn-site.xml /etc/hadoop/conf/yarn-site.xml.template
COPY conf/fair-scheduler.xml /etc/hadoop/conf/fair-scheduler.xml
COPY conf/oozie-site.xml /etc/oozie/conf/oozie-site.xml
COPY conf/spark-defaults.conf /etc/spark/conf/spark-defaults.conf
COPY conf/slaves /etc/hadoop/conf/slaves



#Format HDFS ###########################################################################
RUN sudo -u hdfs hdfs namenode -format

COPY conf/run-hadoop.sh /usr/bin/run-hadoop.sh
RUN chmod +x /usr/bin/run-hadoop.sh

RUN sudo -u oozie /usr/lib/oozie/bin/ooziedb.sh create -run && \
    wget http://archive.cloudera.com/gplextras/misc/ext-2.2.zip -O ext.zip && \
    unzip ext.zip -d /var/lib/oozie

# NameNode (HDFS) ######################################################################
EXPOSE 8020 50070

# DataNode (HDFS) ######################################################################
EXPOSE 50010 50020 50075

# ResourceManager (YARN) ###############################################################
EXPOSE 8030 8031 8032 8033 8088

# NodeManager (YARN) ###################################################################
EXPOSE 8040 8042

# JobHistoryServer #####################################################################
EXPOSE 10020 19888

# Oozie ################################################################################
EXPOSE 11000

# Spark history server #################################################################
EXPOSE 18080

# Hive server ##########################################################################
EXPOSE 10000

# Technical port which can be used for your custom purpose. ############################
EXPOSE 9999

CMD ["/usr/bin/run-hadoop.sh"]
