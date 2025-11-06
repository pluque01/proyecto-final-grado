#import "@preview/lilaq:0.5.0" as lq

= Validación y pruebas

Con el desarrollo funcional completado, este capítulo se centra en la validación
del sistema desplegado. El objetivo es comprobar que el conjunto de servicios
implementados opera de manera estable, coherente y con un rendimiento adecuado
bajo distintas condiciones de uso.

Las pruebas realizadas se han diseñado a partir de los problemas detectados o
potenciales identificados durante la fase de despliegue. Cada uno de ellos se
formula en forma de "issue" dentro del repositorio, y se aborda con un conjunto
de pruebas destinadas a verificar su resolución o impacto real en el sistema.

== Pruebas funcionales y técnicas

=== Los archivos no siempre se sincronizan correctamente entre dispositivos

Este problema se planteó para comprobar la fiabilidad del servicio de
almacenamiento y sincronización. Se realizaron pruebas de subida, edición y
eliminación de archivos desde distintos clientes: interfaz web, aplicación móvil
y cliente de escritorio.

Durante las pruebas, se observó que los cambios realizados en un dispositivo se
reflejaban correctamente en el resto tras una breve latencia, lo que confirma el
funcionamiento del mecanismo de sincronización de Nextcloud. Asimismo, la
eliminación de archivos y la creación de carpetas se propagaron sin errores.

#figure(
  stack(
    dir: ttb,
    spacing: 1em,

    image(
      "../Figures/Chapter6/nextcloud-sincronizacion-iphone.png",
      height: 50%,
    ),
    image(
      "../Figures/Chapter6/nextcloud-sincronizacion-web.png",
      width: 100%,
    ),
  ),
  caption: [Prueba de sincronización de eliminación de archivos entre la
    aplicación móvil y la interfaz web.],
)

#figure(
  stack(
    dir: ttb,
    spacing: 1em,

    image(
      "../Figures/Chapter6/nextcloud-sincronizacion-carpetas-web.png",
      width: 100%,
    ),
    image(
      "../Figures/Chapter6/nextcloud-sincronizacion-carpetas-iphone.png",
      height: 50%,
    ),
  ),
  caption: [Prueba de sincronización de creación de carpetas entre la interfaz
    web y la aplicación móvil.],
)

=== El rendimiento del sistema podría degradarse con varios usuarios concurrentes

==== Prueba de carga con Apache Benchmark

Para complementar las métricas obtenidas mediante monitorización, se realizó una
prueba de carga con la herramienta Apache Benchmark #footnote(
  "https://httpd.apache.org/docs/2.4/programs/ab.html",
), con el objetivo de evaluar la capacidad del servidor para atender múltiples
peticiones concurrentes.

El comando ejecutado fue:

```bash
ab -n 100 -c 5 https://nextcloud.nixospi.duckdns.org/index.php/login
```
En esta prueba se solicitaron 100 veces de forma concurrente la página de inicio
de sesión de Nextcloud, con un nivel de concurrencia de 5 usuarios. El servidor
procesó todas las peticiones correctamente, sin errores ni respuestas fallidas.

El tiempo total de ejecución fue de 6.9 s, con una tasa media de 14.46
peticiones por segundo y un tiempo medio de respuesta de 345 ms por petición. El
90 % de las solicitudes se sirvieron en menos de 400 ms y la más lenta no superó
los 670 ms. Durante la prueba se transfirieron aproximadamente 2.3 MB de datos,
a una velocidad media de 324 KB/s.

Estos resultados indican que el sistema mantiene una latencia baja y estable
bajo una carga concurrente moderada, mostrando un comportamiento coherente con
las limitaciones del hardware empleado. La combinación de Traefik como proxy y
Apache como servidor web permite manejar con eficiencia las conexiones TLS y
distribuir correctamente las peticiones.

#let datos = (
  (1, 316),
  (2, 339),
  (3, 353),
  (4, 360),
  (5, 394),
  (6, 434),
  (7, 603),
  (8, 667),
  (9, 667),
)
#show: lq.theme.skyline
#figure(
  lq.diagram(
    xlabel: "Percentil",
    xaxis: (
      ticks: (
        (1, "50"),
        (2, "66"),
        (3, "75"),
        (4, "80"),
        (5, "90"),
        (6, "95"),
        (7, "98"),
        (8, "99"),
        (9, "100"),
      ),
    ),
    ylabel: "Tiempo de respuesta (ms)",
    width: 100%,
    height: 6cm,
    lq.bar(
      datos.map(d => d.at(0)),
      datos.map(d => d.at(1)),
      // color: rgb("#4f8cc9"),
    ),
  ),
  caption: [Tiempos de respuesta obtenidos en la prueba de carga con Apache
    Benchmark.],
)

En conjunto, los resultados obtenidos muestran que el servidor responde de forma
estable ante múltiples solicitudes concurrentes de una página estática, lo que
permite estimar un rendimiento aceptable del sistema en operaciones básicas de
acceso. Sin embargo, este ensayo no evalúa cargas reales de trabajo del
servicio, como operaciones de lectura o escritura de archivos, por lo que sus
resultados deben interpretarse con cautela. Aun así, la prueba ofrece una
primera aproximación útil al comportamiento del sistema bajo concurrencia ligera
y sirve como punto de partida para análisis más completos.

==== Simulación de carga real concurrente

Como prueba adicional, este apartado evalúa el comportamiento del sistema ante
una carga simultánea de usuarios y analiza su estabilidad mediante
monitorización en tiempo real. Para ello se conectaron tres clientes de manera
concurrente (dos navegadores web y una aplicación móvil), ejecutando operaciones
de lectura, edición colaborativa y subida de archivos de gran tamaño (1 GB).

Durante la prueba, se registraron métricas de uso de CPU y memoria a través de
Grafana #footnote("https://grafana.com/"), con datos obtenidos mediante
exportadores de métricas del sistema #footnote(
  "https://github.com/prometheus/node_exporter",
). En el intervalo observado (entre las 10:35 y las 11:05), se detectaron varios
picos de actividad asociados a las operaciones de subida y sincronización de
archivos, alcanzando en los momentos de mayor carga un uso de CPU cercano al 80
% (@figure:ch6-grafana-cpu-load). Fuera de esos periodos, la carga del sistema
se mantuvo en torno al 30 %, lo que indica una respuesta estable y sin bloqueos.

En cuanto al consumo de memoria (@figure:ch6-grafana-mem-usage), la gráfica
muestra un aumento progresivo durante las fases de transferencia y cacheo de
datos, llegando a ocupar unos 2.8 GiB de los 4 GiB disponibles. No obstante, el
sistema no presentó saturación ni uso de memoria "swap" @linux_swap_space,
recuperando memoria libre una vez finalizadas las operaciones más intensivas.

Estos resultados confirman que, pese a las limitaciones inherentes al hardware
de la Raspberry Pi, el conjunto de servicios mantiene un comportamiento fluido y
una capacidad de respuesta adecuada en escenarios de concurrencia moderada.

#figure(
  image("../Figures/Chapter6/grafana-cpu-load.png", width: 100%),
  caption: [Uso de CPU durante la prueba de carga concurrente.],
)<figure:ch6-grafana-cpu-load>
#figure(
  image("../Figures/Chapter6/grafana-mem-usage.png", width: 100%),
  caption: [Uso de memoria durante la prueba de carga concurrente.],
)<figure:ch6-grafana-mem-usage>


=== Los contenedores podrían no reiniciarse correctamente tras un fallo o reinicio del sistema

Este problema surge de la necesidad de garantizar la persistencia y
disponibilidad de los servicios incluso ante interrupciones inesperadas.

Se llevó a cabo una prueba de reinicio completo de la Raspberry Pi, observando
el comportamiento del sistema al iniciar. Tras el arranque, los servicios
gestionados por Podman se activaron de forma automática, manteniendo la
configuración y los datos previos al reinicio.

El registro del sistema (`journalctl`) confirmó la ejecución del proceso de
arranque, mientras que la verificación mediante las herramientas de
monitorización demostró que los contenedores estaban operativos. De esta forma,
se valida que la configuración de reinicio automático es funcional.

#figure(
  caption: [Arranque del servicio Nextcloud tras un reinicio del sistema.],
)[
  ```log
  oct 31 20:39:47 rpi4 systemd[881]: Starting Service for container nextcloud...
  [--- TRUNCATED ---]
  oct 31 20:39:52 rpi4 systemd[881]: Started Service for container nextcloud.
  ```
]

#figure(
  image("../Figures/Chapter6/grafana-containers-uptime.png", width: 100%),
  caption: [Se observa como todos los contenedores se inician correctamente tras
    un reinicio.],
)

=== La colaboración en documentos podría generar conflictos de edición

El objetivo de esta prueba es verificar la consistencia de los documentos
colaborativos cuando varios usuarios editan simultáneamente un mismo archivo.

Se preparó un documento compartido y se accedió a él desde tres cuentas
distintas: dos mediante navegador web y una a través de la aplicación móvil. Los
usuarios realizaron ediciones en distintas secciones del texto en paralelo.

El sistema gestionó correctamente la concurrencia, mostrando los cambios en
tiempo real y conservando la integridad del documento. No se detectaron
conflictos de escritura ni pérdidas de contenido, lo que confirma el correcto
funcionamiento del editor colaborativo integrado en Nextcloud.

#figure(
  image("../Figures/Chapter6/nextcloud-collab-test.png", width: 100%),
  caption: [Edición simultánea de un documento desde varios clientes.],
)
