env ?= stg
aws_profile ?= ims
project ?= natrol
aws_region ?= ap-southeast-2
domain_name ?= test.com

create-kops:	
	AWS_PROFILE=${aws_profile} ansible-playbook install_kops.yaml -e project=${project} -e env=${env} -e aws_profile=${aws_profile} -e aws_region=${aws_region}