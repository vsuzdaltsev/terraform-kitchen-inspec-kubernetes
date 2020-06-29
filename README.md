# Dokerized env for running inspec tests within kubernetes deployed in AWS

```
docker run -it vsuzdaltsev/terraform-kitchen-inspec-k8s:latest bash
```
Supports the following transports:
```
inspec exec <k8s_profile>   -t k8s://   
inspec exec <local_profile> -t local://   
inspec exec <ssh_profile>   -t ssh://   
inspec exec <aws_profile>   -t aws://
