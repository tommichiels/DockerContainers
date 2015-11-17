# CDH 5 pseudo-distributed cluster Docker image

cloned a repo from https://github.com/chali  and changed the dockerfile to be weave ready and .
* Removed Hue
* Added Hive
* Added Slave configuration
 
 
 Run with following command
 
 Without weave
 docker run -d --name=master tommichiels/hadoop /usr/bin/run-hadoop.sh -master
 
 With weave
 docker run -d --name=master -e NAMENODE=10.0.1.1 -e RESOURCEMANAGER=10.0.1.1  tommichiels/hadoop /usr/bin/run-hadoop.sh -master
 
 With Weave you can also use the run.sh file