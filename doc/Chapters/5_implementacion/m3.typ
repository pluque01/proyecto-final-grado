== [M3] Implementación de servicio de notas y conocimiento personal<cap:5_m3>

Este milestone aborda la implementación de un servicio autoalojado de toma de
notas y gestión de conocimiento personal, inspirado en herramientas como Notion,
pero manteniendo la filosofía self-hosted definida en los hitos anteriores. Su
propósito es dar respuesta a las historias de usuario HU03 y HU04, permitiendo
que el estudiante organice ideas, apuntes y materiales académicos sin depender
de servicios externos, y acceda a ellos de forma sincronizada desde distintos
dispositivos.

=== Objetivo del PMV

El objetivo de este hito es disponer un servicio autoalojado que permita:

- Crear y organizar notas con estructura jerárquica, etiquetas y enlaces entre
  páginas.

- Editar y consultar desde la web o aplicaciones móviles/de escritorio, con
  sincronización de contenido.

- Mantener control total sobre los datos, integrándose con la infraestructura
  base de despliegue (proxy inverso y redes internas) descrita en la @cap:5_m2.

=== Alternativas de implementación

==== Criterios de elección

Para seleccionar la herramienta más adecuada se definieron los siguientes
criterios técnicos y funcionales:
- Licencia libre (FOSS): el software debe estar publicado bajo una licencia
  libre o de código abierto que permita su uso, modificación y redistribución
  sin restricciones comerciales.
- Sincronización multidispositivo: disponibilidad de clientes estables en web,
  escritorio y móvil compartiendo notas.
- Recursos: consumo moderado y mantenimiento sencillo en hardware limitado.
- Disponibilidad de imagen Docker: existencia de imagen oficial o mantenida que
  permita el despliegue directo con Podman.

==== Evaluación de alternativas

Se analizaron varias soluciones open source orientadas a la gestión de notas. La
comparación se realizó conforme a los criterios anteriores:

- *Nextcloud Notes* #footnote("https://apps.nextcloud.com/apps/notes") +
  *Collectives* #footnote("https://apps.nextcloud.com/apps/collectives"):

  Alta integración en entornos con Nextcloud ya desplegado, aunque esto hace que
  sea necesario tenerlo instalado y, por tanto, es una limitación para ciertos
  usuarios que no requieren todas sus características. Ofrece edición en
  Markdown y funciones de enciclopedia básicas. La instalación se realiza
  mediante el ecosistema de aplicaciones de Nextcloud.

  Licencia: AGPL-3.0.

- *Joplin* #footnote("https://joplinapp.org"):

  Proporciona notas en Markdown con etiquetas, adjuntos y enlaces internos,
  además de cifrado de extremo a extremo opcional. Dispone de clientes maduros
  en escritorio y móvil. Tiene un consumo de recursos moderado, ya que solo
  necesita una base de datos. Existen imágenes oficiales en Docker Hub, lo que
  facilita su despliegue reproducible con Podman.

  Licencia: AGPL-3.0.

- *Trilium Notes* #footnote("https://github.com/zadam/trilium"):

  Servicio autónomo con gran capacidad jerárquica y relaciones entre notas.
  Ofrece acceso web y clientes de escritorio, con uso móvil principalmente vía
  navegador. Consumo moderado y despliegue sencillo mediante contenedores
  oficiales, sin embargo, sus imágenes requieren privilegios de administrador
  para funcionar correctamente @trilium_docker_install.

  Licencia: AGPL-3.0.

==== Justificación de la elección

Para el PMV se seleccionó Joplin como solución principal. Cumple los cuatro
criterios definidos: es software libre bajo licencia AGPL-3.0, ofrece clientes
maduros en escritorio y móvil que permiten sincronización completa de notas,
mantiene un consumo moderado de recursos y dispone de imágenes oficiales en
Docker Hub, compatibles con despliegues mediante Podman. Además, su arquitectura
sencilla, basada únicamente en un contenedor y una base de datos, facilita la
integración con el proxy inverso y las redes internas descritas en [@cap:5_m2].

Trilium Notes constituye una alternativa sólida en cuanto a estructura
jerárquica y flexibilidad, pero además de no tener clientes móviles nativos,
requiere privilegios elevados en sus imágenes de contenedor, lo que lo hace
menos adecuado para el entorno sin privilegios de Podman. Nextcloud Notes, por
su parte, destaca en integración cuando ya existe un entorno Nextcloud
desplegado, pero su dependencia de dicha plataforma contraviene puede resultar
un inconveniente según el tipo de usuario, ya que añade una gestión adicional.

Por estas razones, Joplin ofrece el mejor equilibrio entre funcionalidad,
facilidad de despliegue y sostenibilidad dentro de la infraestructura del
proyecto.
