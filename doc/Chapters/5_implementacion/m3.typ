== [M3] Implementación de servicio de notas y conocimiento personal<cap:5_m3>

Este milestone tiene como objetivo ampliar las funcionalidades del servicio
autoalojado desplegado en el milestone anterior, incorporando capacidades de
toma de notas y gestión de conocimiento personal dentro del propio entorno de
Nextcloud. Se pretende así evolucionar el PMV previo hacia una herramienta más
completa y útil para la organización de información académica y colaborativa,
manteniendo la filosofía self-hosted y la integración con la infraestructura
existente.

=== Objetivo del PMV

El objetivo de este milestone es extender Nextcloud para ofrecer funciones de
toma de notas individuales y en grupo, permitiendo:

- Crear y organizar notas con algún lenguaje de marcado sencillo.

- Mantener una estructura jerárquica o enciclopédica mediante páginas y
  colecciones.

- Compartir y editar notas entre varios usuarios.

- Acceder desde la interfaz web y aplicaciones móviles o de escritorio, con
  sincronización automática de contenido.

De esta forma, el PMV evoluciona de un sistema de almacenamiento y colaboración
básico a una plataforma de conocimiento personal y compartido, sin requerir
nuevas aplicaciones externas ni modificar la arquitectura principal de
despliegue descrita en la @cap:5_m2.

=== Alternativas de implementación

==== Criterios de elección

Para seleccionar las aplicaciones a integrar se establecieron los siguientes
criterios:

- Compatibilidad completa con Nextcloud 29 o superior.
- Licencia libre y código abierto.
- Integración con la gestión de usuarios, permisos y almacenamiento ya
  existente.

==== Evaluación de alternativas

Se analizaron distintas extensiones disponibles en el catálogo oficial de
Nextcloud orientadas a la gestión de notas y conocimiento:

- *Notes* #footnote("https://apps.nextcloud.com/apps/notes"): aplicación
  sencilla de toma de notas en formato Markdown. Permite creación, edición y
  sincronización de notas personales, accesibles desde el navegador o mediante
  aplicaciones móviles nativas. Se integra con el sistema de archivos y utiliza
  almacenamiento local dentro de la cuenta del usuario.

  Licencia: AGPL-3.0.

- *Collectives* #footnote("https://apps.nextcloud.com/apps/collectives"):
  extensión que permite crear colecciones de documentos compartidos entre
  grupos. Cada colectiva funciona como una pequeña wiki colaborativa, con
  jerarquía de páginas, historial de cambios y permisos gestionados desde el
  propio Nextcloud. Utiliza el mismo formato Markdown y puede complementarse con
  Nextcloud Text para edición colaborativa en tiempo real.

  Licencia: AGPL-3.0.

==== Justificación de la elección

Para este PMV se decidió integrar ambas aplicaciones, ya que ofrecen una
evolución natural del entorno previo: amplían el uso de Nextcloud sin modificar
su arquitectura ni requerir nuevos servicios externos.

La aplicación de Notes aporta un espacio personal de escritura y organización
rápida de ideas, mientras que Collectives introduce una capa colaborativa que
convierte el entorno en una pequeña base de conocimiento compartida.

Esta elección permite mantener la coherencia tecnológica del proyecto y ofrecer
valor adicional al usuario final, integrando de forma directa las funciones de
toma de notas y conocimiento dentro del ecosistema de colaboración existente.

=== Despliegue e integración<cap:5_m3_deployment>

Al tratarse de una ampliación funcional sobre la infraestructura ya desplegada
en la @cap:5_m2, no ha sido necesario modificar la configuración de red, proxy
ni contenedores. El despliegue de las extensiones se realizó directamente sobre
el servicio de Nextcloud existente, utilizando su propio sistema de gestión de
aplicaciones.

Desde la interfaz de administración, se procedió a instalar las aplicaciones
Notes y Collectives, disponibles en el catálogo oficial. Ambas aplicaciones se
activan automáticamente tras su instalación, sin requerir reinicio del servicio
ni cambios en el contenedor.

Para verificar la correcta integración con el proxy inverso y la red interna, se
accedió a los módulos desde diferentes dispositivos conectados tanto por la red
local como mediante Tailscale, confirmando que las rutas internas y el dominio
principal continuaban funcionando sin conflictos.

=== Validación del milestone

La validación se ha realizado contrastando las funcionalidades del sistema con
los objetivos definidos en las historias de usuario correspondientes.

==== Organización de notas e ideas (HU03)

La aplicación Notes permite al usuario crear, editar y organizar notas
personales directamente desde el entorno de Nextcloud, sin necesidad de
herramientas externas. Desde el panel principal, se accede a la sección Notas a
través del menú superior, donde se dispone de un editor en línea compatible con
formato Markdown. Las notas se guardan automáticamente en el espacio personal
del usuario y pueden agruparse mediante categorías o etiquetas, lo que facilita
su organización temática.

La interfaz web se muestra en la @figure:chapter5_notes-web. En el panel
izquierdo se visualizan las categorías y notas disponibles, mientras que el
panel derecho presenta el contenido editable de la nota seleccionada. La figura
ilustra también la posibilidad de edición simultánea entre usuarios, en este
caso, el usuario Miguel Rosado; lo que demuestra la integración con el sistema
de colaboración en tiempo real de Nextcloud.

#figure(
  image("../../Figures/Chapter5/m3/notes-web.png", width: 100%),
  caption: [Interfaz web de Nextcloud Notes mostrando la lista de notas y el
    editor con colaboración activa.],
)<figure:chapter5_notes-web>

Además, la disponibilidad de aplicaciones móviles oficiales para Android e iOS
permite acceder a las notas desde cualquier dispositivo sincronizado con la
cuenta del usuario, cumpliendo el requisito de accesibilidad multiplataforma.
Estas aplicaciones, si bien no soportan edición colaborativa en tiempo real,
ofrecen las funciones esenciales de lectura, creación y modificación de notas,
garantizando continuidad en distintos entornos de uso.

#figure(
  image("../../Figures/Chapter5/m3/notes-mobile.png", height: 70%),
  caption: [Interfaz móvil de Nextcloud Notes mostrando una nota abierta.],
)<figure:chapter5_notes-mobile>

En conjunto, la integración de Nextcloud Notes proporciona al usuario un espacio
centralizado para la gestión de ideas y apuntes, con sincronización entre
dispositivos y sin depender de plataformas externas. La herramienta cumple
plenamente los objetivos definidos en la historia de usuario HU03, ofreciendo
una experiencia similar a Notion dentro del ecosistema Nextcloud, y validando
así que el PMV resuelve la necesidad planteada de organización académica
autosuficiente.

==== Estructuración de notas en un grupo de trabajo (HU04)

La aplicación Collectives amplía las capacidades colaborativas de Nextcloud,
permitiendo que varios usuarios organicen y editen conocimiento de forma
estructurada dentro de un mismo espacio compartido. Desde el panel principal,
cada grupo puede crear un "cuaderno", es decir, una colección de documentos
organizados jerárquicamente en páginas y subpáginas. Estas páginas se editan en
formato Markdown mediante el editor en línea integrado, manteniendo un historial
de versiones y control de permisos gestionado desde la propia interfaz.

En el entorno de pruebas se creó un cuaderno denominado "Proyecto de Gestión de
Empresas", compartido con otros usuarios de la instancia. Cada participante pudo
crear y modificar páginas dentro de la jerarquía definida, observándose que las
modificaciones se sincronizan en tiempo real y quedan registradas en el
historial de cambios. Este comportamiento garantiza la trazabilidad de las
ediciones y la coherencia del contenido entre distintos usuarios.

La interfaz web se muestra en la @figure:chapter5_collectives-web, donde se
aprecian las páginas del cuaderno y el editor activo. La disposición de la barra
lateral izquierda facilita la navegación jerárquica entre secciones, y el panel
central permite la edición simultánea del contenido compartido.

#figure(
  image("../../Figures/Chapter5/m3/collectives-web.png", width: 100%),
  caption: [Interfaz web de Nextcloud Collectives mostrando un cuaderno con
    páginas y el editor de contenido.],
)<figure:chapter5_collectives-web>

Actualmente, Collectives no dispone de aplicaciones móviles nativas para Android
o iOS, aunque su interfaz web es completamente funcional en navegadores móviles
modernos. Esto permite acceder y consultar la información compartida desde
distintos dispositivos, si bien las tareas de edición colaborativa se realizan
con mayor comodidad desde la versión web de escritorio.

Durante las pruebas se verificó que la integración de Collectives con los
mecanismos de autenticación, almacenamiento y red de Nextcloud funciona de forma
transparente, sin conflictos ni aumentos significativos en el consumo de
recursos del contenedor.

En conjunto, Nextcloud Collectives proporciona un entorno colaborativo que
permite estructurar conocimiento compartido de manera jerárquica y segura,
ofreciendo una funcionalidad equivalente a una enciclopedia interna dentro del
sistema. Esto satisface los requisitos planteados en la historia de usuario
HU04, validando que el PMV permite la creación, edición y organización colectiva
de información dentro de la misma plataforma autoalojada.

=== Conclusiones del milestone

Este milestone ha supuesto una evolución del sistema autoalojado desarrollado en
el milestone anterior, incorporando nuevas funcionalidades orientadas a la
gestión de notas personales y conocimiento compartido dentro del mismo entorno
Nextcloud. La estrategia seguida ha consistido en ampliar el PMV previo en lugar
de sustituirlo, aprovechando la infraestructura ya desplegada.

La integración de las aplicaciones Nextcloud Notes y Nextcloud Collectives ha
permitido cubrir los objetivos funcionales definidos en las historias de usuario
HU03 e HU04:

- Notes ofrece un espacio personal de escritura en formato Markdown con
  sincronización entre dispositivos, cumpliendo la necesidad del estudiante de
  organizar sus ideas y apuntes académicos sin depender de servicios externos.

- Collectives amplía estas capacidades hacia un contexto colaborativo,
  facilitando la estructuración jerárquica de documentos y el trabajo conjunto
  entre varios usuarios en tiempo real.

Ambas extensiones se integran completamente en la arquitectura de Nextcloud, sin
introducir nuevos servicios ni dependencias, y manteniendo la compatibilidad con
los mecanismos de autenticación, almacenamiento y seguridad ya establecidos. Las
pruebas realizadas demuestran que su incorporación no afecta al rendimiento ni a
la estabilidad del entorno, y que las funcionalidades implementadas satisfacen
plenamente los criterios de las historias de usuario validadas.

En conjunto, este milestone consolida a Nextcloud como una plataforma de
colaboración y gestión del conocimiento personal dentro del ecosistema
autoalojado definido en el proyecto. La solución resultante combina
almacenamiento, notas personales y espacios compartidos bajo una misma
infraestructura, ofreciendo una alternativa libre, integrada y funcional a las
plataformas propietarias de productividad en la nube.
