# Under construction
![Under construction!](https://media.giphy.com/media/5pHGSivKMsgrm/giphy.gif)

# project

###

After clone the repository:

# Prepare AMI
1. Download packer 
https://www.packer.io/downloads

2. Unzip and move packer binary to location in PATH
Example for mac os: 
mv packer /usr/local/bin/

# Create ubuntu based AMI
1. cd packer/ubuntu
2. cp vars_example.json vars.json
3. vim vars.json 
4. Set all the required variables in vars.json file 
(git is set to ignore vars.json)
5. build the AMI:
   packer build -var-file=./vars.json template.json
6. Save the AMI ID from packer output for later use
(ami-083547ef8b8f5b0bc)

# Create s3 bucket for remote state
1. cd s3
2. terraform init
3. terraform apply

# Deploy the infrastructur


# Consul configuration - Todo - Automate this
1. ssh to ansible instance
   ssh -i service_discovery_key.pem ubuntu@<ip>

2. cd ansible
3. Configure ssh to consul cluster
   ansible-playbook configure_ssh.yml -e ansible_python_interpreter=/usr/bin/python3
4. Configure consul
   ansible-playbook -i aws_ec2.yml setup_env.yml -e ansible_python_interpreter=/usr/bin/python3

#### EKS Notes ####
 
1. In order to allow pod running in the EKS cluster which runs kandula, which uses boto3 and need access to ec2 service:
   In the eks-cluster.tf, in the usage of "eks" module -
   we set "enable_irsa" to true:
   enable_irsa = true
   irsa is "IAM roles for service accounts", can read about it in this link:
   https://docs.aws.amazon.com/eks/latest/userguide/iam-roles-for-service-accounts.html
   In short:
   - It create OIDC (open ID connect) provider for our cluster to manage identities
   - We create policy and role with this policy, and in the role trust we define the assume 
   role such that the "role" will trust what it gets from the OIDC provider which is
   a service account in a defined namespace as seen example below.
   The name of the service accout is the service account name that kandula will use, 
   we will create this service account for kandula with annotation that the value will
   be the name of the role
   "Action": "sts:AssumeRoleWithWebIdentity",
         "Condition": {
         "StringEquals": {
            "${OIDC_PROVIDER}:sub": "system:serviceaccount:<my-namespace>:<my-service-account>"
         }
         }

2. In order to allow Jenkins slaves access EKS cluster need to -
   a. After the environement is up run the following to update your kubeconfig file 
      (you can get the cluster_name value from the cluster_name output in terraform)
      note - after we update the configmap i step b, dont we need to get the updated kubeconfig
      , kbeconfig get updated - verify this again (before upload to jenkins in step c)
   aws eks --region=us-east-1 update-kubeconfig --name <cluster_name>

   b. Need to update the aws-auth config map -
      under "mapRoles" section, need to add entry for the "rolearn" we created
      for the jenkins slaves (this role provide access to EKS)
      Example:
      - rolearn: arn:aws:iam::031034181336:role/eks_role 
      username: eks_role
      groups: 
        - system:masters

   c. After install the k8s plugin in Jenkins master, need to create k8s credentials 
      and supply the kubeconfig file

aws eks --region=us-east-1 update-kubeconfig --name project-eks
aws sts get-caller-identity
kubectl edit configmap aws-auth -n kube-system


Need to edit config map and add so:

kubectl edit configmap aws-auth -n kube-system -o yaml

- "groups":
  - "system:masters"
  "rolearn": "arn:aws:iam::783216792412:role/project-ec2-iam-role"
  "username": "project-ec2-iam-role"


  node("amazon-linux2") {
    stage("Deploy") {
     kubernetesDeploy configs: 'k8s/deploy-kandula.yaml', kubeConfig: [path: ''], kubeconfigId: 'k8s', secretName: '', ssh: [sshCredentialsId: '*', sshServer: ''], textCredentials: [certificateAuthorityData: '', clientCertificateData: '', clientKeyData: '', serverUrl: 'https://']
    }
}

node("amazon-linux2") {
    stage("Deploy") {
     kubernetesDeploy configs: 'k8s/deploy-kandula.yaml',kubeconfigId: 'k8s'
     kubernetesDeploy configs: 'k8s/svc-lb-kandula.yaml',kubeconfigId: 'k8s'
    }
}

after installing k8s plugin, need to add k8s credentials - for kube config, i entered the file content option but we can also provide path
for ~/.kube/config (but need somehow to put this file on jenkins, because we can not run the aws command , no aws installed on the jenkins master , we have the ~/.kube/config in the ami)

1. terraform init

2. terraform apply

3. # todo - automate this 
# Configure (manually) configmap aws-auth - To add the Jenkins slave role
Taken from :
https://registry.terraform.io/modules/WesleyCharlesBlake/eks/aws/latest

I did this:
On my mac run:


Under "mapRoles" sectoion add:  todo - use Micky flow
- "groups":
      - "system:nodes"
      "rolearn": "arn:aws:iam::783216792412:role/project-ec2-iam-role"
      "username": "system:node:{{EC2PrivateDNSName}}"

note - 
In docs i see to add "system:masters" group and map to some user name and then
create cluster role binding for that user but i did not do it like so

Also via terraform remote-exec provisioner in Jenkins slave i executed 
aws eks update-kubeconfig --name project-eks --region us-east-1

to create the .kube/config file



4. configure jenkins -
If using then AMI for jenkins then need to add the agents
Otherwise, if using the remote-exex provisioner, hen need to configure jenkins:
In browser enter jenkins load balancer DNS (Example: jenkins-alb-923034631.us-east-1.elb.amazonaws.com)
First add slaves (with lable 'amazon-linux2')
Add credentioals for ec2-user (SSH Username with private key)
Install plugin : SSH Build Agents
- name: jenkins-agent01, also check 'Permanent Agent'
- number of executors: 2
- Remote root directory: (relaibe: ./jenkins-agent)
- Labels: amazon-linux2
- Usage: use this as much as possible
- Launch method: ssh , add slave private ip, and the ssh credentials for the ec2-user added previously
- Host Key Verification Strategy: Non verifiying verification stratrgy
- Availability: Keeping this agent as much as possible
- save
- then press on the node and press - relaunching agent ## Todo - need to add security gropu only for jenkins agents that has inbound rule to allow only jenkins master and also the bastion (and need to remove the sg-jenkins security group from them)





a. Install plugins:
Go to manage Jenkins -> Plugin manager , and install following plugins (check the plugin and press on 'install without restart') 
GitHub Plugin
GitHub Branch Source Plugin
docker
Build Monitor View
○ BlueOcean Aggregator
○ Slack Notification 
Pipeline
Test Results Analyzer
Pyenv Pipeline
Kubernetes Continuous Deploy

b. 
In github: create github app : 
 Go to settings -> developer settings -> GitHub Apps -> New GitHub App (Todo - Add Shakeds' flow here + the convet of the private key)
Add gihhub (GitHub App)

   Add dockerhub (Username with password) - credential id: DockerHub (important because this is how it appears in the Jeninsfile)
- Configure slack:
  Add slack credentials (Secret text)
  manage jenkins -> Configure system -> go to Slack section

  workspace: opsschool