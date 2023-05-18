# Customer Data  Terraform

## Introducción
El objetivo del proyecto es proporcionar la automatización suficiente para poder desplegar la infraestructura sobre AWS 

## Requisitos
* [Terraform](https://www.terraform.io/)

## Diagrama
A contiunación vemos el diagrama de la infraestructura desplegada.



## Preparación
Como medidas iniciales para poder utilizar la LZ debemos realizar las siguientes actuaciones:
* Crear una cuenta de AWS dentro de la organización
* Aprovisionar una cuenta de servicio llamada terraform sobre el IAM de la cuenta de AWS, con permisos elevados "Administrator access", que configuraremos en el fichero providers-'entorno'.tf.json de cada data/entorno
* Aprovisionar de un S3 sobre la cuenta de AWS para la persistencia del estado de terraform, que se configura en el fichero backend.tf.json de cada data/entorno

## Configuración entorno local
Se han establecido como requisitos el poder tener instalado el framework de terraform, lenguaje de aprovisionamiento de infraestructura sobre el cloud de AWS. Además debemos configurar las credenciales en nuestro entorno para su uso. Podemos hacerlo:
* de forma asistida con el comando
    ```
    aws config
    ```
* directamente sobre el fichero 
    ```
    .aws/credentials
    ```
    creando las siguientes entradas con los valores de aws_access_key_id y aws_secret_access_key

    | Profile |
    | --- |
    | tfservice-customer-data |


## Ejecución
Debemos lanzar los siguientes scripts para preparar los workspaces. Dependiendo de lo que queremos aprovisionar lanzaremos uno de los siguiente comandos.

### Limpiar workspace

```shell
./bin/clean.sh # Limpia el workspace
```

### Preparación workspaces
Con estos scripts preparamos el workspace para poder lanzarlo desde terraform

```shell
./bin/dcustomer-data.sh # Prepara Workspace 

```

### Secuencia de Terraform

Inicialización del proyecto
```shell
terraform -chdir=workspace init
```

Plan de la ejecución
```shell
terraform -chdir=workspace plan
```

Ejecución
```shell
terraform -chdir=workspace apply
```

> **_NOTE:_**  Es importante lanzar todos estos comandos desde el directorio root del proyecto.


### Cuentas AWS
A continuación listamos las cuentas de AWS que conforman la organización de AWS

| Cuenta AWS | email | Observaciones |
| --- | --- | --- |
| customer data |  customer-data@nubox.com | Owner de la cuenta de customer data |


Estas direcciones de mail deben ser grupos de mail o listas de distribución para que lleguen los mails a los usuarios suscritos



## Network

### VPC

| Entorno | VPC | Rango | Total |
| --- | --- | --- | --- |
| PROD | customer-data-prod-svc-vpc | 10.94.0.0/20 |



### Subnets

| Entorno | VPC | Subnet | Zona | Rango |
| --- | --- | --- | --- | --- |
| PROD | ustomer-data-prod-svc-vp | customer-data-prod-svc-subnet-public-1 | eu-west-1-a | 10.94.6.0/26 |  
| PROD | ustomer-data-prod-svc-vp | customer-data-prod-svc-subnet-public-2 | eu-west-1-c | 10.94.6.64/26 | 
| PROD | ustomer-data-prod-svc-vp | customer-data-prod-svc-subnet-private-1 | eu-west-1-a | 10.94.0.0/23 | 
| PROD | ustomer-data-prod-svc-vp | customer-data-prod-svc-subnet-private-2 | eu-west-1-c | 10.94.2.0/23 |



### Security Groups

> **Alert**: REVISAR

| Security Group | Entorno | Tipo | Descripcion |
| --- | --- | --- | --- |


#### Security Group Rules
     
> **Alert**: REVISAR

| Security Group | Ingress/Egress | ID | Protocol | Port | CIDR |
| --- | --- | --- | --- | --- | --- |
