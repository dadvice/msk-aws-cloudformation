# *** MSK AWS CLOUDFORMATION ***

### [*] vpc-vpn.yml
- https://docs.aws.amazon.com/vpn/latest/clientvpn-admin/mutual.html
- aws cloudformation create-stack --stack-name <name_stack> --template-body file://vpc-vpn.yml
- Descargamos fichero de configuración VPN CLIENT, conectamos con ec2 instance e instalamos agente ssm
- https://docs.aws.amazon.com/systems-manager/latest/userguide/agent-install-al2.html
- Activamos SSM Host Management (Administrador de flotas)
- Modificamos Role Asociado a ec2. Permisos para MSK, SSM, AmazonSSMManagedInstanceCore, AmazonSSMPatchAssociation.
