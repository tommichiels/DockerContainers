# HUE Docker image


Run with following command
 
Your hadoop cluster should be running as name master!! 
 
Without weave
docker run -d -p 8000:8000 --link master:master --name hue tommichiels/hue

