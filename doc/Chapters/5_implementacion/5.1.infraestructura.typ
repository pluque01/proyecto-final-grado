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

=== Selección del hardware

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

==== Justificación de la elección

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

=== Selección del sistema operativo

Una vez definido el hardware, se procedió a evaluar las posibles opciones de
sistema operativo para la infraestructura self-hosted. El objetivo era disponer
de un entorno ligero, estable y reproducible, que facilitara la instalación de
servicios, el mantenimiento a largo plazo y la automatización de la
configuración.

==== Alternativas consideradas

Se analizaron distintas distribuciones de GNU/Linux con soporte para la
arquitectura ARM y orientadas al uso como servidor:

- *Raspberry Pi OS*: distribución oficial basada en Debian y optimizada para el
  hardware de la placa. Su principal ventaja es la compatibilidad inmediata con
  todos los controladores y la gran cantidad de documentación disponible. Sin
  embargo, su enfoque generalista y la configuración manual de paquetes
  dificultan la reproducibilidad exacta del entorno en otros equipos.

- *Ubuntu Server*: versión minimalista del sistema de Canonical, también
  disponible para ARM. Ofrece estabilidad y soporte LTS, junto con una amplia
  compatibilidad de software. Su desventaja radica en el mayor consumo de
  recursos y en la dependencia de herramientas tradicionales de gestión, menos
  adecuadas para un enfoque declarativo.

- *DietPi*: sistema extremadamente ligero orientado a entornos embebidos. Es
  fácil de instalar y ofrece scripts automatizados para servicios comunes, pero
  su ecosistema es más limitado y depende en gran medida de configuraciones
  predefinidas, reduciendo la flexibilidad y trazabilidad de los cambios.

- *NixOS*: distribución construida en torno al gestor de paquetes y sistema de
  configuración Nix. Permite definir toda la configuración del sistema de forma
  declarativa, garantizando reproducibilidad y reversión completa de cambios.
  Este enfoque se alinea con el paradigma de *Infraestructura como código*
  ("IaC"), que concibe la infraestructura como un conjunto de definiciones
  versionables en lugar de configuraciones manuales. Aunque su curva de
  aprendizaje es más pronunciada, ofrece un control total sobre los servicios y
  dependencias, lo que lo convierte en una opción especialmente adecuada para
  entornos técnicos y proyectos de investigación.

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
sistema. A diferencia de las distribuciones tradicionales, donde la
configuración y los paquetes se instalan de manera imperativa, NixOS utiliza
descripciones formales del sistema en un único archivo
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
utilizando NixOS bajo WSL. Gracias al propio sistema de compilación cruzada de
Nix, fue posible generar una imagen compatible con la arquitectura aarch64,
correspondiente a la Raspberry Pi.

Para ello, se definió un archivo flake.nix con la estructura siguiente:

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
nuevas configuraciones de hardware, manteniendo la filosofía de Infraestructura
como Código (IaC) en todas las etapas del proyecto.

==== Acceso remoto

Teniendo en cuenta que la Raspberry Pi es un dispositivo al que vamos a acceder
con frecuencia conviene asignarle una IP fija en la red local. Esto se puede
hacer desde la configuración del router, asignando una dirección IP estática a
la MAC de la Raspberry Pi. De este modo, siempre que se conecte a la red local
tendrá la misma IP y podremos acceder a ella sin problemas.

Con las herramientas de mi router (Movistar HGU) se puede hacer fácilmente desde
la sección de DHCP, donde se pueden ver los dispositivos conectados y asignarles
una IP fija. Como puede verse en la @figure:dhcp, he reservado la IP
192.168.1.180 a la Raspberry Pi.


#figure(
  caption: [Configuración del DHCP en el router para asignar una IP fija a la
    Raspberry Pi],
  image("../../Figures/Chapter5/dhcp.png", width: 90%),
) <figure:dhcp>

=== Cierre del milestone

Con la instalación de NixOS, la configuración del usuario principal y la
habilitación del acceso remoto mediante clave SSH, se ha completado la
preparación del entorno base. La Raspberry Pi dispone ahora de un sistema
operativo reproducible y accesible, que constituye el punto de partida para la
implementación de los servicios autoalojados en los siguientes milestones.
