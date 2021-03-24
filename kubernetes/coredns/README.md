# Coredns workshop
Welcome to the coredns workshop. To better understand how coredns works as a standalone dns server and as a dns service inside kuberentes follow these steps: 

1. Clone this repo
2. Update `vpc-id` in [variables.tf](coredns-server/variables.tf)
3. Execute the terraform script
```bash
terraform init
terraform apply --auto-approve 
```
3. SSH into one of the servers 
>**NOTE:** use the `coredns_key.pem` created by the terraform
4. Edit db.opsschool.example file at /etc/coredns/zones and replace ip address with your ec2 private ip address
```
opsschool.internal.        IN  SOA dns.opsschool.internal. admin.opsschool.internal. 2020010812 7200 3600 1209600 3600
server1.opsschool.internal.   IN  A      <first server>
server2.opsschool.internal.   IN  A      <second server>
```

5. Start CoreDNS:
```
coredns -dns.port=1053 -conf=Corefile
```
6. test DNS query resolution:
```
dig @localhost -p 1053 server1.opsschool.internal
dig @localhost -p 1053 server2.opsschool.internal
dig @localhost -p 1053 opsschool.org.il
```
