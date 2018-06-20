# Installing DCOS Kubernetes environment to support these examples

The files within this directory are used to install different Kubernetes on DC/OS examples.  Make certain to have the supplied requirements before proceeding with the installation steps.
## Requirements
* DC/OS cluster running version 1.11+ and running with 11 nodes minimum
* a computer with ssh access

Before starting it is always a good idea to confirm that the DC/OS GUI nodes screen matches with the DC/OS CLI node view 'dcos node'.

## Installation steps
1. run the ``initial_k8s_install.sh`` command to load the pre-requisite DC/OS services as shown here:
```bash initial_k8s_install.sh```
2. Install Kubernetes DC/OS service.  You should take a look at the k8s_options.json for the configurations used for this example:
```bash install_kubernetes.sh```



