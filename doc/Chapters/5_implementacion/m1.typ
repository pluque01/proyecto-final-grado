== [M1] Infraestructura y configuración de entorno<cap:5_m1>

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

=== Selección del hardware

El self-hosting implica que los servicios se ejecuten en una infraestructura
propia, bajo control directo del usuario o de la organización. Esta elección
ofrece independencia de proveedores externos, mayor privacidad y la posibilidad
de adaptar el entorno a las necesidades concretas del proyecto.

==== Alternativas consideradas

Se evaluaron tres aproximaciones principales para alojar los servicios del
proyecto:

- *Servidor privado virtual (VPS)*: Consiste en contratar una máquina virtual en
  la nube con recursos dedicados. Ofrece alta disponibilidad, buena conectividad
  y configuración inicial sencilla, ya que el mantenimiento físico recae en el
  proveedor. No obstante, introduce dependencia externa y un coste mensual
  recurrente, factores poco adecuados para un entorno educativo o experimental
  orientado a la autonomía.

- *Equipo físico reciclado*: Permite reutilizar un ordenador en desuso como
  servidor doméstico, eliminando gastos de suscripción y garantizando control
  total sobre el hardware. Sin embargo, este tipo de equipos suele tener un
  consumo energético elevado y no está optimizado para funcionar de forma
  continua, lo que afecta a su eficiencia y mantenimiento.

- *Dispositivo embebido (Raspberry Pi)*: Presenta una solución ligera y
  económica, con bajo consumo energético y funcionamiento silencioso
  @raspi_benchmarks_2024. Ofrece una amplia comunidad, soporte estable y
  compatibilidad con distribuciones GNU/Linux orientadas al self-hosting, lo que
  facilita la instalación y administración de servicios.

==== Criterios de elección

Las alternativas se valoraron según los siguientes criterios:

- Coste económico: inversión inicial y ausencia de cuotas recurrentes.

- Consumo energético: viabilidad para funcionamiento continuo sin impacto
  significativo.

- Autonomía: control completo del entorno sin depender de terceros.

- Escalabilidad y replicabilidad: facilidad para reproducir la infraestructura
  en otros contextos.

- Soporte comunitario: disponibilidad de documentación, foros y soluciones.

==== Justificación de la elección

Tras el análisis, se optó por utilizar una Raspberry Pi como servidor principal
del proyecto. Esta decisión se fundamenta en los siguientes aspectos:

- Se disponía previamente de una unidad funcional, lo que evitó costes iniciales
  y aceleró la implementación.

- Su bajo consumo energético permite mantenerla encendida de forma continua con
  un gasto mínimo.

- Su precio reducido y amplia disponibilidad favorecen la replicación del
  entorno en otros escenarios educativos o de investigación.

- La gran comunidad de usuarios y abundante documentación garantizan soporte
  estable y soluciones ante incidencias.

- En conjunto, la Raspberry Pi ofrece el equilibrio ideal entre eficiencia,
  autonomía y sostenibilidad, cumpliendo los requisitos del proyecto para una
  infraestructura self-hosted ligera y reproducible.

De esta forma, la Raspberry Pi constituye la base sobre la que se desplegarán
los distintos servicios implementados en las siguientes fases del proyecto.
Específicamente, se ha utilizado una Raspberry Pi 4 Modelo B con 4 GB de RAM y
una tarjeta microSD de 32 GB para el almacenamiento principal.

#figure(
  caption: [Raspberry Pi 4 Modelo B utilizado como servidor para el proyecto],
  image("../../Figures/Chapter5/raspberry.jpeg", width: 90%),
) <figure:raspberry>

=== Selección del sistema operativo

Una vez definido el hardware, se procedió a evaluar las posibles opciones de
sistema operativo para la infraestructura self-hosted. El objetivo era disponer
de un entorno ligero, estable y reproducible, que facilitara la instalación de
servicios, el mantenimiento a largo plazo y la automatización de la
configuración.

==== Alternativas consideradas

Se analizaron distintas distribuciones de GNU/Linux con soporte para la
arquitectura ARM y orientadas al uso como servidor:

- *Raspberry Pi OS* #footnote(
    "https://www.raspberrypi.com/software/operating-systems/",
  ): distribución oficial basada en Debian y optimizada para el hardware de la
  placa. Su principal ventaja es la compatibilidad inmediata con todos los
  controladores y la gran cantidad de documentación disponible. Sin embargo, su
  enfoque generalista y la configuración manual de paquetes dificultan la
  reproducibilidad exacta del entorno en otros equipos.

- *Ubuntu Server* #footnote("https://ubuntu.com/download/server"): versión
  minimalista del sistema de Canonical, también disponible para ARM. Ofrece
  estabilidad y soporte LTS, junto con una amplia compatibilidad de software. Su
  desventaja radica en el mayor consumo de recursos y en la dependencia de
  herramientas tradicionales de gestión, menos adecuadas para un enfoque
  declarativo.

- *DietPi* #footnote("https://dietpi.com/"): sistema extremadamente ligero
  orientado a entornos embebidos. Es fácil de instalar y ofrece scripts
  automatizados para servicios comunes, pero su ecosistema es más limitado y
  depende en gran medida de configuraciones predefinidas, reduciendo la
  flexibilidad y trazabilidad de los cambios.

- *NixOS* #footnote("https://nixos.org/"): distribución construida en torno al
  gestor de paquetes y sistema de configuración Nix. Permite definir toda la
  configuración del sistema de forma declarativa, garantizando reproducibilidad
  y reversión completa de cambios. Este enfoque se alinea con el paradigma de
  *Infraestructura como código* ("IaC"), que concibe la infraestructura como un
  conjunto de definiciones versionables en lugar de configuraciones manuales
  @morris2016infrastructure. Aunque su curva de aprendizaje es más pronunciada,
  ofrece un control total sobre los servicios y dependencias, lo que lo
  convierte en una opción especialmente adecuada para entornos técnicos y
  proyectos de investigación.

==== Criterios de evaluación

Para comparar las distintas opciones se definieron los siguientes criterios:

- Reproducibilidad: posibilidad de replicar la configuración exacta del sistema
  en otro equipo o tras una reinstalación.
- Ligereza y eficiencia: consumo de recursos ajustado a las limitaciones del
  hardware disponible.
- Mantenibilidad: facilidad para aplicar actualizaciones, revertir cambios y
  mantener la estabilidad del entorno.
- Comunidad y soporte: disponibilidad de documentación, foros y paquetes
  actualizados.
- Compatibilidad con servicios self-hosted: existencia de paquetes o mecanismos
  simples para desplegar herramientas como Nextcloud, Vaultwarden o Logseq.
- Enfoque declarativo: capacidad para describir el estado del sistema de forma
  programática, coherente con los principios de IaC.

==== Elección del sistema operativo

Tras la evaluación, se seleccionó NixOS (versión ARM64) como sistema operativo
base del proyecto. A pesar de su mayor complejidad inicial, NixOS proporciona un
modelo declarativo y reproducible que se ajusta a los objetivos de estabilidad,
trazabilidad y mantenimiento del entorno.

Los principales motivos de esta elección son los siguientes:

- Permite definir todo el sistema (paquetes, servicios, usuarios, red y
  firewall) en un único archivo de configuración versionable.
- Facilita la replicación exacta del entorno en otras máquinas o la recuperación
  del sistema tras una reinstalación.
- Ofrece la posibilidad de realizar actualizaciones atómicas y reversibles, lo
  que reduce el riesgo de errores en despliegues o cambios de configuración.
- Su diseño se basa en los principios de la infraestructura como código, lo que
  permite tratar la infraestructura como parte del código del proyecto, con
  control de versiones, trazabilidad y documentación integrada.
- Mantiene un ecosistema activo, con soporte oficial para múltiples servicios
  self-hosted y una comunidad creciente que promueve la documentación abierta.

De esta manera, NixOS se consolida como la opción más coherente con la filosofía
del proyecto: un entorno autohospedado, reproducible y sostenible, en el que la
infraestructura se gestiona como código y evoluciona junto con el resto del
sistema.

=== NixOS: principios fundamentales

NixOS es una distribución de GNU/Linux diseñada en torno al gestor de paquetes
Nix, que introduce un enfoque declarativo e inmutable para la gestión del
sistema @dolstra2008nixos. A diferencia de las distribuciones tradicionales,
donde la configuración y los paquetes se instalan de manera imperativa, NixOS
utiliza descripciones formales del sistema en un único archivo
`/etc/nixos/configuration.nix` que actúa como fuente de verdad del estado
deseado.

NixOS se basa en tres principios esenciales:

+ *Gestión declarativa*: Todo el sistema, desde los paquetes instalados hasta
  los servicios y usuarios, se define mediante código declarativo. Esto permite
  reproducir exactamente un entorno en otro equipo o restaurarlo a un estado
  anterior.

+ *Aislamiento y consistencia de dependencias*: El gestor Nix instala cada
  paquete en un directorio único identificado por un hash de sus dependencias.
  Esto evita conflictos entre versiones de bibliotecas o programas, permitiendo
  incluso ejecutar múltiples versiones simultáneamente.

+ *Reproducibilidad y reversibilidad*: Cada cambio en la configuración genera
  una nueva generación del sistema, que puede revertirse fácilmente. De este
  modo, una actualización o modificación incorrecta no compromete la estabilidad
  general.

=== NixOS en la Raspberry Pi

El procedimiento seguido consistió en la generación de una imagen personalizada
para la Raspberry Pi 4, incluyendo la configuración inicial del sistema y la
clave pública SSH del usuario, de manera que el acceso remoto estuviera
disponible desde el primer arranque.

La compilación de la imagen se realizó desde una máquina con Windows 11 (x86_64)
utilizando NixOS bajo WSL @microsoft_wsl_install. Gracias al propio sistema de
compilación cruzada de Nix, fue posible generar una imagen compatible con la
arquitectura aarch64, correspondiente a la Raspberry Pi.

Para ello, se definió un archivo `flake.nix` con la siguiente estructura:

```nix
{
  description = "NixOS Raspberry Pi configuration flake";
  outputs = { self, nixpkgs, }: {
    nixosConfigurations = {
      rpi = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
          ./configuration.nix
        ];
      };
    };
  };
}
  outputs = { self, nixpkgs, }: {
    nixosConfigurations = {
      rpi = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
          ./configuration.nix
        ];
      };
    };
  };
}
```


Este flake declara una configuración de sistema denominada "rpi", basada en el
módulo oficial para la creación de imágenes SD para arquitecturas ARM 64.

==== Configuración del sistema

La configuración principal se definió en el archivo `configuration.nix`, que
establece la zona horaria, la localización, la creación del usuario principal y
la habilitación del servicio SSH:

```nix
{...}: {
  config = {
    # Time, keyboard language, etc
    time.timeZone = "Europe/Madrid";
    i18n.defaultLocale = "es_ES.UTF-8";

    # User
    users.users.pi = {
      isNormalUser = true;
      password = "<redacted_password>";
      extraGroups = [
        "wheel" # Enable 'sudo' for the user.
        "networkmanager"
      ];
      openssh.authorizedKeys.keys = [
        "<redacted_public_key>"
      ];
    };

    # Allow ssh in
    services.openssh.enable = true;

    networking = {
      hostName = "pi4";
      networkmanager.enable = true;
    };

    # This makes the build be a .img instead of a .img.zst
    sdImage.compressImage = false;

    system = {
      stateVersion = "25.05";
    };
  };
}
```

Esta configuración permite que, una vez iniciado el sistema, el usuario "pi"
pueda conectarse por SSH sin necesidad de teclado ni pantalla, asegurando desde
el principio la administración remota de la Raspberry Pi.

==== Generación de la imagen y despliegue

Con ambos archivos definidos, la imagen SD se generó mediante el siguiente
comando:

```sh
nix --experimental-features 'nix-command flakes' build -L ".#nixosConfigurations.rpi.config.system.build.sdImage"
```


El resultado fue un archivo `.img` que posteriormente se grabó en una tarjeta
microSD de 32 GB utilizando la herramienta Rufus #footnote("https://rufus.ie/").
Finalmente, la tarjeta se insertó en la Raspberry Pi junto con un cable Ethernet
para permitir la conexión inicial a la red local.

Gracias al enfoque declarativo y reproducible de NixOS, este proceso permite
regenerar la imagen de forma idéntica en el futuro o adaptarla fácilmente a
nuevas configuraciones de hardware, manteniendo la filosofía de IaC en futuras
etapas del proyecto.

==== Acceso remoto

Teniendo en cuenta que la Raspberry Pi es un dispositivo al que vamos a acceder
con frecuencia conviene asignarle una IP fija en la red local. Esto se puede
hacer desde la configuración del router, asignando una dirección IP estática a
la MAC de la Raspberry Pi. De este modo, siempre que se conecte a la red local
tendrá la misma IP y podremos acceder a ella sin problemas.

Con las herramientas de mi router (Movistar HGU) se puede hacer fácilmente desde
la sección de DHCP, donde se pueden ver los dispositivos conectados y asignarles
una IP fija. Como puede verse en la @figure:dhcp, he reservado la IP
`192.168.1.180` a la Raspberry Pi.


#figure(
  caption: [Configuración del DHCP en el router para asignar una IP fija a la
    Raspberry Pi],
  image("../../Figures/Chapter5/dhcp.png", width: 90%),
) <figure:dhcp>

=== Estrategia de despliegue de servicios

Una vez configurada la infraestructura base y verificado el correcto
funcionamiento del sistema operativo, se definió la estrategia de despliegue que
servirá de guía para la implementación de los servicios autoalojados en los
siguientes milestones.

El objetivo de esta estrategia es asegurar la reproducibilidad, portabilidad y
consistencia del entorno de ejecución, permitiendo que los servicios puedan
desplegarse de manera controlada y predecible en cualquier momento del ciclo de
vida del sistema.

==== Alternativas de despliegue

En el contexto de NixOS, existen principalmente dos enfoques posibles para el
despliegue de servicios:

- Despliegue nativo mediante NixOS: Consiste en definir cada servicio dentro de
  la configuración declarativa del sistema aprovechando las ventajas del modelo
  de IaC propio de Nix. Este enfoque ofrece una integración total con el sistema
  operativo y un alto grado de reproducibilidad, ya que todas las dependencias y
  servicios quedan descritos como parte del propio entorno. Sin embargo, esta
  opción puede presentar limitaciones a la hora de replicar el entorno en otros
  sistemas no basados en NixOS, y aumenta la complejidad cuando se desean
  desplegar servicios con configuraciones dinámicas o dependencias externas.

- Despliegue mediante contenedores [@cap:m1_contenedores]: Este enfoque
  encapsula cada servicio dentro de un contenedor independiente, gestionado por
  un motor compatible. Los contenedores aíslan completamente las dependencias y
  facilitan la portabilidad del entorno a otros sistemas operativos sin
  necesidad de replicar la configuración del host. Además, su uso está
  ampliamente extendido en entornos DevOps, lo que favorece la integración con
  prácticas de automatización, monitorización y despliegue continuo.

==== Contenedorización de servicios<cap:m1_contenedores>

La contenedorización es una técnica de aislamiento a nivel de sistema operativo
que permite ejecutar aplicaciones y servicios en entornos independientes, junto
con todas sus dependencias y configuraciones necesarias
@bentaleb2022containerization. A diferencia de la virtualización tradicional,
que requiere emular hardware y ejecutar múltiples sistemas operativos, los
contenedores comparten el mismo kernel del sistema anfitrión y se aíslan
mediante mecanismos nativos como _cgroups_, _namespaces_, _capabilities_ o
_seccomp_ @sultan2019containers.

Este modelo proporciona un entorno de ejecución coherente y reproducible, donde
cada contenedor incluye únicamente los componentes esenciales para la aplicación
que aloja. Como resultado, los contenedores se inician de forma casi
instantánea, consumen menos recursos que las máquinas virtuales y permiten
mantener una estricta separación entre servicios.

La contenedorización también facilita la portabilidad de las aplicaciones, ya
que un mismo contenedor puede ejecutarse de manera idéntica en diferentes
sistemas operativos o entornos, ya sea en servidores locales, máquinas virtuales
o infraestructuras en la nube; siempre que exista un motor compatible.

Además, existen soluciones de orquestación y gestión de múltiples contenedores,
que permiten describir y automatizar la puesta en marcha de conjuntos de
servicios mediante configuraciones declarativas. Gracias a estas
características, la contenedorización se ha convertido en un componente esencial
de las prácticas modernas de desarrollo, integración y despliegue continuo
@emmanni2023impact.

==== Justificación de la elección

Teniendo en cuenta los objetivos del proyecto y las características de la
infraestructura definida, se ha optado por utilizar un modelo de despliegue
basado en contenedores como método principal para la ejecución de los servicios
autoalojados.

La decisión responde a varios factores de carácter técnico, operativo y de
seguridad. En primer lugar, los contenedores proporcionan un entorno de
aislamiento ligero, que permite ejecutar múltiples servicios de forma
independiente sobre el mismo sistema base, evitando conflictos de dependencias o
configuraciones. Este aislamiento reduce la superficie de ataque, ya que cada
contenedor dispone de su propio espacio de usuario, red y sistema de archivos,
impidiendo que una vulnerabilidad en un servicio comprometa al resto del sistema
o a otros servicios en ejecución.

Además, los contenedores pueden ejecutarse siguiendo el principio de privilegios
mínimos ("least privilege") @schneider2004least, limitando el acceso al kernel y
a los recursos del host mediante mecanismos de seguridad del propio sistema
operativo. Esta separación a nivel de proceso permite aplicar políticas de
control de acceso más estrictas y coherentes con las buenas prácticas de
seguridad modernas.

Otro aspecto relevante es la gestión segura del ciclo de vida de los servicios.
El uso de contenedores facilita la aplicación de actualizaciones o la
sustitución completa de una instancia sin alterar la configuración del sistema
operativo subyacente. De este modo, en caso de detección de una vulnerabilidad,
puede desplegarse una nueva imagen corregida sin comprometer la estabilidad del
host ni la reproducibilidad del entorno.

Desde el punto de vista de la portabilidad y la reproducibilidad, tanto Nix como
la contenedorización persiguen objetivos similares, aunque desde niveles
distintos de abstracción. Nix garantiza que la infraestructura subyacente, es
decir, el sistema operativo, los paquetes y las configuraciones, pueda
reconstruirse de forma determinista en cualquier máquina compatible, asegurando
la coherencia del entorno base.

La contenedorización, por su parte, aplica estos principios al nivel de los
servicios, encapsulando cada aplicación junto con sus dependencias en una unidad
autocontenida. Esto permite desplegar el mismo servicio de manera idéntica en
diferentes sistemas, independientemente de la distribución o las versiones del
software instaladas.

En conjunto, ambos enfoques se complementan: Nix proporciona una base
reproducible y coherente para la infraestructura, mientras que los contenedores
añaden portabilidad, aislamiento en tiempo de ejecución y flexibilidad
operativa. Esta combinación reduce los riesgos asociados a configuraciones
divergentes y facilita la gestión segura y predecible de los servicios
autoalojados.

=== Evaluación y elección de la herramienta de gestión de contenedores

Una vez definida la estrategia de despliegue basada en contenedores, fue
necesario seleccionar la herramienta más adecuada para la gestión de los mismos
dentro del entorno NixOS. En el ecosistema actual existen diversas opciones
compatibles con las especificaciones del Open Container Initiative (OCI), que
garantizan la interoperabilidad de las imágenes y la portabilidad de los
servicios @oci_spec.

==== Criterios de selección

Para determinar la herramienta más apropiada se consideraron los siguientes
criterios:

- Integración con NixOS: facilidad de instalación y gestión mediante
  configuración declarativa.

- Seguridad y modelo de ejecución: soporte para ejecución sin privilegios de
  superusuario y aislamiento mediante mecanismos del kernel.

- Facilidad de uso y ecosistema: disponibilidad de herramientas auxiliares (CLI,
  orquestación local, documentación y soporte comunitario).

==== Comparativa de alternativas

- *Docker* #footnote("https://www.docker.com/"): es la herramienta más extendida
  y dispone de un ecosistema maduro y bien documentado. Sin embargo, su modelo
  tradicional requiere un demonio central ("dockerd") que se ejecuta con
  privilegios de superusuario, lo que introduce un riesgo adicional en términos
  de seguridad @docker_overview. Aunque existen implementaciones sin privilegios
  ("rootless"), su integración con NixOS resulta menos transparente y añade
  complejidad operativa.

- *Podman* #footnote("https://podman.io/"): ofrece alta compatibilidad con
  imágenes y comandos de Docker, pero utiliza una arquitectura sin servicio
  central en segundo plano ("daemonless"). En la práctica, esto significa que no
  hay un proceso con permisos de administrador gestionando todos los
  contenedores. Cada contenedor se ejecuta como proceso del propio usuario, lo
  que permite trabajar en sin privilegios de administrador y reduce el riesgo de
  que un fallo afecte a todo el sistema @redhat_podman.

==== Justificación de la elección

Considerando los criterios anteriores, se ha seleccionado Podman como
herramienta principal de contenedorización para el entorno self-hosted del
proyecto. Podman ofrece un equilibrio óptimo entre compatibilidad, seguridad y
simplicidad operativa, permitiendo gestionar contenedores sin necesidad de
privilegios de superusuario y manteniendo la compatibilidad con las imágenes y
flujos de trabajo de Docker. Su diseño modular y conforme a los estándares OCI
garantiza la portabilidad de los servicios y la interoperabilidad con otras
plataformas.

==== Instalación y configuración de Podman en NixOS

Para mantener un modelo de ejecución seguro y coherente con el principio de
privilegios mínimos, se ha optado por ejecutar los contenedores en modo
rootless, es decir, sin necesidad de privilegios de superusuario. En NixOS, esta
configuración se consigue de forma óptima mediante Home Manager, una extensión
del ecosistema Nix que permite gestionar la configuración del entorno de usuario
de manera declarativa y reproducible.

Home Manager facilita describir las aplicaciones, servicios y parámetros del
usuario dentro de su propio módulo de configuración, manteniendo la filosofía de
Infraestructura como Código también en el nivel del usuario. En este proyecto,
se ha integrado como módulo dentro del flake principal de NixOS, de modo que la
configuración del sistema y la del usuario se construyen conjuntamente:

```nix
{
  inputs.home-manager.url = "github:nix-community/home-manager";
  outputs = { self, nixpkgs, home-manager, ... }: {
    nixosConfigurations.rpi = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          # Configuración del usuario containers
          home-manager.users.containers = import ./home/containers;
        }
      ];
    };
  };
}
```


Además, se ha creado un usuario dedicado para la ejecución de contenedores,
denominado "containers", que no dispone de privilegios de administrador. Este
usuario está diseñado específicamente para alojar y gestionar los contenedores
rootless, reduciendo el impacto potencial de vulnerabilidades o configuraciones
erróneas. Su definición en `configuration.nix` es la siguiente:

```nix
users.users.containers = {
  isNormalUser = true;
  description = "Dedicated user for rootless Podman containers";
  home = "/home/containers";
  linger = true;
  createHome = true;
  subUidRanges = [
    {
      startUid = 100000;
      count = 65536;
    }
  ];
  subGidRanges = [
    {
      startGid = 100000;
      count = 65536;
    }
  ];
};
```


El parámetro `linger = true` es especialmente importante, ya que permite que los
servicios y contenedores asociados a este usuario continúen ejecutándose incluso
cuando no haya una sesión activa. Esto resulta esencial en un entorno
self-hosted, donde los servicios deben permanecer disponibles de forma continua
sin depender del inicio de sesión del usuario.

Por su parte, los atributos "subUidRanges" y "subGidRanges" definen los rangos
de identificadores subordinados asignados al usuario. Estos rangos permiten que
los contenedores rootless utilicen un espacio propio de identificadores de
usuario y grupo dentro del kernel, aislado del sistema anfitrión
@gentoo_subuid_subgid. Gracias a este mapeo, los procesos que se ejecutan como
administrador dentro del contenedor no poseen privilegios reales sobre el host,
lo que proporciona un nivel adicional de seguridad y evita interferencias entre
servicios.

La configuración de Podman se define mediante Home Manager en el archivo
`home/containers/default.nix`:

```nix
{ config, pkgs, ... }:

{
  services.podman = {
    enable = true;
    autoUpdate = {
      enable = true;
      # Ejecuta el auto-update diariamente a medianoche
      onCalendar = "*-*-* 00:00:00";
    };
  };
}
```

La opción `enable = true` activa Podman como servicio de usuario, lo que permite
lanzar y gestionar contenedores bajo el identificador del usuario sin requerir
permisos de administrador. De este modo, cada contenedor se ejecuta de forma
aislada y segura dentro del espacio de nombres del usuario, siguiendo el
principio de privilegios mínimos.

El bloque `autoUpdate` habilita el mecanismo automático de actualización de
contenedores. Este sistema crea una unidad y un temporizador de usuario (user
unit y user timer en systemd) @suse_systemd_timers que ejecutan el comando
`podman auto-update` de manera programada. En este caso, la opción
`onCalendar = "*-*-* 00:00:00"` establece que la actualización se ejecute
diariamente a medianoche.

=== Cierre del milestone

Con la instalación de NixOS, la configuración del usuario principal y la
habilitación del acceso remoto mediante clave SSH, se ha completado la
preparación del entorno base sobre el que se desarrollará el resto del proyecto.
La Raspberry Pi dispone ahora de un sistema operativo estable, reproducible y
gestionado de forma declarativa, capaz de reconstruirse íntegramente a partir de
su configuración.

La incorporación de una capa de contenedorización rootless mediante Podman,
gestionada a través de Home Manager, amplía las capacidades del sistema y
refuerza su reproducibilidad. Esta arquitectura permite desplegar servicios en
entornos aislados y portables, manteniendo la coherencia con la filosofía de
Infraestructura como Código y sin comprometer la seguridad del sistema base. El
uso de un usuario dedicado y sin privilegios para la ejecución de contenedores
garantiza el aislamiento de procesos y la persistencia de los servicios, incluso
en ausencia de sesiones activas.

De este modo, el sistema no solo se encuentra plenamente operativo, sino también
preparado para albergar servicios autoalojados complejos bajo un control total,
seguro y declarativo del entorno. Este milestone marca, por tanto, la transición
desde la fase de configuración de la infraestructura hacia la de implementación
de servicios, que se abordará en los siguientes hitos del proyecto.
