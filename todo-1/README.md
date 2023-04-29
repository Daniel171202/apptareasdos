# Ejemplo de Backend para Aplicación TODO

## Lenguajes y herramientas:

Este proyecto utiliza:

. Java 17 SDK (se recomienda su gestión con SDKMan)
. Spring-Boot Framework

## Como construir

Para construir el proyecto ejecute:

```bash
./mvnw clean package
````

Para correr el proyecto ejecute:
```bash
./mvnw spring-boot:run
```

## Ejecución con Chaos Engeenering

Para ejecutar en modo Chaos Engeenerin se de invocar de la siguiente manera:

```bash
./mvnw clean package spring-boot:run -Dspring-boot.run.profiles=chaos-monkey
```
