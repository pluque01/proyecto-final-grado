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
