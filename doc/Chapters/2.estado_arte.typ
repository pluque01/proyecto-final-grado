= Estado del arte

== Introducción

En este capítulo se revisa el estado del arte de las principales herramientas de
software libre que permiten montar un entorno de productividad autoalojado. El
análisis se centra en cuatro áreas clave: almacenamiento y colaboración de
archivos, toma de notas, gestión de contraseñas y despliegue con contenedores.
Además, se contrasta cada alternativa con servicios comerciales ampliamente
utilizados y se definen los criterios que servirán de base para la evaluación en
capítulos posteriores.

== Marco conceptual y tendencias

Durante la última década, los servicios en la nube en modalidad SaaS (Software
as a Service) se han popularizado por su facilidad de uso y el bajo coste
inicial. El usuario obtiene un servicio listo para funcionar sin preocuparse por
la infraestructura. A cambio, acepta que los datos se almacenen en servidores de
un tercero y que la continuidad del servicio dependa de un proveedor externo.
Frente a este modelo, el autoalojamiento ha ganado fuerza entre quienes buscan
mayor control sobre sus datos, un coste más estable a medio plazo y la
posibilidad de personalizar su entorno digital. La contrapartida es que exige
conocimientos técnicos y dedicación para mantener la infraestructura.

En este escenario, los contenedores se han consolidado como una herramienta que
facilita la vida a ambos modelos. Permiten empaquetar aplicaciones con todas sus
dependencias, de modo que el despliegue es más sencillo, reproducible y
portátil. Para proyectos pequeños de autoalojamiento se han convertido en el
estándar habitual.

== Contenedores y orquestación

En este trabajo se utilizarán Docker y Docker Compose. Estas herramientas
permiten definir de forma clara los servicios, sus volúmenes y redes, y
garantizan que el despliegue sea el mismo en distintos entornos. La simplicidad
de esta solución encaja con un escenario de servidor único, aunque no ofrece de
forma nativa alta disponibilidad ni escalado automático.

Kubernetes representa el estándar de orquestación en entornos de gran escala,
pero su complejidad lo hace poco adecuado para este proyecto. Existen
alternativas intermedias como k3s o Docker Swarm que podrían explorarse en un
futuro si se necesitara coordinar varios nodos.

== Almacenamiento y colaboración:\ Nextcloud

Nextcloud es un sistema libre de sincronización y compartición de archivos.
Permite mantener carpetas sincronizadas en distintos dispositivos, ofrece
versionado de documentos y evita conflictos mediante bloqueo de archivos. La
plataforma facilita compartir contenidos mediante permisos granulares o enlaces
protegidos, y puede ampliarse con aplicaciones adicionales para calendarios,
contactos y notas. En materia de seguridad, incorpora cifrado de las
comunicaciones y autenticación multifactor.

A diferencia de servicios SaaS como Google Drive o Microsoft 365, Nextcloud
obliga al usuario a asumir la gestión de la infraestructura: desde configurar y
actualizar el servidor hasta encargarse de las copias de seguridad y la
optimización del rendimiento. Esto supone sacrificar la inmediatez, la sencillez
de uso y el soporte técnico centralizado que ofrecen las plataformas
comerciales. A cambio, se obtiene control absoluto sobre el lugar en que se
guardan los datos, las medidas de seguridad aplicadas y el grado de integración
con otras aplicaciones.

== Notas y organización personal: Logseq

Logseq es una herramienta de toma de notas y organización del conocimiento que
guarda la información en archivos de texto plano, normalmente en formato
Markdown. Permite crear jerarquías de ideas y enlazar unas con otras, generando
un grafo que facilita visualizar cómo se relacionan los distintos apuntes. Su
sencillez técnica, unida a la posibilidad de integrar la sincronización con
repositorios Git, ofrece al usuario un control total sobre sus datos y evita
depender de plataformas cerradas.

El sacrificio, en comparación con alternativas SaaS como Notion, es la pérdida
de ciertas funciones avanzadas orientadas a la colaboración en tiempo real, la
falta de plantillas listas para usar y una experiencia de usuario menos pulida,
ya que el mantenimiento y la integración corren a cargo del propio usuario.

== Gestión de contraseñas: Vaultwarden

Vaultwarden es una implementación ligera y autoalojada del servidor de
Bitwarden. Mantiene compatibilidad con los clientes oficiales en móvil,
navegador y escritorio, y cifra todo el contenido de extremo a extremo. Permite
compartir contraseñas de forma controlada entre varios usuarios y soporta
autenticación multifactor. Al consumir pocos recursos, resulta especialmente
adecuado para escenarios de servidor único.

Comparado con gestores comerciales como 1Password o LastPass, Vaultwarden ofrece
control y soberanía, aunque carece de algunas funciones avanzadas orientadas a
empresas, como la integración con directorios corporativos.

== Licencias, comunidad y madurez

Nextcloud está publicado bajo licencia AGPL, con una comunidad activa y un ciclo
regular de lanzamientos. Logseq utiliza también la licencia AGPL y cuenta con
una base de usuarios y desarrolladores creciente que genera guías y extensiones.
Vaultwarden, bajo GPL-3.0, mantiene compatibilidad con los clientes oficiales de
Bitwarden y tiene una comunidad consolidada. Todas estas aplicaciones disponen
de imágenes de contenedor actualizadas y documentación suficiente para
desplegarlas sin grandes dificultades.

== Criterios de evaluación comparativa

La evaluación de las herramientas se basará en varias dimensiones. En
funcionalidad se valorará la cobertura de requisitos como sincronización de
archivos, compartición, toma de notas y gestión de contraseñas. En usabilidad se
medirá la curva de aprendizaje y la experiencia del usuario final. En
rendimiento se observarán tiempos de respuesta y consumo de recursos. En
seguridad se tendrán en cuenta el cifrado de datos, los controles de acceso y el
soporte de autenticación multifactor. En mantenibilidad se analizarán las
actualizaciones y la gestión de copias de seguridad. El coste se calculará como
coste total de propiedad, y se incluirá también la escalabilidad y la
portabilidad hacia otros entornos.

== Comparativa con la propuesta

La propuesta de este TFG combina Nextcloud, Logseq y Vaultwarden desplegados con
Docker Compose y protegidos por un reverse proxy con TLS. Esta configuración se
enfrentará en la evaluación a servicios como Google Drive, Dropbox, Microsoft
365, Notion, 1Password y Bitwarden Cloud.

En cuanto a funcionalidad, la solución autoalojada cubre los requisitos básicos
de almacenamiento, notas y contraseñas, mientras que los servicios SaaS ofrecen
experiencias de usuario más cuidadas y funciones adicionales. En materia de
privacidad, la diferencia es clara: el autoalojamiento mantiene los datos bajo
control del usuario, mientras que en SaaS la confianza se deposita en el
proveedor. El coste total de propiedad presenta otro contraste: el despliegue
propio requiere hardware y tiempo de administración, pero evita pagos
recurrentes. Las plataformas comerciales, en cambio, exigen suscripciones que
crecen según el número de usuarios.

La usabilidad se medirá con pruebas prácticas y el rendimiento se evaluará a
través de operaciones de subida, descarga y consulta de datos. En conjunto, el
autoalojamiento ofrece soberanía y flexibilidad, mientras que los servicios SaaS
destacan por la inmediatez y el soporte gestionado.
