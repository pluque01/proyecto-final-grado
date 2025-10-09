= Planificación

La planificación del proyecto constituye una fase esencial que permite organizar
el trabajo de forma eficiente y asegurar el cumplimiento de los objetivos
planteados. En este capítulo se describe cómo se ha estructurado el desarrollo
siguiendo un enfoque iterativo e incremental, en coherencia con los principios
ágiles expuestos en la metodología.


== Organización del proyecto

Para la gestión y el seguimiento se ha empleado GitHub, aprovechando sus
funcionalidades nativas de planificación, como los milestones para agrupar
tareas y los issues para registrar el progreso y las decisiones tomadas. Este
sistema permite mantener un control centralizado del proyecto dentro del propio
repositorio, facilitando la trazabilidad de los cambios y la documentación
continua de los avances.

=== Milestones

El desarrollo se ha estructurado en una serie de milestones, cada uno con un
objetivo concreto y verificable. Cada milestone agrupa un conjunto de issues
relacionadas, que detallan las tareas necesarias para alcanzar dicho objetivo.
Este enfoque permite dividir el trabajo en bloques manejables y evaluar el
progreso de forma clara y medible.

El primer milestone (M0) se ha dedicado a establecer la infraestructura inicial
del proyecto. Incluye la configuración del entorno de trabajo, la verificación
del correcto funcionamiento del compilador de Typst y la revisión ortográfica y
gramatical del documento base. Además, en esta etapa se han documentado las
decisiones relativas a la estructura del repositorio y a la adaptación de la
infraestructura para posibles usos futuros.

Los milestones posteriores se centrarán en la entrega de productos mínimos
viables (PMV) que cubran las necesidades identificadas en las historias de
usuario. Cada PMV representará una versión funcional o parcial del sistema que
permita validar un conjunto de requisitos concretos y avanzar de manera
progresiva hacia el resultado final. De esta forma, el proyecto mantiene una
orientación práctica y que se puede validar en cada fase, asegurando que las
iteraciones aporten valor y se ajusten a los objetivos definidos.

== Gestión de tareas y seguimiento

Las tareas individuales del proyecto se gestionan mediante issues, que actúan
como unidades de trabajo independientes. Cada issue describe una acción o
problema específico, indicando su propósito, el estado de avance y las
decisiones asociadas. Este sistema permite descomponer los objetivos de cada
milestone en pasos concretos y fácilmente verificables.

El cierre de las tareas se vincula directamente con los pull requests, que
documentan los cambios realizados en el repositorio. Cada pull request hace
referencia a las issues que resuelve, de modo que el proceso de revisión y
validación queda integrado en el propio flujo de desarrollo. GitHub proporciona
además indicadores automáticos de progreso en cada milestone, permitiendo
visualizar el porcentaje de tareas completadas y realizar un seguimiento del
avance general.


#figure(
  caption: [Captura de pantalla de los issues cerrados en GitHub],
  image("../Figures/Chapter4/github_issues.png", width: 100%),
) <figure:github_issues>

== Control y adaptación del plan

El carácter iterativo de la planificación implica una revisión constante del
progreso y la posibilidad de ajustar los objetivos según sea necesario. Al
cierre de cada milestone, se evalúa el grado de cumplimiento de las tareas y se
documentan las decisiones tomadas o los ajustes aplicados.

Este mecanismo de control permite detectar posibles desviaciones en el tiempo o
en el alcance, así como introducir medidas correctoras. Cuando una tarea
requiere más tiempo del previsto o se identifican nuevas necesidades, se
actualizan las issues o se crean nuevas entradas que reflejen dichos cambios. De
esta manera, la planificación se mantiene viva y coherente con la evolución real
del proyecto, garantizando que los resultados finales se alineen con los
objetivos definidos.
