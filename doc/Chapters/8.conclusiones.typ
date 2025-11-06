= Conclusiones

Este Trabajo Fin de Grado ha tenido como objetivo diseñar e implantar una
infraestructura autoalojada que cubra las necesidades de almacenamiento,
colaboración, toma de notas y gestión de contraseñas de un equipo pequeño,
priorizando el control sobre los datos, la sostenibilidad económica y la
simplicidad operativa.

El resultado obtenido es una plataforma funcional y reproducible desplegada
sobre una Raspberry Pi 4, basada en NixOS y contenedores gestionados con Podman.
A lo largo del proyecto se ha demostrado que es posible mantener un entorno
colaborativo completo, accesible de forma segura y estable, sin recurrir a
servicios externos ni exponer la infraestructura doméstica a Internet.

== Cumplimiento de objetivos

El desarrollo se ha estructurado en varios hitos (M1-M4), que han permitido
abordar de forma incremental los distintos componentes del sistema. Los
objetivos específicos se han alcanzado en su totalidad o con ligeras
limitaciones, como se resume a continuación:

- Despliegue de Nextcloud como sistema central de colaboración: Se ha
  implementado en contenedores junto a MariaDB y Traefik, con certificados
  automáticos y acceso seguro por Tailscale. El servicio ofrece sincronización
  multiplataforma y funcionamiento estable, cumpliendo plenamente el propósito
  inicial.

  - Ver @cap:5_m2.

- Gestión de notas y documentación compartida: La integración de Notes y
  Collectives dentro de Nextcloud permite crear notas personales y wikis
  colaborativas en Markdown, accesibles desde web y móvil. La solución resultó
  sencilla y eficaz, sin requerir servicios adicionales.

  - Ver @cap:5_m3.

- Gestor de contraseñas autogestionado: Se ha habilitado la aplicación oficial
  Passwords, que permite compartir credenciales de manera selectiva con cifrado
  y auditoría. Aunque no admite aún la compartición por grupos completos, cubre
  los requisitos funcionales del hito y se integra sin modificar la
  infraestructura existente.

  - Ver @cap:5_m4.

- Contenedorización completa del entorno: Todos los servicios se ejecutan
  mediante contenedores sin privilegios de administrador, con redes internas,
  persistencia de datos y actualización automatizada con NixOS. Esto aporta
  aislamiento, seguridad y facilidad de mantenimiento.

  - Ver @cap:5_m1.

- Análisis comparativo con servicios SaaS: Se ha realizado una revisión de
  alternativas comerciales y de código abierto (Google Drive, Notion, 1Password,
  etc.), destacando que la solución propuesta ofrece un mayor control de datos y
  un coste prácticamente nulo, a costa de un mantenimiento más técnico.

  - Ver @cap:2_estado_arte.

- Documentación y reproducibilidad: La memoria describe de forma detallada cada
  fase del despliegue y validación, con referencias cruzadas y configuraciones
  reproducibles.

  - Ver las diferentes secciones del Capítulo 5.

== Consideraciones éticas y sostenibilidad

El proyecto se ha desarrollado bajo principios de privacidad, seguridad y
soberanía digital, evitando la exposición pública de los servicios, aplicando
cifrado extremo a extremo y autenticación de doble factor. Estas medidas se
alinean con el Reglamento General de Protección de Datos (RGPD) @rgpd2016.

Además, el enfoque autoalojado y el uso de software libre contribuyen a los
Objetivos de Desarrollo Sostenible (ODS) @onu_ods_agenda2030, especialmente el
ODS 9 (infraestructuras resilientes e innovación tecnológica) y el ODS 12
(consumo responsable y reducción de residuos tecnológicos), al reutilizar
hardware de bajo consumo y priorizar soluciones abiertas.

== Valoración y aprendizaje

El desarrollo del proyecto ha consolidado conocimientos previos en
administración de sistemas, redes y contenedorización, y ha requerido la
adquisición de nuevas competencias en tecnologías emergentes como los sistemas
operativos declarativos (NixOS), la gestión de proxies inversos y certificados,
el acceso seguro mediante VPN de malla y la automatización de la documentación
técnica con Typst.

Más allá del aprendizaje técnico, el trabajo ha supuesto un ejercicio integral
de planificación, documentación y comunicación, fortaleciendo habilidades
transversales esenciales en la práctica profesional de la ingeniería
informática.

El resultado final demuestra que un entorno colaborativo completo puede
mantenerse de forma local, segura y sostenible con recursos modestos, siempre
que se adopten principios de automatización y buenas prácticas operativas.
Personalmente, el proyecto ha representado un reto técnico y organizativo, pero
también una experiencia formativa muy enriquecedora.

La parte más compleja fue el inicio del proyecto, cuando fue necesario desplegar
desde cero el sistema operativo base y establecer la infraestructura de
contenedores. Esa etapa requirió una fuerte dedicación y una comprensión
profunda de NixOS, pero sentó las bases sólidas para el resto de hitos. A partir
de ahí, el trabajo avanzó de manera más fluida y me permitió centrarme en la
integración y validación de servicios.

En conjunto, el trabajo confirma la viabilidad técnica de las soluciones
autoalojadas frente a los modelos SaaS tradicionales, y pone de relieve el valor
del aprendizaje autónomo y del pensamiento crítico sobre la tecnología que
utilizamos.

== Líneas de mejora y trabajos futuros

El sistema actual es plenamente funcional, pero existen diversas áreas de
evolución que permitirían aumentar su fiabilidad y escalabilidad:

- Copias de seguridad y restauración: establecer un sistema de respaldo
  periódico que garantice la recuperación de datos ante fallos o pérdidas. Se
  propone aplicar la regla 3-2-1 (varias copias, distintos soportes y al menos
  una externa) @acronis_backup_rule, junto con cifrado y comprobaciones
  regulares de restauración para asegurar su fiabilidad.

- Soberanía total de red: habilitar un servidor privado virtual que actúe como
  nodo central de Tailscale (Headscale), eliminando dependencias externas.

- Gestión avanzada de contraseñas: explorar otra alternativa con integración de
  roles y grupos.

- Supervisión y alertas automáticas: reforzar la seguridad y la estabilidad del
  sistema mediante el seguimiento continuo de métricas, detección de accesos
  sospechosos y generación de avisos ante incidencias.
