== [M4] Compartición segura de contraseñas<cap:5_m4>

Este milestone amplía el PMV anterior, centrando el alcance en la compartición
segura de credenciales entre los miembros del equipo dentro de la plataforma
autogestionada de Nextcloud. El objetivo es permitir que cada usuario acceda
únicamente a las contraseñas que necesita, garantizando trazabilidad, control de
permisos y revocación individual sin introducir nuevos servicios externos ni
modificar la arquitectura base desplegada en la @cap:5_m2.

=== Objetivo del PMV

El propósito de este milestone es dotar a la instancia de Nextcloud de un
sistema nativo de gestión y compartición de contraseñas que permita:

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

=== Despliegue e integración

Al tratarse de una ampliación funcional sobre la infraestructura ya desplegada
en la @cap:5_m2, no ha sido necesario modificar la configuración de red, proxy
ni contenedores. El despliegue se realizó directamente sobre el servicio de
Nextcloud existente, utilizando el propio sistema de gestión de aplicaciones.

Desde la interfaz de administración y de igual manera que en la
@cap:5_m3_deployment, se instaló la aplicación Passwords, disponible en el
catálogo oficial de Nextcloud. La instalación no requirió reinicio del servicio
ni ajustes adicionales, y la aplicación quedó habilitada para todos los usuarios
de la instancia. Cada usuario dispone de un espacio de trabajo personal donde
puede almacenar, organizar y clasificar sus credenciales en colecciones o
carpetas privadas.

En materia de seguridad, se activó la autenticación de doble factor ("2FA") para
las cuentas con acceso a credenciales sensibles (@figure:5_m4_2fa). Además, se
configuró la aplicación Activity para registrar los eventos de acceso,
modificación, creación y compartición de contraseñas, proporcionando una
auditoría completa sobre la gestión de secretos
(@figure:5_m4_push_notifications).

#figure(
  image("../../Figures/Chapter5/m4/2fa-enforced.png", width: 100%),
  caption: [Cuando un usuario del grupo de trabajo accede a Nextcloud, se le
    solicita que configure la autenticación de doble factor.],
)<figure:5_m4_2fa>

#figure(
  image(
    "../../Figures/Chapter5/m4/push-notification-passwords-ios.png",
    height: 70%,
  ),
  caption: [Junto con Activity, Nextcloud envía notificaciones push
    @ibm_push_notifications a los dispositivos móviles.],
)<figure:5_m4_push_notifications>

=== Validación del milestone

La validación del milestone se ha realizado verificando el cumplimiento de la
historia de usuario HU05, centrada en la compartición controlada de contraseñas
a varios usuarios. Para ello se llevaron a cabo distintas pruebas funcionales
sobre la instancia desplegada de Nextcloud con la aplicación Passwords
habilitada.

==== Compartición controlada de contraseñas (HU05)

En primer lugar, se evaluó la capacidad de la aplicación para compartir
credenciales de forma individual con usuarios específicos. El administrador de
un grupo de trabajo creó una serie de entradas de prueba
(@figure:5_m4_dashboard_passwords) y procedió a compartirlas con distintos
usuarios con niveles de permiso diferenciados
(@figure:5_m4_password_share_permissions).

Para el usuario David Martínez, se otorgaron permisos de lectura y edición,
indicados por el primer icono en la interfaz de compartición. Para el usuario
Miguel Rosado, no se concedieron permisos de edición, lo que se refleja en la
ausencia del primer icono. La segunda opción permite definir si el usuario puede
compartir la contraseña con otros usuarios. La tercera opción establece una
fecha de expiración para el acceso compartido. Finalmente, la cuarta opción
permite revocar inmediatamente el acceso compartido.

Finalmente, se probó la revocación inmediata del acceso para el usuario Miguel
Rosado, verificando que la credencial dejaba de estar visible en su cuenta tras
la actualización de permisos.

Durante las pruebas se comprobó que los cambios de permisos se aplican de forma
inmediata y que las acciones quedan registradas, lo que permite auditar las
operaciones de modificación (@figure:5_m4_passwords_revisions).

#figure(
  image("../../Figures/Chapter5/m4/dashboard-passwords.png", width: 100%),
  caption: [Lista de contraseñas creadas en la aplicación Passwords de
    Nextcloud.],
)<figure:5_m4_dashboard_passwords>

#figure(
  image(
    "../../Figures/Chapter5/m4/password-share-permissions.png",
    width: 80%,
  ),
  caption: [Definición de permisos al compartir una contraseña con otro
    usuario.],
)<figure:5_m4_password_share_permissions>

#figure(
  image("../../Figures/Chapter5/m4/password-revisions.png", width: 80%),
  caption: [Modificaciones realizadas sobre una contraseña compartida.],
)<figure:5_m4_passwords_revisions>

==== Limitaciones observadas

La aplicación Passwords cumple los requisitos funcionales definidos en la HU05,
aunque presenta una limitación estructural relevante: no permite compartir
colecciones completas ni asignar permisos a grupos, de modo que la compartición
debe realizarse manualmente con cada usuario destinatario. Esto, para equipos
grandes supone una carga administrativa significativa y puede dificultar la
adopción de esta herramienta. Sin embargo, para equipos pequeños concebidos en
este PMV, esta limitación es asumible.

A pesar de esta restricción, el sistema validado satisface plenamente el
objetivo del milestone, al permitir compartir contraseñas de forma selectiva y
segura, manteniendo trazabilidad, cifrado y control operativo sin añadir
complejidad a la infraestructura.

=== Conclusiones del milestone

Este milestone incorpora la capacidad de gestionar y compartir contraseñas de
forma selectiva dentro del entorno colaborativo de Nextcloud, cumpliendo los
objetivos planteados en la historia de usuario HU05. La adopción de la
aplicación oficial Passwords permite ampliar las funciones del sistema sin
modificar la infraestructura ni introducir nuevos componentes.

La solución elegida ofrece un equilibrio adecuado entre seguridad, simplicidad y
control, al proporcionar cifrado extremo a extremo, revocación inmediata de
accesos y trazabilidad. Su integración nativa con la gestión de usuarios y la
autenticación de doble factor (2FA) disponible de forma nativa, garantiza
coherencia con el diseño y las políticas de seguridad ya establecidas.

Si bien Passwords presenta la limitación de no permitir la compartición por
grupos ni colecciones completas, esta restricción no afecta de forma
significativa al contexto operativo previsto, donde el número de usuarios es
reducido y la compartición individual resulta suficiente. En escenarios de mayor
escala, podría valorarse la adopción de un gestor externo como Vaultwarden,
capaz de ofrecer políticas más avanzadas de control y organización.

En conjunto, el milestone consolida la plataforma como un entorno colaborativo
autoalojado capaz de gestionar información sensible de manera segura, ampliando
su madurez funcional sin incrementar la complejidad operativa.
