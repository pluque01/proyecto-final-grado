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

==== Elección de un proxy inverso

Un proxy inverso actúa como punto de entrada único para las peticiones HTTP y
HTTPS, ofreciendo ventajas significativas en términos de seguridad,
mantenimiento y flexibilidad. Entre sus principales funciones destacan la
terminación de conexiones TLS y la gestión de certificados de seguridad; el
enrutamiento del tráfico hacia distintos servicios internos; la posibilidad de
aplicar reglas de autenticación, redirección o balanceo de carga; y la reducción
de la superficie de exposición al evitar que los servicios sean accesibles
directamente desde el exterior.

Dado que los servicios desplegados deben estar disponibles de forma segura y sin
intervención manual en la gestión de certificados, se establece como requisito
funcional que el proxy inverso admita la obtención y renovación automática de
certificados TLS sin herramientas externas.

Con este requisito se valoran dos alternativas:

- *Caddy* #footnote("https://caddyserver.com"), que incorpora de forma nativa la
  obtención y renovación automática de certificados TLS, simplificando
  considerablemente la configuración @caddy_automatic_https.

- *Traefik* #footnote("https://traefik.io"), diseñado específicamente para
  entornos de contenedores, capaz de detectar automáticamente los servicios en
  ejecución mediante etiquetas (labels) e integrar nativamente la gestión y
  renovación de certificados a través de ACME @traefik_acme_tls.

Considerando los requisitos del entorno basado en contenedores gestionados con
Podman y hardware de recursos limitados, Traefik se selecciona como la solución
más adecuada. Su bajo consumo de recursos, su integración dinámica con servicios
en contenedores y su soporte completo para la gestión automática de certificados
permiten mantener una infraestructura segura y escalable.

=== Acceso desde el exterior

Uno de los requisitos fundamentales para el servicio de almacenamiento y
colaboración implementado es la posibilidad de acceder a los datos desde
distintos dispositivos y ubicaciones, sin depender exclusivamente de la red
local. Esto responde directamente a la necesidad del usuario de consultar,
modificar o compartir información académica incluso cuando no se encuentra en su
domicilio.

En este contexto, es necesario analizar las distintas estrategias que permiten
acceder de forma remota a servicios autoalojados manteniendo la seguridad y el
control sobre la infraestructura.

==== Alternativas de acceso

Existen principalmente dos enfoques para permitir el acceso remoto a un servicio
como Nextcloud:

- Exposición directa a Internet público:

  En este modelo, el servicio se publica en la red mediante un dominio y un
  proxy inverso, utilizando certificados TLS para garantizar la conexión
  cifrada. Esta opción permite un acceso universal desde cualquier dispositivo
  conectado a Internet, pero requiere una configuración rigurosa de seguridad:
  gestión de certificados, cortafuegos, actualizaciones constantes y
  monitorización frente a posibles ataques o escaneos automáticos.

  Si bien ofrece mayor disponibilidad, también aumenta la superficie de
  exposición, lo que implica un riesgo añadido para entornos personales sin
  medidas de defensa avanzadas.

- Acceso mediante una red privada virtual (VPN):

  Otra opción es mantener el servicio accesible únicamente desde la red local y
  utilizar una capa privada de conexión remota. Entre las soluciones disponibles
  se encuentran las VPN tradicionales, como WireGuard #footnote(
    "https://www.wireguard.com/",
  ) u OpenVPN #footnote("https://openvpn.net/"), que permiten crear redes
  privadas cifradas entre dispositivos sin necesidad de configuraciones
  complejas de red o reenvío de puertos.

  Esta aproximación ofrece una seguridad significativamente superior, ya que los
  servicios no quedan expuestos directamente a Internet, y solo los dispositivos
  autenticados dentro de la red privada pueden acceder a ellos.

==== Solución adoptada

Para este proyecto se ha optado por utilizar *Tailscale* #footnote(
  "https://tailscale.com",
) como mecanismo de acceso remoto seguro. Tailscale es un servicio que crea una
red privada virtual basada en la tecnología de WireGuard, permitiendo conectar
varios dispositivos entre sí de manera cifrada, como si se encontraran en la
misma red local @tailscale_wireguard. Cada dispositivo conectado a Tailscale se
autentica mediante una identidad única (por ejemplo, una cuenta de Google,
GitHub o Microsoft) y obtiene una dirección IP privada dentro de la red virtual.

Entre las ventajas que justifican esta elección destacan:

- Simplicidad de despliegue: no requiere abrir puertos en el router.

- Autenticación mediante identidad: el acceso se gestiona por usuario y
  dispositivo, facilitando el control de quién puede entrar en la red privada.

- Compatibilidad multiplataforma: disponible para Linux, Windows, macOS, Android
  e iOS, lo que permite acceder al servicio desde cualquier dispositivo del
  usuario.

- Mantenimiento reducido: evita la exposición directa del servicio y, por tanto,
  la necesidad de aplicar medidas adicionales de protección frente a ataques
  externos.

Para instalar Tailscale en NixOS, se puede activar con facilidad el módulo
oficial disponible en la configuración del sistema. Una vez activado, Tailscale
se encargará de gestionar automáticamente la conexión y autenticación de los
dispositivos en la red privada.

#figure(
  image(
    "../../Figures/Chapter5/m2/tailscale-dashboard.png",
    width: 100%,
  ),
  caption: [Panel de administración de Tailscale, mostrando los dispositivos
    conectados a la red privada virtual.],
) <figure:5_m2_tailscale_dashboard>


Una vez desplegado Tailscale, es posible acceder de forma remota a la Raspberry
Pi mediante su nombre interno dentro de la red privada, en este caso `rpi4`.
Esto permite conectarse directamente al servicio de Nextcloud sin exponerlo
públicamente.

Sin embargo, esta configuración presenta una limitación al integrarse con el
proxy inverso Traefik. En este proyecto, Traefik se ha configurado con
subdominios de la forma `<servicio>.<host>` y no con subdirectorios
`<host>/<servicio>`, porque Nextcloud desaconseja ejecutarse en un subdirectorio
para evitar problemas de rutas internas, archivos estáticos y compatibilidad con
aplicaciones @nextcloud_subdir_limitations. Por tanto, emplear subdominios
simplifica la configuración y maximiza la compatibilidad con Nextcloud en
producción.

==== Configuración del dominio local

Para resolver la limitación relacionada con el uso de subdominios, se ha
decidido configurar un dominio que apunte directamente a la dirección IP privada
de la Raspberry Pi dentro del entorno local. Existen numerosos proveedores que
ofrecen este servicio, pero en este proyecto, con el objetivo de minimizar
costes y simplificar la configuración, se ha optado por utilizar el servicio
gratuito *DuckDNS* #footnote("https://www.duckdns.org/").

DuckDNS es un sistema de DNS dinámico @aws_dynamic_dns que permite registrar
subdominios bajo el dominio principal `duckdns.org`. Aunque este proyecto no
requiere la funcionalidad de actualización dinámica de direcciones IP, el
servicio resulta muy útil para obtener un subdominio gratuito y gestionable
mediante una interfaz web sencilla.

En la @figure:5_m2_duckdns_domain se muestra el panel de administración de
DuckDNS, donde puede verse el subdominio asignado para este proyecto:
`nixospi.duckdns.org`.

#figure(
  image("../../Figures/Chapter5/m2/duckdns-domain.png", width: 100%),
  caption: [Panel de administración de DuckDNS, mostrando el subdominio
    asignado.],
)<figure:5_m2_duckdns_domain>

==== Obtención de un certificado TLS

Con la configuración actual, el servicio de Nextcloud ya es accesible a través
de la dirección `nextcloud.nixospi.duckdns.org` desde cualquier dispositivo
conectado a la red local o a la red de Tailscale. Sin embargo, para garantizar
la seguridad de las comunicaciones y proteger los datos transmitidos, podemos
utilizar Traefik para obtener un certificado TLS válido para este subdominio de
manera automática.

Para esto, Traefik se ha configurado con el proveedor de certificados Let's
Encrypt #footnote("https://letsencrypt.org/"), utilizando el mecanismo
`dnsChallenge`. Este método resulta especialmente útil en entornos donde los
dominios apuntan a direcciones IP privadas como es el caso del subdominio
configurado, ya que la validación no depende del acceso HTTP directo al
servidor, sino de la creación temporal de un registro `TXT` en el DNS del
dominio @letsencrypt_dns01.

Gracias a esta configuración, Traefik genera y renueva automáticamente un
certificado SSL wildcard para `*.nixospi.duckdns.org`, lo que permite proteger
con cifrado TLS todos los subdominios asociados a los distintos servicios
desplegados, incluyendo `nextcloud.nixospi.duckdns.org`.

#figure(
  image("../../Figures/Chapter5/m2/tls-certificate.png", width: 70%),
  caption: [Certificado TLS emitido por Let's Encrypt para
    `nixospi.duckdns.org`.],
)

El esquema de la @figure:5_m2_tailscale_duckdns_traefik representa el flujo
completo de conexión entre los distintos componentes. El subdominio
`nextcloud.nixospi.duckdns.org`, gestionado por DuckDNS, resuelve hacia la
dirección IP privada de la Raspberry Pi. Cuando un usuario accede al servicio,
la petición se redirige hacia el host `rpi4`, donde Traefik actúa como proxy
inverso dentro de la red externa, gestionando la terminación TLS y el
enrutamiento de tráfico hacia los contenedores de Podman. En la red interna se
encuentran los servicios de Nextcloud y su base de datos, comunicándose
únicamente a través de la red privada definida para los contenedores.

Todo el entorno está encapsulado dentro de la red privada virtual establecida
por Tailscale, lo que garantiza un acceso remoto cifrado y seguro sin necesidad
de exponer puertos al exterior.


#figure(
  image(
    "../../Figures/Chapter5/m2/m2-dns-tailscale.drawio.svg",
    width: 100%,
  ),
  caption: [Esquema de acceso remoto a Nextcloud mediante Tailscale, DuckDNS y
    Traefik.],
)<figure:5_m2_tailscale_duckdns_traefik>


=== Validación del milestone

Una vez desplegado el servicio Nextcloud es necesario comprobar que la solución
implementada satisface los requisitos definidos en las historias de usuario del
proyecto. Esta sección muestra de forma práctica cómo el sistema responde a las
necesidades planteadas, a través de ejemplos de uso reales capturados durante
las pruebas de funcionamiento.

==== Almacenamiento y sincronización de archivos (HU01)

El despliegue de Nextcloud permite al usuario disponer de un espacio de
almacenamiento propio accesible desde cualquier dispositivo. El acceso se
realiza mediante la interfaz web o las aplicaciones oficiales de escritorio y
móvil, que sincronizan automáticamente los archivos con el servidor local. De
este modo, el usuario puede subir, organizar y descargar documentos sin depender
de servicios externos como Google Drive o Dropbox, cumpliendo así el propósito
de esta historia.

Los datos se almacenan en un volumen persistente definido en la configuración de
NixOS, garantizando su conservación tras actualizaciones o reinstalaciones del
sistema. Esta separación entre aplicación y datos permite mantener la
información del usuario incluso si el contenedor o el servicio deben ser
reinstalados.

#figure(
  image("../../Figures/Chapter5/m2/nextcloud-folder-web.png", width: 100%),
  caption: [Carpeta de una asignatura con varios documentos, visible desde la
    interfaz web.],
)

#figure(
  image("../../Figures/Chapter5/m2/nextcloud-folder-iphone.png", height: 100%),
  caption: [La misma carpeta abierta desde la aplicación móvil de Nextcloud en
    iPhone.],
)


==== Compartir contenido con varios usuarios (HU02)

El sistema desplegado permite compartir carpetas y archivos con otros usuarios
registrados en la instancia de Nextcloud. Desde la interfaz web, el usuario
puede seleccionar cualquier carpeta y habilitar su compartición con compañeros
concretos, asignando distintos niveles de permisos (solo lectura, edición o
personalizados). Esta funcionalidad facilita el trabajo en grupo, ya que varios
usuarios pueden acceder simultáneamente a los mismos documentos y realizar
modificaciones colaborativas en tiempo real.

Durante las pruebas, se creó una carpeta compartida entre tres cuentas de
usuario diferentes, utilizada para editar documentos de manera conjunta. La
interfaz refleja en todo momento la presencia de otros colaboradores y actualiza
automáticamente los cambios realizados por cada uno de ellos, garantizando la
coherencia de los archivos compartidos.

#figure(
  image("../../Figures/Chapter5/m2/nextcloud-share-menu.png", width: 100%),
  caption: [Menú de compartición de una carpeta en Nextcloud, con opciones para
    añadir usuarios y definir permisos de acceso.],
)

#figure(
  image("../../Figures/Chapter5/m2/nextcloud-collaboration.png", width: 100%),
  caption: [Edición simultánea de un documento compartido entre tres usuarios en
    la interfaz web de Nextcloud.],
)

#figure(
  image(
    "../../Figures/Chapter5/m2/nextcloud-collaboration-iphone.png",
    height: 100%,
  ),
  caption: [Usuario "Laura" editando el mismo documento compartido desde la
    aplicación móvil de Nextcloud en iPhone.],
)


=== Cierre del milestone

Las pruebas realizadas demuestran que el despliegue de Nextcloud sobre NixOS
cumple satisfactoriamente con las dos primeras historias de usuario del
proyecto. El sistema proporciona un entorno self-hosted funcional que permite
tanto el almacenamiento personal de documentos como la colaboración entre varios
usuarios mediante la compartición de carpetas y la edición simultánea de
archivos.

Gracias al enfoque declarativo de NixOS y la contenedorización, el despliegue
del servicio es reproducible y sencillo de mantener, lo que facilita su
actualización o reinstalación sin pérdida de datos. Con este milestone se
valida, por tanto, la viabilidad del modelo de infraestructura propuesto y se
establecen las bases para ampliar los servicios en los siguientes hitos del
proyecto.
