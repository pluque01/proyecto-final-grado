= Costes

En este capítulo se detallan los costes asociados al desarrollo e implantación
del sistema, incluyendo los costes de personal y hardware empleados durante el
proyecto. La mayoría de las herramientas utilizadas son de código abierto, lo
que ha permitido reducir significativamente los costes de desarrollo.

Asimismo, se presenta una estimación económica del esfuerzo técnico necesario
para reproducir el despliegue en un entorno similar.

== Costes de hardware

El desarrollo y despliegue del sistema se ha realizado sobre una infraestructura
propia basada en una Raspberry Pi 4 y un disco SSD externo. Ambos elementos son
reutilizables en futuros proyectos y su coste se ha estimado aplicando una
amortización lineal a cuatro años, según los porcentajes de la tabla de
amortización simplificada de la Agencia Tributaria Española
@aeat_tabla_amortizacion_2025.

#figure(
  table(
    columns: 4,
    align: (left, center, center, right),
    inset: 1em,
    stroke: 0.5pt,
    [*Hardware*],
    [*Valor (€)*],
    [*Amortización anual (%)*],
    [*Coste imputado (9 meses)*],

    [ Raspberry Pi 4 (4 GB) ], [ 70 € ], [ 25 % ], [ 13,1 € ],
    [ SSD 1 TB externo ], [ 50 € ], [ 25 % ], [ 9,4 € ],
  ),
  caption: [Costes de hardware imputados durante el periodo de desarrollo.],
)

El coste imputado total del hardware durante el periodo de desarrollo asciende a
22,5 €, valor que representa la fracción amortizada del equipamiento utilizado.

== Costes de software

Todo el entorno se ha implementado empleando principalmente software libre y de
código abierto, como el sistema operativo NixOS, los servicios de
contenedorización y las aplicaciones integradas (Nextcloud, Traefik, etc.).

Una excepción es Tailscale, una herramienta de red privada basada en WireGuard,
que dispone de cliente de código abierto pero servicios de coordinación
propietarios. No obstante, para este proyecto se ha utilizado el plan gratuito,
suficiente para la conexión remota entre dispositivos sin incurrir en ningún
coste económico adicional.

Por tanto, el conjunto del software empleado no ha generado costes de licencia
ni de suscripción, aunque se reconoce la dependencia parcial de un servicio
externo en el componente de conectividad.

== Costes de personal

El desarrollo del proyecto se ha llevado a cabo de forma individual, asimilable
al trabajo de un perfil técnico en administración de sistemas o desarrollo
DevOps. Considerando una duración total del proyecto de nueve meses y un sueldo
medio anual de 25 000 € para un perfil técnico junior, se obtiene el coste
estimado siguiente:

#figure(
  table(
    columns: 3,
    align: (left, center, right),
    inset: 1em,
    stroke: 0.5pt,
    [*Concepto*], [*Tiempo*], [*Coste (€)*],
    [ Coste laboral estimado ], [ 9 meses ], [ 18.750 € ],
  ),
  caption: [Estimación del coste de personal asociado al desarrollo del
    proyecto.],
)

El coste total del personal representa la mayor parte del esfuerzo económico del
proyecto, al tratarse de un trabajo de diseño, configuración y validación
intensivo en tiempo, pero no en recursos materiales.

== Costes de despliegue

El despliegue del sistema se ha realizado sobre infraestructura propia, sin
recurrir a servicios de alojamiento externos. Por tanto, no existen costes de
alojamiento ni de suscripción asociados. La disponibilidad de un servidor
personal con bajo consumo energético permite mantener el entorno operativo con
un coste prácticamente nulo más allá del consumo eléctrico.

== Análisis global

El coste total de desarrollo e implantación del sistema se estima en 18.772,5 €,
correspondientes casi en su totalidad al tiempo técnico invertido en el diseño,
despliegue y validación del entorno. El uso de software libre y herramientas sin
coste de licencia, junto con hardware de bajo consumo y precio reducido,
demuestra que la viabilidad económica del proyecto depende fundamentalmente del
esfuerzo de configuración y administración, y no de la adquisición de recursos o
suscripciones externas.
