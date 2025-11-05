#import "@preview/lilaq:0.5.0" as lq

= Comparativa de costes

El objetivo de este capítulo es analizar los costes asociados a la
infraestructura autoalojada desarrollada en el proyecto y compararlos con los de
una solución SaaS comercial de prestaciones equivalentes.

Este análisis no pretende ofrecer una valoración económica exacta, sino una
estimación razonada que permita contextualizar el esfuerzo de despliegue y
mantenimiento frente a alternativas gestionadas. Para ello, se consideran los
principales costes directos como hardware y energía junto con aquellos derivados
de la administración y actualización del entorno.

La comparativa se centra en las tres funcionalidades principales integradas en
el sistema:
- Almacenamiento y colaboración de archivos.
- Estructuración y edición colaborativa de notas.
- Gestión de contraseñas.

A partir de esta base, se estimará el coste anualizado de la solución
autoalojada y se contrastará con los precios de mercado de las opciones SaaS,
permitiendo valorar la rentabilidad, sostenibilidad y conveniencia del enfoque
adoptado.

== Alcance y metodología

El análisis de costes se centra en los componentes que conforman la solución
autoalojada desplegada, considerando tanto los recursos materiales como los
servicios complementarios necesarios para su funcionamiento continuo.

El cálculo incluye las siguientes categorías:
- Infraestructura física: hardware empleado para el alojamiento del servicio,
  como la Raspberry Pi y el almacenamiento externo.
- Servicios asociados: dominio y mecanismos de acceso remoto seguro.
- Consumo energético: estimación basada en el funcionamiento ininterrumpido del
  dispositivo.
- Mantenimiento y administración: tiempo dedicado a la instalación,
  actualización de aplicaciones y supervisión del sistema.

Las estimaciones se realizan tomando como referencia precios medios de mercado
en 2025 y una operación estable durante un periodo de un año.

Para establecer un punto de comparación equilibrado, se seleccionan servicios
SaaS representativos que cubren las funcionalidades equivalentes de forma
modular:
- Dropbox Plus, como alternativa al almacenamiento y sincronización de archivos.
- Notion, para la edición y estructuración colaborativa de notas.
- Bitwarden Teams, en la gestión y compartición de contraseñas.

A partir de estos valores se calculará el coste total anualizado de la solución
autoalojada y se contrastará con los precios de las alternativas SaaS, evaluando
así la relación entre coste, control, autonomía y esfuerzo de mantenimiento.

== Costes de la solución autoalojada

La infraestructura implementada en el proyecto se basa en una arquitectura
autoalojada de bajo consumo, compuesta por una Raspberry Pi como servidor
principal y almacenamiento externo para los datos. Este enfoque minimiza la
inversión inicial y permite mantener un coste operativo muy reducido.

A continuación se detalla una estimación aproximada de los costes anuales,
tomando como referencia precios medios de mercado en 2025.

#figure(
  table(
    columns: 3,
    stroke: 0.5pt,
    inset: 1em,
    align: (left, left, right),
    [Concepto], [Detalle / estimación], [Coste (€)],
    table.cell(rowspan: 5, [Hardware]), [Raspberry Pi 4 (4GB)], [60 €],
    [Fuente de alimentación], [10 €],
    [Caja], [15 €],
    [Tarjeta microSD (32GB)], [12 €],
    [SSD 1TB externo], [50 €],
    [Dominio],
    [Registro anual de dominio],
    [0 € #footnote(
        "En este proyecto se ha utilizado un dominio gratuito proporcionado por DuckDNS, pero se puede adquirir un dominio personalizado por un coste anual aproximado de 10€.",
      )],
    [Acceso remoto seguro], [Tailscale - plan gratuito], [0 €],
    [Consumo energético], [55,8 kWh/año a 0,14 €/kWh], [8 €],
    [Mantenimiento y administración],
    [1 hora/mes a 15 €/hora],
    [180 €],
    [*Total primer año*], [*Incluye hardware*], [*335 €*],
    [*Total anual recurrente*], [*Sin inversión inicial*], [*188 €*],
  ),
  caption: "Desglose de costes de infraestructura y operación del sistema autoalojado.",
)

=== Costes de hardware

La Raspberry Pi 4 de 4 GB utilizada como servidor principal se adquirió en el
año 2023, aunque hoy en día su precio ronda los 60 € más el coste de la fuente
de alimentación oficial, que cuesta aproximadamente 10 €.

Adicionalmente, se adquirió una la caja protectora con ventilador para mejorar
la refrigeración, que costó alrededor de 15 €. La tarjeta microSD de 32 GB tiene
un coste aproximado de 12 €. Como almacenamiento adicional, se reutilizó un
disco duro de 1 TB de un ordenador antiguo, pero se puede adquirir un disco duro
externo de la misma capacidad por unos 50 €.

=== Consumo energético

Para estimar el coste eléctrico, se conectó la Raspberry Pi a un enchufe
inteligente que registró el consumo diario durante una semana. Las mediciones
mostraron un consumo medio de 0,153 kWh/día, con pequeñas variaciones entre
jornadas (Ver @figure:ch7_consumo_energetico).

#let datos = (
  (datetime(year: 2025, month: 10, day: 20), 0.153),
  (datetime(year: 2025, month: 10, day: 21), 0.152),
  (datetime(year: 2025, month: 10, day: 22), 0.154),
  (datetime(year: 2025, month: 10, day: 23), 0.153),
  (datetime(year: 2025, month: 10, day: 24), 0.155),
  (datetime(year: 2025, month: 10, day: 25), 0.153),
  (datetime(year: 2025, month: 10, day: 26), 0.152),
)

#show: lq.theme.skyline
#figure(
  lq.diagram(
    xaxis: (
      format-ticks: lq.tick-format.datetime.with(
        format: "[month]/[day]",
      ),
      tick-args: (density: 80%),
    ),
    xlabel: "Fecha",
    ylabel: "Consumo (kWh/día)",
    width: 100%,
    height: 6cm,
    lq.plot(
      datos.map(d => d.at(0)),
      datos.map(d => d.at(1)),
      color: rgb("#4f8cc9"),
    ),
  ),
  caption: "Consumo diario de la Raspberry Pi durante una semana.",
)<figure:ch7_consumo_energetico>

El consumo anual equivalente es de 55,8 kWh, lo que representa un coste
aproximado de aproximadamente 8 € al año considerando un precio medio de 0,14
€/kWh @costeenergia_pvpc_2025. Estos valores confirman el bajo impacto
energético de la infraestructura, que puede mantenerse operativa de forma
continua sin un coste significativo.

=== Costes de mantenimiento y administración
El mantenimiento de la infraestructura autoalojada se limita principalmente a
tareas de supervisión y control, ya que tanto el sistema base como las
aplicaciones implementadas disponen de mecanismos de actualización automática.

Por tanto, la intervención manual se reduce a una dedicación periódica estimada
de una hora mensual, destinada a las siguientes acciones:

- Comprobación del estado general de los servicios desplegados y sus
  contenedores.
- Revisión del uso de recursos (CPU, memoria, almacenamiento).
- Resolución puntual de incidencias o alertas notificadas por el sistema.
- Validación de las actualizaciones aplicadas de forma automática.

El cálculo del coste se realiza aplicando una tasa de referencia de 15 €/hora,
representativa del coste laboral de un perfil técnico encargado de la
administración del entorno.

#align(center, $ 1 h\/"mes" times 12 "meses" times 15 €\/h = 180 € \/"año" $)

Este valor se incluye en la estimación total de costes recurrentes y refleja el
esfuerzo mínimo necesario para mantener el sistema operativo, estable y seguro a
lo largo del tiempo.

== Costes de las soluciones SaaS

Para contrastar la solución autoalojada con alternativas comerciales, se han
seleccionado tres servicios representativos que cubren las funcionalidades
desplegadas en el sistema: almacenamiento y colaboración de archivos, edición
colaborativa de notas y gestión de contraseñas compartidas. A continuación, se
presenta una estimación anual por usuario, basada en los precios públicos
vigentes en 2025, junto con una breve descripción de lo que incluye cada plan.

#figure(
  table(
    columns: 3,
    align: (left, left, right),
    inset: 1em,
    stroke: 0.5pt,
    [*Servicio*], [*Funciones*], [*Coste anual (€/usuario)*],

    [Dropbox Plus (2 TB) - almacenamiento y sincronización],
    [1 usuario, 2 TB, recuperación 30 días],
    [120 €],

    [Notion Plus - notas y colaboración],
    [1 usuario, funcionalidades avanzadas de edición],
    [114 € ],

    [Bitwarden Teams - gestión de contraseñas],
    [Funciones de equipo y auditoría básica],
    [42 €],

    [*Total anual por usuario*], [], [*276 €*],
  ),
  caption: "Estimación de costes anuales por usuario para servicios SaaS equivalentes.",
)

=== Notas de estimación

- Para Dropbox Plus: el plan personal se oferta por 9,99 €/mes facturado
  anualmente #footnote("https://www.dropbox.com/es/plans").

- Para Notion Plus: el plan cuesta aproximadamente 9,50 €/usuario/mes facturado
  anualmente #footnote("https://www.notion.com/es-es/pricing").

- Para Bitwarden Teams: el precio se sitúa en torno a 4 US\$/usuario/mes
  facturado anualmente para el plan de organización #footnote(
    "https://www.bitwarden.com/pricing/",
  ), que equivalen a 42 €/usuario/año al cambio actual.

Estos importes representan los costes mínimos por usuario para obtener un
servicio gestionado que cubre funcionalidades similares a las implementadas en
el sistema autoalojado. Con una suma total de 276 € anuales por usuario, estas
soluciones ofrecen una experiencia integrada y sin necesidad de gestionar la
infraestructura subyacente.

== Comparativa global de costes

La @figure:ch7_coste_acumulado representa el coste acumulado de ambas
alternativas a lo largo del tiempo con pendientes constantes (coste anual fijo
en cada opción). En la solución autoalojada, el desembolso inicial por hardware
genera un desplazamiento vertical en el coste del año 0, tras el cual el
crecimiento es lineal con la misma pendiente en todos los años porque el gasto
operativo anual es constante.

En la alternativa SaaS, la recta parte de cero y también crece linealmente
porque sus costes anuales son constantes. Si aumentase el número de usuarios, la
pendiente de la recta SaaS sería mayor (al sumar cuotas por usuario), mientras
que en la solución autoalojada la pendiente se mantendría prácticamente
invariable al no depender directamente del número de cuentas.

En el escenario mostrado, las rectas se cruzan entre los años 2 y 3. A partir de
ese punto, el coste acumulado del autoalojado resulta inferior, evidenciando su
ventaja económica a medio plazo cuando se asume un uso continuado.

#show: lq.theme.skyline

#let años = (0, 1, 2, 3, 4, 5)
#let coste_auto = (147, 335, 515, 695, 875, 1055)
#let coste_saas = (0, 276, 552, 828, 1104, 1380)

#show: lq.set-legend(position: bottom)

#figure(
  lq.diagram(
    xlabel: "Año",
    ylabel: "Coste acumulado (€)",
    xaxis: (
      ticks: años,
    ),
    yaxis: (
      ticks: (
        (0, "0"),
        (200, "200"),
        (400, "400"),
        (600, "600"),
        (800, "800"),
        (1000, "1000"),
        (1200, "1200"),
        (1400, "1400"),
      ),
    ),
    width: 100%,
    height: 6cm,
    lq.plot(
      años,
      coste_auto,
      color: rgb("#4f8cc9"),
      label: "Autoalojado",
    ),
    lq.plot(
      años,
      coste_saas,
      color: rgb("#f57c00"),
      label: "SaaS",
    ),
  ),
  caption: "Evolución del coste acumulado de la solución autoalojada frente a un servicio SaaS equivalente durante cinco años.",
)<figure:ch7_coste_acumulado>
