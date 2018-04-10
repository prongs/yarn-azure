<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fprongs%2Fyarn-azure%2Fmaster%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>

# Yarn cluster on Azure with azure fs

This template demonstrates how you can run apache yarn in Azure. To test it out, click on the deploy button above. 

In Azure, we only want the yarn and scheduling part from hadoop. For storage, Azure storage can be used instead of hdfs. So this repository only deals with yarn-specific services (ResourceManager and NodeManagers) and doesn't start hdfs-specific services (NameNode, DataNode). 

## Local Mode

You can test these in local with docker. Just clone and run `test-with-docker.sh AZURE_BLOB_CONTAINER=<blob-container-name> AZURE_BLOB_ENDPOINT=<blob-endpoint-name> AZURE_FS_KEY=<fs-key>`. This will run two docker containers, one for RM and one for NM. This becomes a single node cluster which uses the provided Azure fs. 

## Running on Azure

The template asks for a VM for ResourceManager and a VM scale set for NodeManagers. Now, we need the capability to scale the ScaleSet when demand is high. For this, docker turns out to be too convoluted since the service becomes `linux on docker in linux vm`. Also, for autoscaling, installing docker and docker pull are extra steps every VM needs to do to register itself as a node. Fot this reason, deployment on azure happens without docker. A new potential NodeManager needs to install java, download and extract hadoop tar and start service. 