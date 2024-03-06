# *** MSK AWS CLOUDFORMATION ***

### [*] vpc-vpn.yml
- https://docs.aws.amazon.com/vpn/latest/clientvpn-admin/mutual.html
- aws cloudformation create-stack --stack-name <name_stack> --template-body file://vpc-vpn.yml
- Descargamos fichero de configuración VPN CLIENT, conectamos con ec2 instance e instalamos agente ssm
- https://docs.aws.amazon.com/systems-manager/latest/userguide/agent-install-al2.html
- Activamos SSM Host Management (Administrador de flotas)
- Modificamos rol asociado a ec2. Permisos para MSK, SSM, AmazonSSMManagedInstanceCore, AmazonSSMPatchAssociation.

### [*] msk.yml
- Actualizamos subredes de despliegue (script-powershell/vpc-info.ps1)
- aws ssm send-command --document-name "AWS-RunShellScript" --targets "Key='tag:msk:project-id',Values=msk-ec2-cloudformation" --cli-input-json file://script-bash.json
- Agregamos al grupo de seguridad de msk cluster, el grupo de seguridad de la maquina ec2. Regla de entrada y Regla de salida.
- Conectamos a la instancia ec2 y con todos los ficheros descargados lanzamos el siguiente comando.
- <path-to-your-kafka-installation>/bin/kafka-topics.sh --create --bootstrap-server <broker_node> --command-config client.properties --replication-factor 1 --partitions 1 --topic MSKTutorialTopic
