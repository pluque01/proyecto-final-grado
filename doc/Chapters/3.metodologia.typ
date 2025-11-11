= Metodología

Este capítulo tiene como propósito describir las herramientas y las metodologías
empleadas a lo largo del proyecto, con el fin de garantizar la calidad técnica,
la consistencia de la documentación y la adecuada planificación del trabajo. La
metodología seleccionada se basa en un enfoque ágil, lo que permite responder de
manera flexible a cambios e imprevistos, manteniendo a la vez un marco
estructurado para la organización y validación de resultados.

== Enfoque ágil

El proyecto se apoya en los principios del enfoque ágil, definidos inicialmente
en el Manifiesto Ágil y sus doce principios @AgileManifestoPrinciples. Más que
una metodología estricta, ágil constituye una mentalidad orientada a la
adaptación, la iteración continua y la entrega temprana de valor. Esta
perspectiva permite que los proyectos evolucionen en función de las necesidades
detectadas, en lugar de depender de una planificación rígida.

Los principios ágiles priorizan aspectos como la simplicidad, la calidad
técnica, el diseño cuidado y la capacidad de ajuste frente a nuevas
circunstancias. Su aplicación en la industria del software ha demostrado
resultados positivos en diferentes contextos, reduciendo tiempos de despliegue,
mejorando la satisfacción de los usuarios y optimizando los recursos empleados.
Aunque este trabajo se desarrolla en un entorno académico, estos mismos
fundamentos se trasladan aquí para asegurar un proceso flexible y eficiente.

=== Iteraciones mediante milestones<chapter3_milestones>

La organización del trabajo se articula a través de hitos ("milestones"), cada
uno de los cuales corresponde a un producto mínimo viable (PMV). Estos
milestones representan ciclos de desarrollo breves en los que se despliega,
configura y valida un servicio o funcionalidad específica. De este modo, cada
milestone integra tanto la implementación técnica como la documentación
asociada, asegurando que el avance del proyecto se realice de manera incremental
y verificable.

Este enfoque iterativo basado en milestones facilita la detección temprana de
errores, permite introducir ajustes en función de los resultados obtenidos y
garantiza que el trabajo conserve un progreso ordenado sin perder flexibilidad.
Los milestones actúan así como puntos de control que aseguran la coherencia con
los objetivos generales del proyecto.

=== Documentación continua

La redacción de la memoria se desarrolla en paralelo a la implementación, lo que
asegura que las decisiones tomadas, los problemas encontrados y las soluciones
aplicadas queden registradas de manera precisa y en el momento en que ocurren.
De este modo, se evita la reconstrucción posterior del proceso y se incrementa
la fidelidad de la documentación respecto al desarrollo real del proyecto.

== Herramientas utilizadas

Además de la metodología de trabajo adoptada, este proyecto se ha apoyado en un
conjunto de herramientas que han facilitado tanto la gestión del desarrollo como
la elaboración de la memoria. Estas herramientas han sido seleccionadas por su
disponibilidad, facilidad de integración y adecuación a las necesidades
específicas del trabajo.

=== Control de versiones y colaboración

Para la gestión del código y de los documentos se ha utilizado el sistema de
control de versiones *Git*, alojado en la plataforma *GitHub* #footnote(
  "https://github.com/pluque01/proyecto-final-grado",
). Esta combinación ha permitido mantener un historial claro de los cambios,
facilitando la trazabilidad y la posibilidad de revertir modificaciones en caso
necesario. Asimismo, GitHub ha servido como espacio de trabajo colaborativo en
el que organizar y centralizar el proyecto.

Dentro de GitHub, se han empleado diversas funcionalidades adicionales para
mejorar la organización:

- *Issues*: utilizadas para registrar tareas pendientes, errores o mejoras,
  permitiendo un seguimiento detallado del trabajo.
- *Pull requests*: empleados como mecanismo de revisión y validación de cambios
  antes de integrarlos en la rama principal.
- *Tablero Kanban*: configurado a partir de GitHub Projects, ha facilitado la
  planificación y el seguimiento visual de las tareas en distintas fases de
  progreso.

  #figure(
    caption: [Tablero Kanban en GitHub Projects utilizado para la gestión del
      proyecto.],
    image("../Figures/Chapter2/kanban_board.png", width: 100%),
  ) <figure:kanban_board>

=== Redacción de la memoria

Para seleccionar la herramienta de redacción de la memoria se definieron unos
criterios mínimos que debía cumplir:

- Definición clara del estilo mediante un lenguaje de marcado.
- Posibilidad de previsualizar los cambios en tiempo real.
- Disponibilidad de herramientas para validar la compilación.
- Integración de verificadores de gramática y ortografía.

Con base en estos criterios, se valoraron distintas opciones: Microsoft Word,
LaTeX y Typst:

- *Microsoft Word* #footnote(
    "https://www.microsoft.com/es-es/microsoft-365/word",
  ) ofrece facilidad de uso y una interfaz gráfica intuitiva, pero presenta
  limitaciones a la hora de garantizar un estilo uniforme en documentos extensos
  y técnicos. Su sistema de maquetación, aunque versátil, puede resultar poco
  fiable para asegurar consistencia a lo largo de todo el documento.

- *LaTeX* #footnote("https://www.latex-project.org") es una solución consolidada
  en el ámbito científico y académico, capaz de producir documentos de gran
  calidad y con un control detallado sobre el formato. Sin embargo, su sintaxis
  resulta compleja y su curva de aprendizaje es pronunciada, lo que supone una
  barrera en proyectos con tiempos acotados. A ello se suman los largos tiempos
  de compilación, que pueden dificultar la iteración rápida y el ajuste
  inmediato del contenido y del formato.
- *Typst* #footnote("https://typst.app") surge como alternativa moderna a LaTeX,
  diseñada para mantener la precisión de un lenguaje de marcado al tiempo que
  simplifica su uso y aprendizaje. Su principal ventaja es ofrecer una edición
  en tiempo real, lo que permite comprobar de inmediato el resultado del
  documento tras cualquier modificación. Además, cuenta con una comunidad activa
  en crecimiento y con integración sencilla en entornos de desarrollo como
  Visual Studio Code, donde se han empleado extensiones específicas para la
  edición de documentos Typst. Esto ha permitido complementar la escritura con
  validadores de compilación y gramática, asegurando que el texto cumpla con los
  requisitos de corrección y consistencia establecidos al inicio del proyecto.

En conclusión, *Typst* fue la opción seleccionada por equilibrar eficiencia,
facilidad de uso y capacidad de mantener un estilo uniforme en un documento
técnico extenso, todo ello sin sacrificar el rigor necesario para un trabajo
académico de este tipo.

=== Entorno para la edición de la memoria

Para la redacción de la memoria fue necesario seleccionar un entorno de edición
adecuado que permitiera trabajar con archivos Typst de manera eficiente. Antes
de elegir la herramienta se definieron los siguientes requisitos:

- Compatibilidad con Typst, incluyendo resaltado de sintaxis y compilación.
- Posibilidad de previsualizar el documento en tiempo real.
- Integración con herramientas de verificación ortográfica y gramatical.
- Integración con Git.

Con base en estos criterios se consideraron dos alternativas principales:


- *Editor web de Typst*: ofrece un entorno básico y ligero, pero limitado en
  extensiones y sin soporte avanzado de revisión lingüística. Además, la
  integración con sistemas de control de versiones es una característica de la
  versión de pago.

- *Visual Studio Code (VSCode)*#footnote("https://code.visualstudio.com"):
  editor versátil con un amplio ecosistema de extensiones, capaz de integrar
  soporte para Typst y herramientas de revisión lingüística en un mismo entorno.

La opción seleccionada fue finalmente VSCode, ya que, en combinación con sus
extensiones, satisface todos los requisitos definidos para el entorno de
edición. En particular:

- *Tinymist*#footnote("https://github.com/Myriad-Dreamin/tinymist"): proporciona
  compatibilidad completa con Typst, incluyendo resaltado de sintaxis y
  compilación. Además, permite la previsualización en tiempo real del documento,
  facilitando la detección inmediata de errores y la validación del formato.

- *LTeX+*#footnote("https://ltex-plus.github.io/ltex-plus/"): ofrece integración
  con herramientas de verificación ortográfica y gramatical en varios idiomas,
  lo que asegura que la redacción cumpla con los estándares de calidad exigidos
  en un trabajo académico.

Adicionalmente, VSCode dispone de integración nativa con Git, lo que permite
gestionar el versionado del proyecto directamente desde el editor y mantener una
trazabilidad completa de los cambios realizados. De este modo, VSCode no solo
aporta un entorno ligero y configurable, sino que gracias a su ecosistema de
extensiones e integración con Git cumple de forma explícita con todos los
requisitos planteados, consolidándose como la mejor opción frente a la otra
alternativa evaluada.

=== Workflows de validación automática

Con el objetivo de garantizar la calidad y consistencia de la memoria en todo
momento, se han configurado workflows de integración continua en el repositorio
de GitHub del proyecto. Estos workflows se ejecutan de forma automática cada vez
que se introduce un cambio en el repositorio, ya sea mediante una confirmación
de cambios ("commit") directa o a través de una solicitud de cambios ("pull
request").

Los workflows implementados realizan dos validaciones principales:

- *Compilación del documento*: se comprueba que el código Typst compile
  correctamente, asegurando que la memoria pueda generarse sin errores en
  cualquier momento del desarrollo. De este modo, se evita que cambios
  intermedios introduzcan inconsistencias que impidan producir el documento
  final.

- *Verificación gramatical*: se ejecuta una revisión lingüística automática
  sobre el contenido para detectar posibles errores de ortografía o gramática.
  Esta validación complementa el trabajo realizado de forma local en el editor y
  contribuye a mantener un estándar de calidad en la redacción.

La integración de estas comprobaciones en GitHub permite detectar problemas de
manera temprana, vinculándolos directamente con el cambio que los causa. Así, se
asegura que la memoria esté siempre en un estado válido, al mismo tiempo que se
reduce el riesgo de acumular errores difíciles de corregir en las fases finales
del proyecto.

#figure(
  caption: [Captura de pantalla de los workflows de validación automática
    configurados en GitHub Actions para la memoria del proyecto.],
  image("../Figures/Chapter3/github-workflow-checks.png", width: 100%),
) <figure:ch3_github_workflow_checks>
