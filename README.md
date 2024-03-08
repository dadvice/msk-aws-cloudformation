# *** CLOUDFORMATION ***

Servicios puestos en practica.
- AWS VPC
- AWS NatGateway
- AWS VPN Client
- AWS MSK
- AWS SSM
- AWS EC2

Despliegue de infraestructura con plantillas de cloudformation. Creación de una nueva VPC con 2 redes privadas y una pública, habilitando conexión con el exterior para las subredes privadas con 
NatGateway. Creación de un método de acceso a la VPC mediante VPN Client basado en certificados y despliegue de instancia linux Amz2023 para probar conexión con MSK.

Creación de un cluster de kafka aprovechando el servicio de AWS MSK con dos brokers nodes, habilitando acceso a ambos nodos desde la maquina ec2.

Se añade un script en powershell que hace uso de aws cli para obtener las vpcs desplegadas en la región elegida para obtener datos necesarios para desplegar msk.yml.

### [*] vpc-vpn.yml
- https://docs.aws.amazon.com/vpn/latest/clientvpn-admin/mutual.html
- aws cloudformation create-stack --stack-name <name_stack> --template-body file://vpc-vpn.yml
- Descargamos fichero de configuración VPN CLIENT, añadimos "<cert>" "<key>" al fichero y conectamos con ec2 instance e instalamos agente ssm
- https://docs.aws.amazon.com/systems-manager/latest/userguide/agent-install-al2.html
- Activamos SSM Host Management (Administrador de flotas)
- Modificamos rol asociado a ec2. Permisos para MSK, SSM, AmazonSSMManagedInstanceCore, AmazonSSMPatchAssociation.

### [*] msk.yml
- Actualizamos subredes de despliegue msk.yml (script-powershell/vpc-info.ps1)
- aws ssm send-command --document-name "AWS-RunShellScript" --targets "Key='tag:msk:project-id',Values=msk-ec2-cloudformation" --cli-input-json file://script-bash.json
- Agregamos al grupo de seguridad de msk cluster, el grupo de seguridad de la maquina ec2. Regla de entrada y regla de salida.
- Conectamos a la instancia ec2 y con todos los ficheros descargados lanzamos el siguiente comando.
- <path-to-your-kafka-installation>/bin/kafka-topics.sh --create --bootstrap-server <broker_node> --command-config client.properties --replication-factor 1 --partitions 1 --topic MSKTutorialTopic
