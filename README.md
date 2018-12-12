**Install and Creating kops cluster with Ansible**

1. Make sure you have ansible in your environment, and configured aws profile on ~/.aws/profile_name
2. Clone this play book to your folder
https://github.com/npban/kops-ansible
3. Check the make file: 

```
[centos@puppet kops]# cat Makefile 
env ?= stg
aws_profile ?= ims
project ?= natrol
aws_region ?= ap-southeast-2
domain_name ?= test.com

create-kops:	
	AWS_PROFILE=${aws_profile} ansible-playbook install_kops.yaml -e project=${project} -e env=${env} -e aws_profile=${aws_profile} -e aws_region=${aws_region}
```

4. Create a K8s cluster easy with kops: 


```
[centos@puppet kops]#  make create-kops project=blah_project env=staging aws_profile=profile_name aws_region=your_region
[root@puppet centos]# export AWS_PROFILE=huy; kops validate cluster
Validating cluster k2-stg-huy.k8s.local

INSTANCE GROUPS
NAME			ROLE	MACHINETYPE	MIN	MAX	SUBNETS
master-ap-southeast-2a	Master	m3.medium	1	1	ap-southeast-2a
nodes			Node	t2.micro	1	1	ap-southeast-2a

NODE STATUS
NAME							ROLE	READY
ip-172-20-56-117.ap-southeast-2.compute.internal	master	True
ip-172-20-57-190.ap-southeast-2.compute.internal	node	True

Your cluster k2-stg-huy.k8s.local is ready
```

5. Check ansible playbook skeleton:

```
[root@puppet centos]# tree kops/
kops/
├── ansible.cfg
├── install_kops.yaml
├── inventory
│   └── hosts
├── Makefile
├── out
│   └── terraform
│       ├── data
│       │   ├── aws_iam_role_masters.huy1.k8s.local_policy
│       │   ├── aws_iam_role_masters.huy.k8s.local_policy
│       │   ├── aws_launch_configuration_master-ap-southeast-2a.masters.huy.k8s.local_user_data
│       │   ├── aws_launch_configuration_master-ap-southeast-2a.masters.k1-stg-│       │   ├── aws_launch_configuration_nodes.huy1.k8s.local_user_data
│       │   ├── aws_launch_configuration_nodes.huy.k8s.local_user_data
│       │   ├── aws_launch_configuration_nodes.k1-stg-huy.k8s.local_user_data
│       └── kubernetes.tf
├── roles
│   ├── bootstrap_env
│   │   ├── tasks
│   │   │   └── main.yaml
│   │   └── templates
│   │       └── environment.j2
│   ├── configure_kops
│   │   └── tasks
│   │       └── main.yaml
│   └── install_kops
│       ├── files
│       │   └── policy.json
│       ├── tasks
│       │   └── main.yaml
│       └── templates
│           └── policy.json.j2
└── vars
    ├── common.yaml
    └── secret.yaml
```

**Enjoy coding :)**

