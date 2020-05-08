## Casos de uso

### Identidad corporativa – Badge

1.	Credencial de identidad corporativa del empleado

### Médicos – Autorización para trabajar

1.	Credencial de autorización para trabajar
2.	Credencial de test negativo
3.	Credencial de temperatura baja

### Buenas prácticas - Gamificación

1.	Credencial/Token de llevar máscara
2.	Credencial/Token de lavarse las manos
3.	Credencial/Token de tomarse la temperatura

### Preguntas a responder

¿Cuál es el tiempo de expiración de la credencial? 
¿Desde dónde se emiten las credenciales (desde un teléfono móvil o desde una computadora)? 
¿Cómo se verifican las credenciales (desde un dispositivo genérico o desde un celular personal)? 
¿Para qué se van a usar las credenciales? 
¿Bajo qué condiciones se revocan las credenciales? 


## IMPLEMENTACIÓN

### Solución genérica/estándar

**On-boarding de usuario regular**

1.	El usuario descarga la billetera (tras recibir un mail con instrucciones)
2.	El usuario se registra con su información personal para contra la billetera (e.g. celular, e-mail, biometría, user y password)
3.	Se le genera un DID al usuario y unas llaves públicas asociadas como mecanismos de autenticación
4.	El usuario, que ha debido de recibir algún tipo de código (password o QR) de su organización vía email a su mail corporativo, introduce este código en la billetera
5.	Se le genera al usuario una credencial verificable de IDENTIDAD CORPORATIVA que tiene como DID el del usuario  y se registra en una base de datos corporativa la indexación DID – Data Empleado

**On-boarding de la entidad corporativa y sus representantes (personas o dispositivos)**

1.	Se genera en la fase de desarrollo un DID y unas llaves públicas asociadas como mecanismos de autenticación. Este DID es el DID de la ENTIDAD CORPORATIVA.
2.	En un servicio de la ENTIDAD CORPORATIVA se guardan las claves privadas necesarias para poder eliminar otras claves/mecanismos de autenticación y para poder recuperar claves en caso de necesidad.	

*Opción A – Mediante billeteras*

A3. Los representantes individuales se descargan la billetera, se autentican, y reciben su DID como usuarios regulares

A4. A los representantes individuales se les autoriza en la identidad de la ENTIDAD CORPORATIVA a poder emitir cierto tipo de credenciales en su nombre, por ejemplo mediante el control de ciertas claves privadas que corresponden a mecanismos de autenticación del DID document (DELEGACIÓN DE IDENTIDAD)

*Opción B – Vía web*

B3. Los representantes se registran en la web con usuario y contraseña y con un código identificador proporcionado por la ENTIDAD CORPORATIVA

B4. En el back-end se conecta estos usuarios con la identidad del DID de la ENTIDAD CORPORATIVA de manera que cuando emiten credenciales lo hacen firmando con las llaves del DID document de la ENTIDAD CORPORATIVA

**On-boarding de terceros de confianza que emiten credenciales con la autoridad de la ENTIDAD CORPORATIVA  (por ejemplo dispositivos IOT para medir temperatura o médicos de la entidad), que no usen directamente la entidad de la ENTIDAD CORPORATIVA**

1.	El usuario descarga la billetera (tras recibir un mail con instrucciones)
2.	El usuario se registra con su información personal para contra la billetera (e.g. celular, e-mail, biometría, user y password)
3.	Se le genera un DID al usuario y unas llaves públicas asociadas como mecanismos de autenticación
4.	El usuario, que ha debido de recibir algún tipo de código (password o QR) de su organización vía email a su mail corporativo, introduce este código en la billetera
5.	Se le genera al usuario una credencial verificable de PERSONA AUTORIZADA CORPORATIVA que tiene como DID el del usuario  y se registra en una base de datos corporativa la indexación DID – Data Empleado

### Generación y envío de credenciales

1.	La ENTIDAD CORPORATIVA o la PERSONA AUTORIZADA seleccionan en su billetera o en la web la credencial que quieren generar (esta opción debe ser implementada)
2.	La ENTIDAD CORPORATIVA o la PERSONA AUTORIZADA especifica a qué DID le quiere emitir la credencial. Pueden o bien introducirlo a mano o bien escanear un código QR proporcionado por el usuario.
3.	La credencial se envía al endpoint de la ENTIDAD CORPORATIVA o la PERSONA AUTORIZADA. 
4.	Un servicio identifica el DID al cual se le acaba de generar, va a la blockchain a buscar en el DID document el endpoint del usuario (que puede ser su email o directamente su billetera) y le notifica de que ha recibido una credencial
5.	De manera manual o automática el usuario descarga la credencial en su billetera (sería recomendable hacerlo de manera manual, teniendo que validar la entidad que envía la billetera, de manera que se evitan descargas automáticas. Podrían introducirse filtros para aceptar solo credenciales emitidas por entidades conocidas)

### Verificación de credenciales

A1. El usuario selecciona la credencial que quiere presentar y muestra su código QR, que el verificador escanea 
A2. El servicio (en principio la propia billetera) que escanea la credencial, aplica el protocolo de verificación de LACChain ID (ver Anexo).
	B1. El usuario envía la credencial electrónicamente, con su firma y un timestamp a un 	endpoint indicado
B2. El servicio que recibe la credencial aplica el protocolo de verificación de LACChain ID (ver Anexo).

### Revocación de credenciales

1.	La ENTIDAD CORPORATIVA o la PERSONA AUTORIZADA seleccionan qué credencial quieren revocar (deberían de poder ver un listado de credenciales emitidas y poder revocarlas).
2.	Se hace una llamada a la función revocar del contrato inteligente donde se registran las credenciales y se cambia su estatus a revocada
Recuperación de claves y credenciales

**Del usuario regular**

1.	Back up automático en el repositorio cloud financiado por la ENTIDAD CORPORATIVA

**De usuarios privilegiados**

1.	Back up automático en el repositorio cloud financiado por la ENTIDAD CORPORATIVA


### Requisitos de funcionamento del back-end

1.	Cada billetera despliega un DID registry para el DID method elegido, o se apunta a un DID registry desplegado por el BID
2.	Cuando se genera el DID, ha de generarse también un DID document ON CHAIN con mecanismos de autenticación adicionales al principal que permitan la recuperación de la identidad, de manera que esas llaves privadas se guarden en un back-up fuera de la billetera (e.g. cloud)
3.	La credencial verificable de IDENTIDAD CORPORATIVA está emitida por la entidad corporativa desde un servicio central, con su propio DID
4.	Las credenciales las genera siempre el emisor. Cada emisor ha de tener un contrato inteligente cuya dirección aparezca en la credencial, en el que se registra el ID de la credencial en el momento en que se emite junto a su estatus (por defecto activo).
5.	Cuando las credenciales se emiten son guardadas en una base de datos en poder de la ENTIDAD CORPORATIVA, y de ahí las billeteras directamente consultan y descargan. Idealmente, la billetera debería recibir una notificación cuando tienen una credencial, o descargarlas automáticamente.



## LISTADO DE ROLES Y ACTIVOS DIGITALES


### Roles

Entidad corporativa

Persona autorizada de entidad corporativa

Tercero de confianza de entidad corporativa

Usuario regular

### Credenciales de identidad

Credencial de identidad corporativa

Credencial de persona autorizada corporativa

### Credenciales de casos de uso

Credencial de autorización para trabajar
	
Credencial de test negativo

Credencial de no fiebre
	
Token de llevar máscara

Token de lavarse las manos

Token de tomarse la temperatura

### Servicios

Billetera
	
Servicio para guardar y solicitar credenciales emitidas

Smart contract para registro y consulta de estatus de credenciales
