== [M4] Compartición segura de contraseñas<cap:5_m4>

Este milestone amplía el PMV anterior, centrando el alcance en la compartición
segura de credenciales entre los miembros del equipo dentro de la plataforma
autogestionada de Nextcloud. El objetivo es permitir que cada usuario acceda
únicamente a las contraseñas que necesita, garantizando trazabilidad, control de
permisos y revocación individual sin introducir nuevos servicios externos ni
modificar la arquitectura base desplegada en la @cap:5_m2.

=== Objetivo del PMV

El propósito de este hito es dotar a la instancia de Nextcloud de un sistema
nativo de gestión y compartición de contraseñas que permita:

- Compartir entradas individuales con otros usuarios.
- Definir permisos de lectura o edición, con posibilidad de revocación
  inmediata.
- Mantener cifrado extremo a extremo y trazabilidad de accesos.
- Integrarse con los mecanismos de autenticación, auditoría y seguridad ya
  disponibles en la plataforma.

El objetivo no es crear un gestor de contraseñas independiente, sino aprovechar
las capacidades existentes del ecosistema Nextcloud para ofrecer un entorno
seguro, colaborativo y fácilmente administrable.

=== Alternativas de implementación

==== Criterios de elección

La elección de la solución se guio por los siguientes principios:

- Integración con la infraestructura existente.
- Mantenimiento activo para evitar vulnerabilidades.
- Facilidad de uso y mantenimiento.
- Evitar la introducción de contenedores o servicios adicionales.

==== Evaluación de alternativas

- Archivo KeePass compartido: KeePass es uno de los gestores de contraseñas de
  código abierto más populares. La primera versión es del año 2003, pero sigue
  recibiendo actualizaciones regulares. KeePass es uno de los gestores de
  contraseñas de código abierto más populares. La primera versión es del año
  2003, pero sigue recibiendo actualizaciones regulares. Permite el
  almacenamiento cifrado de credenciales dentro de una carpeta compartida en
  Nextcloud.

- Aplicaciones integradas de Nextcloud:
  - *Passwords* #footnote("https://apps.nextcloud.com/apps/passwords"):
    Aplicación oficial del ecosistema Nextcloud destinada a la gestión y
    compartición segura de contraseñas. Permite crear, organizar y compartir
    entradas individuales con usuarios o grupos, definir permisos de lectura o
    edición, revocar accesos de forma inmediata y auditar la actividad.

  - *Passman* #footnote("https://apps.nextcloud.com/apps/passman"): Es el gestor
    de contraseñas más antiguo de Nextcloud @nextcloud_passwords_blog y a día de
    hoy tiene un mantenimiento irregular @nextcloud_passman_pulse. Ofrece
    funcionalidades similares a Passwords, pero con una interfaz menos pulida y
    menor integración con las nuevas características de Nextcloud. No tiene
    aplicación nativa para iOS.

- Otros gestores externos autoalojados:
  - Vaultwarden #footnote("https://github.com/dani-garcia/vaultwarden"):
    Implementación ligera y autoalojada de Bitwarden #footnote(
      "https://bitwarden.com",
    ). Permite compartir contraseñas entre usuarios con control granular de
    permisos y auditoría.

    Ofrece funciones avanzadas como colecciones, políticas o integración con
    SSO, pero implican operar nuevos servicios y una mayor complejidad de
    despliegue.

==== Justificación de la elección

Para este PMV se adopta la aplicación oficial Passwords de Nextcloud como
solución óptima. Es la única alternativa que cumple simultáneamente con los
principios definidos: integración nativa con la infraestructura existente,
mantenimiento activo, facilidad de uso y ausencia de nuevos servicios externos.

A diferencia del enfoque basado en KeePass, que gestiona el acceso a nivel de
archivo completo y puede generar conflictos en la sincronización colaborativa,
Passwords permite definir permisos sobre cada entrada individual, otorgando o
revocando accesos de forma inmediata y sin afectar al resto de las credenciales.
Además, su modelo de datos evita inconsistencias entre usuarios concurrentes y
mantiene trazabilidad de todas las operaciones mediante la aplicación Activity
de Nextcloud @nextcloud_activity_docs.

Frente a los gestores externos autoalojados como Vaultwarden, Passwords presenta
una ventaja clara en simplicidad operativa. No requiere configurar nuevos
contenedores, bases de datos ni certificados adicionales, y aprovecha por
completo la gestión de usuarios, grupos y autenticación ya existente en
Nextcloud. De este modo, se minimiza la superficie de ataque y se mantiene un
único punto de administración.

Por último, el hecho de que Passwords sea una aplicación oficial mantenida por
la comunidad de Nextcloud garantiza actualizaciones continuas y compatibilidad
con futuras versiones de la plataforma, reduciendo el riesgo de vulnerabilidades
o abandono. En conjunto, esta solución ofrece el mejor equilibrio entre
seguridad, mantenibilidad y coherencia.
