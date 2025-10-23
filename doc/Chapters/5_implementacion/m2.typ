== [M2] Implementación de servicios de almacenamiento y colaboración<cap:5_m2>

Este milestone tiene como objetivo desarrollar el primer servicio funcional del
entorno self-hosted, orientado al almacenamiento y la compartición de archivos
entre usuarios. Su finalidad es proporcionar una solución que permita acceder a
los documentos personales desde cualquier dispositivo, manteniendo el control
sobre los datos y la independencia respecto a servicios externos. A partir de la
infraestructura establecida en el M1 [@cap:5_m1], se implementará un entorno
reproducible que sirva como base para la futura incorporación de más servicios
colaborativos.

=== Objetivo del PMV

Implementar un servicio autoalojado de almacenamiento y colaboración que permita
guardar, sincronizar y compartir archivos de forma segura entre distintos
usuarios, garantizando la accesibilidad, la persistencia de los datos y la
reproducibilidad del despliegue.

=== Alternativas de implementación

Para la puesta en marcha del servicio de almacenamiento y colaboración se han
considerado distintas soluciones self-hosted que permiten sincronizar y
compartir archivos entre usuarios. Estas alternativas se han evaluado en función
de su funcionalidad, grado de madurez y adecuación a los requisitos definidos en
las historias de usuario.

==== Criterios de elección

Los principales criterios definidos para la selección de la herramienta fueron
los siguientes:

- Reproducibilidad: facilidad para documentar y versionar el despliegue,
  permitiendo su reconstrucción en distintos entornos.

- Rendimiento y eficiencia: consumo moderado de recursos, especialmente
  relevante en hardware limitado como la Raspberry Pi.

- Soporte comunitario: disponibilidad de documentación actualizada, foros
  activos y frecuencia de mantenimiento del proyecto.

- Seguridad y control de acceso: capacidad para gestionar usuarios, permisos,
  grupos y cifrado de datos.

- Extensibilidad: posibilidad de ampliar el sistema mediante módulos o
  integraciones adicionales (calendarios, notas, ofimática colaborativa, etc.).

==== Evaluación de alternativas

- *Seafile* #footnote("https://www.seafile.com"): plataforma de sincronización y
  compartición de archivos centrada en la eficiencia y el rendimiento. Su
  arquitectura divide el almacenamiento en bibliotecas independientes, lo que
  facilita la sincronización selectiva y la gestión granular de permisos. Sin
  embargo, parte de sus funciones avanzadas como la edición colaborativa en
  línea o la integración con directorios LDAP requieren la versión profesional
  de pago. Su comunidad es estable, aunque más reducida que la de otras
  soluciones.

- *ownCloud* #footnote("https://owncloud.com"): una de las primeras plataformas
  open source de almacenamiento personal en la nube. Proporciona funcionalidades
  sólidas de sincronización, gestión de usuarios y compartición, además de
  soporte para extensiones y almacenamiento externo. No obstante, su desarrollo
  ha perdido impulso tras la aparición de Nextcloud, derivado del mismo
  proyecto, lo que ha reducido la frecuencia de actualizaciones y la actividad
  comunitaria.

- *Syncthing* #footnote("https://syncthing.net"): herramienta ligera y
  descentralizada enfocada en la sincronización segura entre dispositivos sin
  depender de un servidor central. Utiliza comunicación cifrada extremo a
  extremo y no almacena metadatos de los archivos sincronizados. Su principal
  limitación es la ausencia de una interfaz web unificada o sistema
  multiusuario, lo que la hace inadecuada para un entorno colaborativo.

- *Nextcloud* #footnote("https://nextcloud.com"): solución integral de
  almacenamiento y colaboración que permite sincronizar archivos, compartir
  carpetas, gestionar usuarios y ampliar funcionalidades mediante aplicaciones
  adicionales. Su arquitectura modular incluye extensiones para calendario,
  notas, colaboración en línea o videollamadas. Dispone de imágenes oficiales de
  contenedor, documentación extensa y una comunidad activa, lo que garantiza
  continuidad y soporte a largo plazo.

==== Justificación de la elección

Tras el análisis comparativo de las distintas alternativas, se seleccionó
*Nextcloud* como la solución más adecuada para el desarrollo de este milestone.
Su elección se debe a que proporciona una cobertura completa de las Historias de
Usuario HU01 y HU02, al permitir que los usuarios almacenen sus documentos en un
servidor propio y al facilitar la compartición de carpetas con control de
permisos entre varios usuarios. Estas dos funciones constituyen el núcleo
funcional del producto mínimo viable definido para este hito.

A diferencia de otras alternativas, Nextcloud integra de forma nativa tanto la
sincronización de archivos como la colaboración entre usuarios, ofreciendo una
interfaz web moderna, clientes para varias plataformas y aplicaciones móviles
oficiales.

Otro aspecto decisivo ha sido la madurez del proyecto y la amplitud de su
comunidad, que garantizan una documentación exhaustiva, actualizaciones
regulares y soporte continuado. Esto reduce la dependencia de soluciones menos
activas, como ownCloud o Seafile, y asegura la sostenibilidad del sistema a
largo plazo.

Asimismo, Nextcloud dispone de imágenes oficiales de contenedor ampliamente
documentadas, lo que simplifica su despliegue y asegura la reproducibilidad del
entorno. Gracias a esta característica, el servicio puede ser replicado
fácilmente en distintos sistemas, manteniendo la coherencia de la configuración
y facilitando la integración con futuras herramientas de monitorización o
automatización.

Por último, su rendimiento estable y sus requisitos de hardware moderados lo
convierten en una opción especialmente adecuada para el entorno self-hosted del
proyecto, basado en una Raspberry Pi. En conjunto, estos factores hacen de
Nextcloud la solución más equilibrada para satisfacer las necesidades
funcionales del milestone, combinando usabilidad, eficiencia y reproducibilidad
dentro de la infraestructura establecida en el M1.

=== Opciones de despliegue

Antes de proceder a la instalación de Nextcloud, se evaluaron las dos
principales estrategias de despliegue disponibles: la versión todo en uno
("AIO") y el despliegue manual a partir de la imagen base oficial.

La opción Nextcloud AIO #footnote(
  "https://apps.nextcloud.com/apps/nextcloud_all_in_one",
) ofrece un proceso de instalación muy simplificado, ya que agrupa en un único
entorno todos los componentes necesarios: base de datos, servidor web, proxy
inverso y sistema de actualizaciones. Sin embargo, esta comodidad implica una
mayor demanda de recursos y una menor flexibilidad, al no permitir un control
detallado de la configuración interna. Además, su estructura cerrada dificulta
la integración con el modelo declarativo de NixOS.

Por el contrario, el despliegue manual requiere definir individualmente los
contenedores y sus dependencias, pero proporciona un control total sobre los
volúmenes, versiones y parámetros del sistema. Este enfoque permite optimizar el
uso de los recursos disponibles en la Raspberry Pi y se adapta mejor a la
filosofía modular y reproducible de NixOS.

Por estas razones, se optó por la instalación manual de Nextcloud, configurando
de forma independiente sus servicios principales y gestionando los volúmenes de
datos de manera persistente.

=== Despliegue de Nextcloud

El despliegue del servicio se estructuró en dos contenedores principales: uno
para la aplicación Nextcloud, encargada de servir la interfaz web y gestionar
las operaciones del usuario, y otro para la base de datos, donde se almacena la
información interna del sistema, como usuarios, permisos y metadatos.

Para garantizar un aislamiento adecuado de los recursos, se hace uso de redes
internas en el entorno de contenedores. Este tipo de redes permite que los
servicios que no requieren exposición pública se comuniquen únicamente entre sí,
sin ser accesibles desde el exterior del sistema @docker_network_internal.
Gracias a esta arquitectura, y al hecho de que un contenedor puede pertenecer
simultáneamente a varias redes, es posible situar la base de datos en una red
interna mientras que el contenedor de Nextcloud se conecta tanto a dicha red
como a una red externa. De este modo, únicamente Nextcloud dispone de acceso
directo a la base de datos y al exterior, preservando la seguridad y el
aislamiento de los componentes.

No obstante, a medida que el sistema se amplía y comienzan a desplegarse
múltiples servicios web, surge la necesidad de contar con un punto de entrada
único que gestione todas las conexiones externas. En lugar de exponer cada
servicio individualmente, se recurre a un proxy inverso, encargado de recibir
las solicitudes desde el exterior y redirigirlas al contenedor correspondiente
según el dominio o la ruta solicitada @nginx_reverse_proxy.

Con la configuración descrita, la @figure:5_m2_nextcloud_db_network ilustra la
estructura de redes resultante en el despliegue de Nextcloud. En ella puede
observarse cómo el contenedor de Nextcloud actúa como punto intermedio entre la
red externa, que conecta con el proxy inverso, y la red interna, donde reside la
base de datos. Esta disposición garantiza el aislamiento de los servicios y un
acceso controlado desde el exterior.

#figure(
  caption: [Esquema de redes para el despliegue de Nextcloud],
  image(
    "../../Figures/Chapter5/m2/m2-nextcloud-db-network.drawio.svg",
    width: 90%,
  ),
) <figure:5_m2_nextcloud_db_network>

==== Elección de la base de datos

Nextcloud requiere una base de datos relacional para almacenar información
estructurada, como las cuentas de usuario, los permisos de acceso, la
configuración de la aplicación y los metadatos de los archivos. Entre las
opciones compatibles se encuentran SQLite, MySQL/MariaDB y PostgreSQL,
ampliamente reconocidas y consolidadas @stackoverflow_survey_2025_db.

*SQLite* #footnote("https://www.sqlite.org") destaca por su sencillez de
despliegue, al no requerir un servidor independiente: todos los datos se
almacenan en un único archivo @sqlite_about. Esta característica la convierte en
una opción adecuada para entornos de pruebas o instalaciones de un solo usuario,
aunque presenta limitaciones de rendimiento y concurrencia en escenarios con
múltiples clientes.

*MySQL* #footnote("https://www.mysql.com"), por su parte, ofrece un rendimiento
sólido y una amplia documentación, pero su desarrollo está actualmente más
orientado al ecosistema empresarial de Oracle. Como alternativa, *MariaDB*
#footnote("https://mariadb.org") mantiene plena compatibilidad con MySQL y
aporta mejoras notables en términos de rendimiento, licencia abierta y soporte
comunitario @aws_mariadb_vs_mysql. Estas ventajas la convierten en una opción
más adecuada para entornos autoalojados, donde se valora la transparencia y la
optimización de recursos.

Finalmente, *PostgreSQL* #footnote("https://www.postgresql.org") representa una
base de datos avanzada con capacidades extendidas para consultas complejas,
índices avanzados y transacciones concurrentes @postgresql_features. Sin
embargo, su mayor complejidad de configuración y consumo de recursos la hacen
menos apropiada para entornos con hardware limitado, como una Raspberry Pi.

En conjunto, MariaDB ofrece un equilibrio óptimo entre facilidad de
configuración, rendimiento y estabilidad, ajustándose mejor a las necesidades
del proyecto. Su compatibilidad con MySQL, junto con un ecosistema maduro y
abierto, la convierten en la base de datos más adecuada para el despliegue de
Nextcloud en este entorno.

