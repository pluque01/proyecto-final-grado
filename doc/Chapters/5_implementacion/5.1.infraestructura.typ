== M1 - Infraestructura y configuración de entorno

Este milestone tiene como objetivo seleccionar y preparar el hardware que
servirá de base para la infraestructura self-hosted, junto con la instalación y
configuración del sistema operativo. Su finalidad es disponer de un entorno
operativo mínimo, estable y accesible de forma remota, que permita continuar con
la implementación progresiva de los servicios autoalojados definidos en las
historias de usuario.

=== Objetivo del PMV

Seleccionar, instalar y configurar la infraestructura física y lógica necesaria
para alojar los servicios del proyecto, garantizando su estabilidad,
reproducibilidad y accesibilidad remota.

=== Evaluación de alternativas hardware

El self-hosting implica que los servicios se ejecuten en una infraestructura
propia, bajo control directo del usuario o de la organización. Esta elección
proporciona independencia de los proveedores externos, mayor privacidad y la
posibilidad de adaptar el entorno a las necesidades concretas del proyecto.

En el contexto del presente trabajo se han considerado tres aproximaciones
principales.

==== Servidor privado virtual (VPS)

Una primera posibilidad consiste en utilizar un servidor privado virtual
("Virtual Private Server") ofrecido por un proveedor de infraestructura en la
nube. Este modelo permite disponer de una máquina virtual con recursos
dedicados, accesible de forma permanente desde cualquier ubicación. Entre sus
ventajas destacan la alta disponibilidad, la conectividad estable y la
simplicidad de configuración inicial, ya que el mantenimiento físico del
hardware recae en el proveedor.

Sin embargo, este enfoque implica una dependencia externa y un coste mensual
recurrente, lo que puede resultar poco adecuado para proyectos personales o
educativos en los que se prioriza la autonomía, la transparencia y la reducción
de gastos.

==== Equipo físico reciclado

Otra opción consiste en habilitar un ordenador en desuso como servidor
doméstico. Esta alternativa proporciona control total sobre el hardware y
elimina los costes de suscripción, además de ofrecer una oportunidad para
reutilizar recursos existentes. Su principal desventaja reside en que por lo
general, estos equipos no están optimizados para funcionar de forma continua, lo
que puede traducirse en un mayor consumo energético y en el mantenimiento
continuo del sistema, que debe permanecer encendido de forma estable para
ofrecer disponibilidad constante.

Aun así, este enfoque resulta apropiado en entornos de aprendizaje o en
instalaciones pequeñas donde se busca experimentar con la administración de
sistemas y el despliegue de servicios locales, siempre que se asuma el consumo y
espacio físico que conlleva mantener un equipo dedicado en funcionamiento.

==== Dispositivos embebidos

Los dispositivos embebidos como la Raspberry Pi ofrecen una solución ligera y
económica para el self-hosting. A pesar de sus limitaciones de rendimiento,
proporcionan un bajo consumo energético y un funcionamiento silencioso. Con una
amplia comunidad de usuarios, tiene su propio sistema operativo basado en Linux
y una gran variedad de software compatible, lo que facilita la instalación y
gestión de servicios.

Su versatilidad permite ejecutar entornos completos de trabajo y almacenamiento
con un coste energético y económico muy reducido, manteniendo al mismo tiempo la
posibilidad de administrar el sistema mediante herramientas estándar de Linux.

=== Justificación de la elección

Tras evaluar las distintas alternativas, se ha optado por utilizar una Raspberry
Pi como servidor principal del proyecto. Esta decisión se justifica por varios
motivos:

- Se disponía previamente de una unidad funcional, lo que permitió iniciar el
  despliegue sin adquirir nuevo hardware.
- Su bajo consumo energético la hace adecuada para mantener el sistema en
  ejecución continua sin un impacto significativo en el coste eléctrico.
- Su precio reducido y amplia disponibilidad facilitan la replicación del
  entorno en otros contextos.
- Existe una gran comunidad de usuarios con el mismo hardware, lo que garantiza
  abundante documentación, soporte y soluciones ante posibles incidencias.

De esta forma, la Raspberry Pi constituye la base sobre la que se desplegarán
los distintos servicios implementados en las siguientes fases del proyecto.

Específicamente, se ha utilizado una Raspberry Pi 4 Modelo B con 4 GB de RAM y
una tarjeta microSD de 32 GB para el almacenamiento principal.

#figure(
  caption: [Raspberry Pi 4 Modelo B utilizado como servidor para el proyecto],
  image("../../Figures/Chapter5/raspberry.jpeg", width: 90%),
) <figure:raspberry>
