# Dokerized env for running inspec tests within kubernetes deployed in AWS

```
docker run -it vsuzdaltsev/terrafrom-kitchen-inspec-k8s:latest bash
```
Supports the following transports:
```
inspec exec -t <k8s_profile>   k8s://   
inspec exec -t <local_profile> local://   
inspec exec -t <ssh_profile>   ssh://   
inspec exec -t <aws_profile>   aws://