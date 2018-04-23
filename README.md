### Deploy with new VNET:
<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fprongs%2Fyarn-azure%2Fmaster%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>

### Deploy with existing VNET, new subnet:
<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fprongs%2Fyarn-azure%2Fmaster%2Fazuredeploy_existing_vnet.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>

### Deploy with existing VNET, existing subnet:
<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fprongs%2Fyarn-azure%2Fmaster%2Fazuredeploy_existing_vnet_existing_subnet.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>


# Yarn cluster on Azure with azure fs

This template demonstrates how you can run apache yarn in Azure. To test it out, click on the deploy button above. 

In Azure, we only want the yarn and scheduling part from hadoop. For storage, Azure storage can be used instead of hdfs. So this repository only deals with yarn-specific services (ResourceManager and NodeManagers) and doesn't start hdfs-specific services (NameNode, DataNode). 

## Local Mode

You can test these in local with docker. Just clone and run `test-with-docker.sh AZURE_BLOB_CONTAINER=<blob-container-name> AZURE_BLOB_ENDPOINT=<blob-endpoint-name> AZURE_FS_KEY=<fs-key>`. This will run two docker containers, one for RM and one for NM. This becomes a single node cluster which uses the provided Azure fs. 

## Running on Azure

### Native mode
In this mode, Software installation is done directly on the virtual machines, i.e. `apt-get install java ...` and `wget hadoop.tar`. This mode is easy to work with to quickly fork off a cluster. The version of hadoop to use is configurable. Quickstart:

* Click on the button above
* Provide arguments and click `Purchase`
* Find dns name of resourcemanager machine: This is the `yarn` VM in the deployment
* `ssh` to that machien
* `ssh 10.0.0.6`: This is one of the node managers and is a good candidate as a client machine. 
* `source /usr/local/hadoop/environs.sh`
* `yarn jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.6.jar pi 5 5` : This should succeed
* Try increasing `5` to `500` and see the cluster auto scale. 


### Docker mode
In this mode, we obtain VMs from Azure and install `docker` on them. Then, each machine pulls a specific docker image and starts the docker container. 
The docker images need to be built and pushed first. For this, you need an `Azure Container Registry`. Once you have that, you can run `./build_docker_images.sh $CONTAINER_REGISTRY_URL [$CONTAINER_REGISTRY_USERNAME [$CONTAINER_REGISTRY_PASSWORD]] $BUILD_ARGS`, where `BUILD_ARGS` is a list of arguments of type `A=B`, these will be passed as build arguments while building the docker images. The build args currently supported are `HADOOP_VERSION` and `HADOOP_TAR_URL`. Basically you can build docker images with your custom version of hadoop by specifying a custom tar url and corresponding version number. The script takes care of building the images and pushing them with pre-defined names. The name resolution for which image to pull is then done on install time. Quickstart for interacting with the cluster is similar as in the native mode, except that you have to go inside a docker container just after `ssh` to interact via command line. The container can be found with `sudo docker ps`, one VM runs only one container.
