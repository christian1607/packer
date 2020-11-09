# Packer 

Packer es una herramienta que nos permite construir infraestructura inmutable de manera sencilla y que ademas soporta 
una gran variedad de proveedores tanto cloud como privados


## Requisitos

- Packer instalado v 1.5.1
- Credenciales de acuerdo al tipo de ejcucion definidas en un archivo variables.json

## Como Ejecutar
Para ejecutar solo debes de ingresar a cada folder y ejecutar el siguiente comando:

`packer build -var-file=variable.json file.json`

**NOTA: Cambiar file.json por el que se encuentre en cada carpeta**