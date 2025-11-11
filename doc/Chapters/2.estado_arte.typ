= Estado del arte<cap:2_estado_arte>

En este capítulo se revisan las principales soluciones de productividad digital
en dos vertientes: los servicios comerciales en la nube ("Software as a Service,
SaaS"), que dominan actualmente el mercado, y las alternativas autoalojadas
basadas en software libre. El análisis se organiza por áreas funcionales y busca
destacar qué ventajas ofrece cada modelo y qué limitaciones implica.

== Marco conceptual y tendencias

Durante la última década, los servicios en la nube en modalidad SaaS se han
convertido en la opción preferente tanto para usuarios particulares como para
organizaciones. La clave de su éxito reside en la facilidad de uso, la
inmediatez y el bajo coste inicial: basta con registrarse en una plataforma para
disponer de almacenamiento de archivos, herramientas colaborativas o gestores de
información sin preocuparse por la infraestructura.

De acuerdo con un estudio reciente de Gartner, citado por Silicon (2024), el 75%
de las empresas priorizarán el respaldo de aplicaciones SaaS para 2028, lo que
refleja la madurez y consolidación del modelo de servicios en la nube
@silicon2024-saas.

Sin embargo, este modelo también tiene limitaciones. En primer lugar, implica
una dependencia del proveedor: la continuidad del servicio, el acceso a las
funciones y la política de precios quedan sujetos a las decisiones de una
empresa externa. En segundo lugar, los costes recurrentes de las suscripciones,
aunque asumibles a corto plazo, tienden a acumularse con el tiempo. Finalmente,
los datos quedan alojados en servidores de terceros, lo que plantea
interrogantes en materia de privacidad y control.

Frente a este paradigma, ha ganado terreno el autoalojamiento, que consiste en
desplegar servicios sobre infraestructura propia. Este modelo aporta mayor
soberanía sobre los datos, un coste más estable a medio y largo plazo y la
flexibilidad de personalizar el entorno digital. La contrapartida es que
requiere conocimientos técnicos y un esfuerzo constante de administración y
mantenimiento.

== Almacenamiento y colaboración de archivos

Los servicios de almacenamiento en la nube han sido pioneros en popularizar el
SaaS. Google Drive #footnote(
  "https://workspace.google.com/intl/es/products/drive/",
), Dropbox #footnote("https://www.dropbox.com") y Microsoft 365 #footnote(
  "https://www.microsoft.com/es-es/microsoft-365",
) son referentes consolidados, con funcionalidades avanzadas como la edición
colaborativa en tiempo real, la integración con suites ofimáticas completas y la
posibilidad de compartir documentos mediante enlaces o permisos detallados.
Estas plataformas destacan por su usabilidad y por el soporte centralizado, lo
que las hace accesibles a usuarios sin conocimientos técnicos.

Dentro del ecosistema autoalojado, una de las soluciones más extendidas es
Nextcloud #footnote("https://nextcloud.com"), que ofrece un sistema de
sincronización y compartición de archivos bajo licencia AGPL. Permite mantener
carpetas sincronizadas en múltiples dispositivos, incorpora versionado de
documentos y evita conflictos mediante bloqueo de archivos. Su arquitectura
modular posibilita añadir aplicaciones adicionales como calendarios, contactos o
notas. En materia de seguridad, Nextcloud integra cifrado de las comunicaciones
y autenticación multifactor.

La comparación entre ambos modelos es clara. Las plataformas SaaS destacan por
su inmediatez, experiencia de usuario refinada y soporte profesional, mientras
que Nextcloud ofrece control total sobre los datos y la posibilidad de adaptar
el servicio a necesidades específicas, al precio de asumir la gestión de copias
de seguridad, actualizaciones y rendimiento del servidor.

== Toma de notas y organización personal

En el ámbito de la organización personal y la toma de notas, las soluciones SaaS
más extendidas son Notion #footnote("https://www.notion.so") y Evernote
#footnote("https://evernote.com"). Estas herramientas proporcionan interfaces
intuitivas, plantillas listas para usar, funciones colaborativas en tiempo real
y sincronización transparente entre dispositivos. Además, suelen integrar
funciones avanzadas como bases de datos, calendarios o tableros kanban, lo que
las convierte en suites versátiles para la productividad.

Entre las alternativas libres de autohospedaje destaca Logseq #footnote(
  "https://logseq.com",
), que plantea una filosofía distinta: utiliza archivos de texto plano,
normalmente en formato Markdown, y permite estructurar la información en forma
de grafo de conocimiento, enlazando ideas y notas de manera bidireccional. Su
sencillez técnica lo hace fácilmente portable y permite integrarse con
repositorios Git para asegurar la persistencia y el versionado de los datos.

La comparación pone de manifiesto las diferencias de enfoque. Las plataformas
SaaS como Notion destacan por la colaboración fluida, la experiencia de usuario
cuidada y la disponibilidad inmediata de plantillas y recursos, mientras que
Logseq se centra en ofrecer control absoluto sobre los datos, transparencia en
el formato de almacenamiento y flexibilidad para personalizar el flujo de
trabajo. El sacrificio en el autoalojamiento es la pérdida de ciertas funciones
avanzadas y una mayor responsabilidad en la configuración.

== Gestión de contraseñas

Los gestores de contraseñas en modalidad SaaS como 1Password #footnote(
  "https://1password.com",
), LastPass #footnote("https://lastpass.com") o la propia versión en la nube de
Bitwarden #footnote("https://bitwarden.com") han ganado gran popularidad. Sus
puntos fuertes son la experiencia de usuario madura, la sincronización
automática entre dispositivos y el acceso a funciones avanzadas, como la
integración con directorios corporativos, el inicio de sesión único (SSO) o la
recuperación de cuentas. Estas características los convierten en opciones
especialmente atractivas para entornos empresariales.

En el ámbito del autoalojamiento, una opción ligera y ampliamente adoptada es
Vaultwarden #footnote("https://github.com/dani-garcia/vaultwarden"), que
mantiene compatibilidad con los clientes oficiales de Bitwarden. Ofrece cifrado
de extremo a extremo, soporte de autenticación multifactor y la posibilidad de
compartir contraseñas de forma controlada entre usuarios. Su reducido consumo de
recursos lo hace idóneo para un escenario de servidor único, y su licencia
AGPL-3.0 garantiza transparencia y comunidad activa.

El contraste se centra en las prioridades. Mientras que los gestores SaaS
destacan por la robustez empresarial, el soporte profesional y las funciones
avanzadas orientadas a organizaciones, Vaultwarden proporciona independencia,
soberanía de los datos y un despliegue ligero, aunque sin algunas prestaciones
corporativas.
