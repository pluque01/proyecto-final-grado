= Introducción

== Contexto y motivación

La transformación digital de los últimos años ha consolidado el uso de servicios
en la nube como parte esencial de la vida cotidiana, tanto a nivel personal como
profesional. Según datos recientes sobre la evolución del mercado de servicios
en la nube @precedence2024-cloud, su adopción global continúa en expansión
impulsada por la digitalización generalizada.

Estas plataformas ofrecen soluciones accesibles y de uso inmediato, lo que ha
impulsado su adopción masiva en ámbitos muy diversos. Sin embargo, esta
dependencia creciente de infraestructuras gestionadas por grandes corporaciones
plantea interrogantes en torno al control de los datos, los costes asociados y
la capacidad de adaptación a necesidades específicas.

Sin embargo, este modelo basado en la externalización de servicios presenta
importantes limitaciones. En primer lugar, supone una dependencia tecnológica de
terceros: la disponibilidad de los datos y la continuidad de los servicios
quedan supeditadas a las decisiones empresariales de los proveedores. Además,
estos servicios implican costes recurrentes, que en muchos casos se acumulan al
combinar distintas plataformas, generando un gasto significativo a largo plazo.

Otro aspecto relevante es la privacidad y el control sobre los datos. El hecho
de que la información personal y profesional se almacene en servidores ajenos
plantea dudas sobre la seguridad y la confidencialidad, ya que los usuarios
deben aceptar políticas de uso que no siempre garantizan un control total sobre
su información. Asimismo, los modelos de negocio basados en la explotación de
datos personales para fines publicitarios intensifican esta problemática. Estas
preocupaciones están alineadas con los principios del Reglamento General de
Protección de Datos (UE 2016/679), que subraya la necesidad de garantizar la
soberanía del usuario sobre su información personal @rgpd2016.

Ante esta situación, surge un interés creciente por las alternativas
autogestionadas de servicios digitales ("self-hosting"), que permiten a los
usuarios desplegar sus propios servicios sobre hardware propio. Gracias a
tecnologías como la virtualización, los contenedores y el software libre, hoy es
posible replicar gran parte de las funcionalidades que ofrecen los proveedores
comerciales, pero sin los inconvenientes mencionados.

El self-hosting no solo responde a la necesidad de reducir costes y reforzar la
privacidad, sino que también fomenta la soberanía digital: la capacidad de los
usuarios para decidir cómo, dónde y bajo qué condiciones se gestionan sus datos
y servicios. Además, brinda un espacio de aprendizaje técnico, al permitir
experimentar con arquitecturas de software modernas en un entorno controlado.

En este contexto, este trabajo se enmarca en la búsqueda de una solución que
permita centralizar servicios personales en una infraestructura propia,
evaluando su viabilidad frente a las alternativas comerciales más habituales.

== Definición del problema

Para precisar mejor el problema, se emplea la técnica de personas, que permite
representar perfiles ficticios con necesidades y objetivos concretos. A partir
de estas descripciones se plantean historias de usuario, que reflejan qué espera
conseguir cada perfil mediante la solución propuesta.

=== Personas identificadas

==== Laura Gómez (estudiante universitaria)

Laura es estudiante de ingeniería y necesita almacenar gran cantidad de apuntes,
trabajos y material académico. Hasta ahora ha utilizado servicios gratuitos como
Google Drive y Dropbox, pero se encuentra con limitaciones de espacio y con la
incomodidad de gestionar varios proveedores. Además, le preocupa que sus datos
estén en servidores externos y no tener control sobre ellos.

Laura busca una alternativa autogestionada que le permita centralizar y
compartir sus documentos académicos en un entorno propio, bajo su control.

==== David Martínez (estudiante universitario)

David es compañero de Laura y utiliza herramientas como Notion o Evernote para
organizar sus notas, ideas y referencias. Aunque estas plataformas le resultan
útiles, depende de servicios comerciales que pueden cambiar sus condiciones de
uso en cualquier momento. David quiere una solución autogestionada que le
permita estructurar y editar sus apuntes de forma colaborativa, integrada con el
sistema de almacenamiento utilizado por su grupo de estudio.

==== Marta Sánchez (administradora de sistemas)

Marta es responsable de la infraestructura informática en una pequeña empresa.
Su equipo maneja decenas de credenciales para distintos servicios y hasta ahora
utilizaban hojas de cálculo compartidas, lo que supone un riesgo de seguridad.
Marta quiere una solución autogestionada que le permita compartir contraseñas de
manera segura y controlada, sin depender de proveedores externos.

== Historias de usuario

=== Laura Gómez (estudiante universitaria)

- HU01: Como estudiante, quiero almacenar mis documentos en un servidor propio,
  para poder acceder a ellos desde cualquier dispositivo sin depender de Google
  Drive o Dropbox.

- HU02: Como estudiante, quiero compartir carpetas con mis compañeros, para
  facilitar el trabajo en grupo de forma sencilla y bajo mi control.

=== David Martínez (estudiante universitario)

- HU03: Como estudiante, quiero organizar mis notas e ideas en una herramienta
  similar a Notion, para tener toda mi información académica centralizada sin
  depender de servicios externos.

- HU04: Como estudiante, quiero acceder a mis notas desde distintos
  dispositivos, para poder continuar mi trabajo académico en cualquier lugar.

=== Marta Sánchez (administradora de sistemas)

- HU05: Como administradora de sistemas, quiero compartir ciertas contraseñas
  con mis compañeros de forma controlada, para que cada usuario tenga acceso
  únicamente a la información que necesita.

== Objetivos del trabajo

El presente trabajo tiene como finalidad diseñar e implementar una
infraestructura de servicios digitales autogestionados que permita sustituir
parcialmente soluciones comerciales de uso cotidiano, garantizando mayor control
sobre los datos, reducción de costes y flexibilidad en la personalización.

=== Objetivo general

Diseñar e implementar una infraestructura de self-hosting basada en software
libre y desplegada mediante contenedores, que proporcione servicios de
almacenamiento de archivos, toma y organización de notas, y gestión de
contraseñas como alternativa a las plataformas comerciales más habituales.

=== Objetivos específicos

+ Desplegar y configurar Nextcloud como sistema de sincronización y compartición
  de documentos, permitiendo tanto el acceso multiplataforma como el trabajo
  colaborativo en grupos reducidos.

+ Implementar una herramienta de notas y organización personal que permita a los
  estudiantes centralizar y estructurar su información académica como
  alternativa a plataformas comerciales como Notion o Evernote.

+ Integrar un gestor de contraseñas autogestionado para almacenar de manera
  segura credenciales personales o de equipo, permitiendo el acceso controlado y
  compartido según las necesidades.

+ Desplegar todos los servicios mediante contenedores, favoreciendo la
  portabilidad, el mantenimiento y la escalabilidad de la solución.

+ Realizar un análisis frente a servicios comerciales equivalentes, evaluando
  aspectos como coste, facilidad de uso, privacidad, flexibilidad y seguridad.

+ Elaborar una guía de instalación y configuración de los servicios, con el fin
  de que la propuesta pueda ser replicada por otros usuarios interesados en
  adoptar soluciones autogestionadas.
