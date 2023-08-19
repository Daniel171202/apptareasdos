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
: Servlet.service() for servlet [dispatcherServlet] in context with path [] threw exception [Request processing failed: org.springframework.web.multipart.MultipartException: Current request is not a multipart request] with root cause

org.springframework.web.multipart.MultipartException: Current request is not a multipart request