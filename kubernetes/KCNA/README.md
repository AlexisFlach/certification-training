### Study notes

###### Certificate

https://www.cncf.io/certification/kcna/

###### Notes based on

https://www.youtube.com/watch?v=AplluksKvzI&ab_channel=freeCodeCamp.org


#### Sections

1. What is Cloud Native?

Cloud-native describes an architectural approach that emphasized application workloads that are portable, modular and isolate, between different cloud deployment model and Cloud Service Providers.

Some describe it being 4 key principles:
1. Microservices
2. Containerization
3. CD
4. DevOps

CNFS:

Cloud Native Techs empower organizations to build and run scalable apps in modern, dynamic, environments, such as public, private and hybrid clouds. Containers, services, meshes, microservices, immutable infrastructure, and declarative APIs exemplify this approach. 

These techs enable loosely coupled systems that are resilient, manageable and observable.

Combined with robust automation, they allow engineers, to make high impact changes, frequently and predictably with minimal toll.

I think modern techs in combination with portability.


2. Cloud Native vs Cloud Service Provider

CSP: 

- a collection of cloud services
- strong application integration and synergies between services
- utilizing metered billing
- under a single unified API

AWS, Azure, Google Cloud etc

CN:

- a workload, application or system, that is designed to run on cloud services, and "takes advantage of cloud offerings".



AWS, Azure, Google Cloud etc

CN:

- a workload, application or system, that is designed to run on cloud services, and "takes advantage of cloud offerings".



AWS, Azure, Google Cloud etc

CN:

- a workload, application or system, that is designed to run on cloud services, and "takes advantage of cloud offerings".



AWS, Azure, Google Cloud etc

CN:

- a workload, application or system, that is designed to run on cloud services, and "takes advantage of cloud offerings".

3. Cloud Native Shared Responsibility Model

GitOps...

4. The Linux Foundation

5. Cloud Native Computing Foundation

A Linux Foundation project to help advance container technology

6. Cloud Native Landscape

landscape.cncf.io

7. Cloud Native Trail Map

The CNs recommended path to adopting Cloud-Native architecture

1. Containerization
2. CI/CD
3. Orchestration
4. Observability and Analysis
5. Service Proxy, Discovery, Mesh
6. Networking Policy, and Security
7. Distributed Databases and Storage
8. Streaming and Messaging
9. Container Registry and Runtime
10. Software distributuion

8. Vms vs Containers

VM: EC2 Instance

VMs do not make the best use of space. Apps are not isolated which could cause config conflics, security problems or resource hogging.

Containers allow you to run multiple apps which are virtually isolated from each other. Launch new containers and config os dependencies per container.

9. Microservices

Monolithic Architecture
One app is responsible for everything. Functionality is tightly coupled.

Ms Architecture
Multiple apps which are each responsible for one thing. Functionality is isolate and stateless.

10. Kubernetes

An open-source container orchestation system for automating deployment, scaling and management of containers.

Maintained by CNCF.

(over-simplified) The advantage over Docker is the ability to run "container apps" distributed acress multiple VMs.

A unique component of K8s is Pods. A pod is a group of one or more containers with shared storage, network resources and other shared settings.

K8s are ideal for ms architecture.

11. K8s Components Overview

- Cluster
A logical grouping of all components within a cluster.

- Namespace
A named logical grouping of K8s components within a cluster.
Used to isolate different workloads on the same cluster.

A slice of pie.

- Node
A virtual machine or underlying server. There are two types of node: Control Plane and Worker Nodes. Worker nodes is where the application or workloads run. CP nodes manage worker nodes.

- Pod
The smallest unit in K8s. An abstraction over a container.
Generally defines an app workload.

- Service
Something we use with a pod to give it a static IP adress and DNS name for a set of pods(persists an ip address if a pod dies) and a load balancer.

- Ingress
Translates HTTP/S rules to point to services. Often used for getting an external load balancer to route trafic to our pods.

- API Server
Allows users to interact with K8s components using the KubeCTL or by sending HTTP/S requests. 

- Kubelet
An agent installed on all nodes. Kubelet allows users to interact wuth node via the API server and Kubectl.

- Kubectl
CLI that allows users to interact with the cluster and components via the API server.

- Cloud Controller Manager
Allows you to link a Cloud Service Provider (AWS, Azure) to leverage cloud services.

- Controller Manager
A controll loop that watches the state of the cluster and will change the current state back to desired state.

- Scheduler
Determines where to place pods on nodes. Places them in a scheduling queue.

- Kube Proxy
An application on worker nodes that provides routing and filtering rules for ingress(incoming trafic) to pods.

- Network policy
Acts a virtual firewall at the namespace-level or pod-level.

- ConfigMap
Allows you to decouple environment-specific configuration from your container images, so that your applications are easily portable. Used to store non-confidential data in key-value pairs. Application configuration details.

- Secret
Small amount of sensitive data such as a password, a token or a key. Basically ConfigMap
encrypted.

- Volumes
Mounting storage eg. locally on the node, or remote to cloud storage.

- StatefulSet (not included in the course, vey hard)
provides guarantees about the ordering and uniqueness of these Pods
Think of dbs where your have to determine read and writes order or limit the amout of containers.

- ReplicaSets
Maintain a stable set of replica pods running at a given time. Can provide a guarentee of availability.

- Deployment
A blueprint for a pod (Launch template)

11. Manifest Files in K8s

Manifest(non-technical): A Manifest file is a document that is commonly used for customs to list the contents of cargo, or passengers. Itemized list of things.

In context of K8s, a Manifest file is a generelized name for any k8s configuration file that define the configuration of various k8s components.

- Deployment file
- PodSpec file
- Network Policy file

Could be written in YAML or JSON, but most common is YAML.

A manifest can contain mulitple K8s component definitions/configurations:

```YAML
---
```

kubectl apply command is generally used to deploy manifest files

```bash
kubectl apply -f resources.yaml
```

Resource Configuration file is sometimes used to describe multiple resources in a manifest.

12. Control Plane and Worker Nodes

CPN: Formally known as Master Node. Manages processes like scheduling, restarting nodes..

WN: Does the work, running your app in pods and containers.

What is in the Control Plane:

API Server: the backbone of communication
Scheduler: determines where to start a pod on worker node
Controller Manager: detect state changes(if pod crashed, restart it)
etcd: a key/value Store that stores the state of the cluster.
Kubelet: Allows user to interact with the node via Kunbectl.
CoreDNS: 

The worker nodes runs:
Kubelet
Kube Proxy
Container Runtime
Pods and Containers

Why are there a proxy?

Proxy is what is is used when you have incoming trafic.
ADD MORE LATER.

13. Pods

Pods are the smallest unit in K8s. Pods abstract away the container layer so you can directly interact with the K8s Layer.

A pod is intended to run one application in multiple containers
	- DB pod
	- Job pod
	- frontend app pod
	- backend app pod
You can run multiple apps inside one pod but those containers will be tightly dependent.

Each pod gets its own private ip address
 - containers will run on different ports
 - containers can talk to eachother on localhost


Each pod can have a shared storage volume attached
 - all containers will share the same volume

When the last remaining container dies in a pod, so does the pod.
 When a replacement pod is created, the pod will habe in ip address assigned.
 The ip address will be Ephermal(temporary) for pods, they dont by default persist.That is why we will need K8s services.

k get pod -o wide

14. API Server

The core of K8s control plane is the API Server.
The API server exposes an HTTP API that lets end users, different parts of your cluster, and external components commnunicate with one another.

The K8s API lets you query and manipulate the state of API objects in K8s(pods, namespaces, ConfigMAps, and events)

The API server is a component of the K8s control plane that exposes the K8s API. The API server is the front end for the k8s control plane.

The main implementaion of a k8s server is kube-apiserver. kube-apiserver is designed to scale horizontally, it scales by deploying more instances.

You can run several instances of kube-apiserver and balance traffic between those instances.

Everything has to go through the api server.

You can interact with the API server in three ways:

- UI
- API
- CLI: kubeCTL

15. Deployment

A deployment provides declerative updates for Pods and ReplicaSets.

The default Deployment Controller can be swapped out for other deployment tools:
Argo, Flux, Jenkin X...

Deployment is built-in so you dont have to use a 3rd party tool, but generally you want to because the tool is limited. 

In reality, a deployment is alwats deploying a replicaSet.

A deployment define the desired state of ReplicaSets and Pods. 
A deployment will create and manage a ReplicaSet.
A replicaset will manage the replicas of pods.

16. Replica Set

RS is a way to maintain a desired amount of redundant pods(replicas) to provide a guarantee of availability.

The pod field metadata.ownerReference determines the link from a pod to a ReplicaSet.

It is not recommended to directly create replicaSets. Instead a deployment can create and manage a ReplicaSet for you.  

17. Stateless vs Stateful

Very important concept. 

Stateless: 
- Every request does not care (forgets) about previous or current state.
- Web-apps that store sessions outside of the web-apps virtual machine(database or cookies) will be stateless web-apps
- ReplicaSets

Stateful: 
- Every request relies on state data(remembers). All databases are stateful. 
- Monolithic web-apps that store session data in memory on a vm are Stateful.
- StatefulSets

16. Stateful Sets

For dbs, instead use managed service.

Used when you need trafic to be sent to specific pods.

...

17. Namespaces

A Namespace is a way to logically isolate resources within a K8s cluster.
Namespaces can be organized based on project, department or any user-defined grouping.

```
kubectl get namespace
```

Kubernetes starts with 4 default namespaces:

1. default
The default namespace where all our pods and services run unless a namespace is specified.
2. kube-public
For resources that are publicly visible and readable
3. kube-system
The system namespace that stores objects created by K8s System
Engineers deploying applications are not supposed to touch this namespace
4. kube-node-lease
Holds lease objects associated with each node. Used to detact node failures by sending heartbeats.

You can create your own namespaces

```
kubectl create namespace prod
```

In clusters with a small amount of resources, Namespaces aren't really necessary.

Names of resources need to be unique withing a namespace, but not across namespaces.
Namespace-based scoping is applicable only for namespaces objects eg Deployments, Services... but not for cluster-wide objects eg StorageClass, Nodes, PersistentVolumes....


Single-Namespace Objects
ConfigMaps and Secrets can't be shared across namespaces

Multi-Namespace Objects
A Service and Pods can belong to multiple namespaces

Cluster-Wide Objects
Volumes and Nodes can't be bound to namespace since they are global.

You can apply system quota restrictions on a namespace to avoid overuse eg Mem, compute..

If you don't provide a namespace for a component it will end up in the default namespace.1o


18. In-Tree vs Out-of-Tree

In Cloud Native projecs you will hear the terms "In-Tree" and "Out-of-Tree". 

In-Tree:
Think of In-Tree as Internal Plugins. Things that come by default with the project.
Plugins, components or functionality that are provided by default and/or reside in the main repository.


Out-of-Tree:

Plugins, components and functionality that must be installed manually, and extends or replaces the default behavior.
Think of Out-of-Tree as external plugins.

There are however different kinds of explenations to the terms, this is only a way to contextualize them.

19. Endpoints and Endpoint Slices

Endpoints track the IP Addresses of the pods assigned to a K8s Service.
When a service selector matches a pod label, the pod IP Address is added to the pool of endoints.
Pods expose themselves to services via endpoints.

So services are used to loabalance to multiple pods. They link to multiple pods via endpoints.
Each Pod has a dynamical IP Address. The idea is that these ip addresses are stored in endpoint which exists in a Endpoints pool. Basically, the connection between services and pods.

```
kubectl get endpoints
```

Endpoint Slices break up Endpoints into smaller manageable segments. Each Endpoint Slice has a limit of 100 pods. 


20. Jobs and Cron Jobs

First of all, what is a Background-job?
A one-off task that is used to run a piece of code.
Commonly used to perform mainenance or to trigger a computational workload.
EG. Back up the db every x minute, Delete all users who have not confirmed their email.

A Job creates one or more Pods and will continue to retry execution of the Pods until a specified number of them successfullt terminate.

```
kubectl create job hello --image=busybox -- echo "Hello World"
```

A CronJob is a job that executes based on repeating schedule.

```
kubectl create cronjob hello --image=busybox --schedule="*/1 * * * *" echo "Hello World"
```

A common usecase for a cronjob is sending out emails.

21. Kubernetes Dashboard

K8s Dashboard is an open-source application you can deploy to your cluster to provide a UI to view K8s components. 


22. Selectors

Selecetors are a way of selecting one or more Kubernetes Objects.

In K8s there are 3 types of selectors:

1. Label Selector
Select K8s objects based on applied label

```
env: prod
```

2. Field Selector
Select K8s objects based on object data, Metadata, status

3. Node Selector

Select nodes for very specific pod placement

###### Applying Labels

Label Selectors define labels as key value pais under metadata in a Manifest file.

```
apiVersion
kind
metadata:
	name: nginx-web-1
	labels:
		env: prod
		app: nginx-web
```

```
kubectl get pods --show-labels
```

```
kubectl label pods apache-web owner=devops
```

(of course more common to do it in the Manifest file)


23. Recommended Labels

These are recommended labels that "should" apply to every resource object:

- name
The name of the app
- instance
Unique name identifying the instance of an app
- version
- component
The component within teh architecture
- part-of
The name of a higher-level app this one is part of
- managed-by
- created-by

Shared labels and annotations share a common prefix: app.kubernetes.io

Labels without a prefix are private to users.

Name is the most common here, not very common to use them all.

24. Selecting Labels

K8s objects like Services or ReplicaSets will target pods based on label selectors.

Selector syntaxt varies for different templates.

**Service**

```
apiVersion: v1
kind: Service
metadata:
	name: my-service
spec:
	selector:
		app: my-selected-app
	ports:
		- protocol: TCP
		  port: 80
		  targetPort: 1808
```

```
kubectl get pods --selector env=dev

kubectl get pods -l env=dev

```

25. Annotations

K8s annotations allow you to attach arbitary non-identifying metadata objects.
Clients(tools and libraries) can and may require this annotation in order to work.

For example: Ingress often use annotation to communicate to Ingress Controller.

```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
	name: minimal-ingress
	annotations:
		nginx.ingress.kubernetes.io/rewrite-target: /
spec:
...
```

26. PodSpecFile

PodSpec is a configuration file that describes a pod.

```
apiVersion: v1
kind: Pod
metadata:
	name: nginx
spec: 
	containers:
	- name: nginx
	  image: nginx
	  ports:
	  - containerPort: 80
```

Kind is Pod.

The spec section will define
 - multiple containers ( maybe)
	- name of container
	- the image
	- teh command to run on startup
	- the port the cont will operate on 
	- the restart policy
	...

```
kubectl apply -f nginx.yaml
```

In practise you won't directly deploy pods, instead you would use Deployment or Job as the kind


27. gRPC

What is Remote Procedure Call? (RPC)

RPC is a framework of communication in distributed systems. It allows one program on machine to communicate with another program on remote machine without knowing it is remote. The concept of RPC has been around since 1970's.

gRPC is a modern open source high perfromance RPC framework that can run on any environment. Was ini created by Google.

You can think of gRPC as an alternate method of communication instead of REST or GraphQL.

gRPC can connect services in and across data centers with pluggable support for:
	- load balancing
	- tracing
	- health checking
	- authentication

gRPC works by:
	- installing a gRPC library for your program.
	- defining a Protobuf file that describe the data structure
		- .proto ext.
	- writing code that works with gRPC

Distributed systems like K8s uses gRPC for pod communication.

gRPC with k8s is just something that is behind the scenes. You won't need to touch it.


28. Kubelet

Kubelet is responsible for pod internal API communication via the API server. It is a node agent that runs on every single node(control plane and workers).

What is an agent?
An agent is a program installed on a server to observe what occurs for specific programs, and to communicate info externally or trigger actions to be performed.

The kubelet perform the following tasks:
- watches for pod changes
- configures the Container Runtime to
	- pull images
	- create namespaces
	- run containers

Kubelet uses PodSpec files to determine what images to pull and containers to run.

Kubelet will continously monitor Pods of any kinds of changes and send back HTTPs requests to API Server container logs and execution requests.

Can interact with storage through the Container Storage Interface(CSI) using gRPC.


29. KubeCTL

A command line tool that lets you control the K8s cluster.

KubeCTL -> API Server -> K8s components.

```
kubectl [command][type][name][flags]
```

Command - The operation you want to perform

commands:

annotation - key value data that can be applied to resource
apply - executes the manifest files to create/modify k8s resources
auth - crate an autoscaler that automatically chooses and sets the number of pods that run in a k8s cluster.
autoscale - create an autoscaler that auto chooses and sets the number of pods that run in the k8s cluster
cp - copy files and directories from containers.
create - more common to use apply - create specific k8s cluster-level resources: ConfigMap, Deployment, Job, NameSpace, Role, Secret.
delete - delete resources filenames, stdin, resources and names, or by resources and label select.
describe - show details of a specific resource or group of resources.
diff - diffs the online configuration with local config.
edit - edit a resource from the default editor. Edit a deployed manifest file and apply the changes.
exec - execute a command within a container.
expose -  expose a resource as K8s service
get - generally used to get the status of an existing k8s resource
kustomize - print a set of API resources generated from instructions in kustomization.yaml file
label - update labels on a resource
logs - print the logs for a container in a pod or specific resource
patch - update fields of a resource using strategic merge path, a JSON merge path or a JSON patch.
port-forward - forward one or more local ports to a pod.
proxy - creates a proxy server between localhost and the K8s API Server
run - create and run a container image in a pod
scale - set a new size for a Deployment, ReplicaSet, Replication Controller, or StateFul Set.

Type - The resource type you want to command

```
kubectl describe deployments
```

Resource types can have abbreviations:
deployment -> deploy
persistenVolumes -> pv
pods -> pv

There are 50+ resource types.

Name - Specifies the name of the resource

```
kubectl get pod example-pod-1
```

Names are case-sensitive

If the name is omitted, details for all resources are dispolayed.

Flag - Specifies optional flags


#### Distributions

31. MiniKube

Sets up a local-single node k8s cluster for learning purposes. Is running a VM running a control-place and work processes with Docker as the container layer.

32. K3s and K3d

...

33. Kind

...

34. MicroK8s

...

35. Lighweight K8s distribution comparison 

...

36. Managed K8s Providers

Managed K8s providers are Cloud Service Providers or platforms that abstract away the effort of setting up, maintaing(updating and patching) a cluster.
They can do autscaling well.

Google K8s ENgine

Amazon Elastic Kubernetes Service (EKS)

etc...

37. Management Layers

A management layer for running K8s on other platforms or allows you to extend your controll plan to multiple platform.

Different eg Red hat

#### Runtimes

38. Container Runtime Interfaces

Orchestration systems will use a container runtime interface. 

A orchestration chose a Container Runtime Interface, like containerd or CRI-O, and from there it's going to chose a Container Runtime;
native runtime: runC, Crun
sandboxed/virtualized: gviso, nabla-containers, Kata-containers

The Container Runtime INterface Push and pull images, supervise containers

The Container Runtime creates and runs them. The major diff between native and virtual is isolation.

Virt. can provide security benefits through isolation.

39. ContainerD

ContainerD is an industry-standard container runtime with an emphasis on simplicity, robustness and portability.

Docker extracted their runtime and donated it to CNCF.

This includes Dockers functionality for executing containers, handling low-level storage and managing image transfers.

K8s access low-level docker elements instead of acutally using Docker (abstracted away?)

Images you build with Docker arent really Docker Images since Docker uses containerd runtime.

40. CRI-O

An implementation of the K8s CRI (container runtime interface) to enable using OCI compatible runtime.

...

41. Container Runtimes

A key thing to understand is the diff between native and virtualized runtimes.


42. CGroups

First of all, what is a process?

A process is an instance of a running program on Linux.

What is a CGroup?

Control groups allows you to group processes to apply different kinds of limitations:
- resource limiting
- prio
- accounting
- control

The primary design goal for cgroups was to provide a unified interface to manage processes or whole operating-system-level virtualization, including Linux Containers.


43. Linux Containers

LXC is a OS-level virtualization technology that allows creation and running of multiple isolated Linux virtual environments (VE) on a single control host. 

VE vs VMS

VE there is no preloaded emulation manager software as in a VM.

In a VE, the app, (or OS) is spawned in a container and runs with no added overhead, except for usually minuscule VE init process.

No hardware emualation.

...


#### Storage

44. Container Storage Interface

CSI standardize how Container Orchestrator Systems (COS) access to various storage providers.

COS -> CSI -> Storage Providers
K8S -> CSI -> AWS EBS/AZURE DISK

The csi is nothing to worry about as it is abstracted away.

45. K8s Backing Store and etcd

Components of a K8s cluster inlude:pods, nodes, control plane, and volumes, and each of these need a level of protection in case of disaster.

K8s resources are stored in an etcd (but could be backed by MariaDB).
Application data is stored in persistent volumes for applications running on the cluster, but the resources are stored in etcd.

etcd is a strongly conmsistent, distributed key-value store that provides a reliable way to store data that needs to be accessed by a distributed system or cluster of machines.

etcd resides in the control plane node.

Things that use etcd:
 Kubernetes Cluster
 CoreDNs

46. MinIO and Rook
...

47. Volumes

K8s supports many types of volumes.

A pod can use any number of volume types simultaneously.

Persisten Volumes
Attaching an external storage to a pod.
The data will persist even if the pod is terminated.

Ephermal Volumes
A volume that only exists as long as the pod exists.
Intended for temp data storage.

Projected Volumes
maps several existing volume sources into the same dir

Volume Snapshot
Archiving a volume configuration and its data for rollbacks or backup.

48. Persistent Volume

A piece of storage in the cluster that has been provisioned by an admin or dynamically provisioned using Storage Classes.

Worker Node [pod] -> Persistent Volume -> Storage Class Standard [Amazon EBS]

PV is similiar to node in that it is a cluster resource. Does not reside within a node or pod. 

You need to have a Persistent Volume Claim.

PVs are volume plugins like Volumes, but have a lifecycle independent of any individual Pod that uses the PV.

Mounting pv directly to a pod is not allowed and is against the K8s design principles. It would cause tight coupling below the pod volume and the underlying storage. Persistent Volume Claims ensures decoupling.

49. Storage Classes

A storage class is a way of defining a class of storage that is backed by a provisioner.

```
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
	name: standard
provisioner: kubernetes.io/aws-ebs
parameters:
	type: gp2
reclaimPolicy: retain
...
```

Storage class contains:
Provisioner: who is storage? Aws ebs
Parameters: what type of storage of the provisioner to use
reclaimPolicy: if the pod is gone does the volume remain?

50. Persistent Volum Claim

A PVC is used to decouple PV from pods. A PVC asks for a type of storage, and if a PV meets the criteria, the PV is claimed and Bound.
PVCs similiar to a Pod requesting resources from a Node.o

ADD MANIFEST EXAMPLE

51. ConfigMaps

A ConfigMap is an API object used to store non-confidential data in key-value pairs for pods.

Pods can consume ConfigMaps as
- env variables
- command-line arguments
- config files in a volume

ADD MANIFEST EXAMPLE

#### Services


