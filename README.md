# NixOS Raspberry Pi Configuration

Configuración de NixOS para Raspberry Pi 4 con contenedores Podman, monitoring con Prometheus/Grafana, y servicios autoalojados.

## Documentación

La documentación se ha realizado con _Typst (0.13.0)_, por lo que es necesario instalarlo para generar el fichero PDF. Las instrucciones para la instalación se pueden encontrar en el [repositorio oficial](https://github.com/typst/typst?tab=readme-ov-file#installation).

Una vez instalado Typst, se puede clonar el repositorio e ir a la carpeta donde se encuentra la documentación:
```sh
git clone https://github.com/pluque01/proyecto-final-grado.git && cd proyecto-final-grado/doc
```

Para generar el fichero PDF:
```sh
typst compile main.typ memoria.pdf
```

## Requisitos Previos

- Raspberry Pi 4
- Tarjeta microSD (mínimo 16GB)
- Cuenta de [DuckDNS](https://www.duckdns.org/) configurada
- Cuenta de [Tailscale](https://tailscale.com/) y una clave de autenticación (auth key)

## Arquitectura

Este proyecto incluye:

- **Sistema Base**: NixOS con Flakes habilitado
- **Contenedores**: Podman rootless con servicios contenedorizados 
  - Traefik (reverse proxy con HTTPS automático)
  - Nextcloud (plataforma de nube personal)
  - Podman Exporter (métricas de contenedores)
- **Monitoring**:
  - Prometheus (recolección de métricas)
  - Grafana (visualización)
- **Redes**: Tailscale para VPN privada
- **Gestión de Secretos**: SOPS-nix

## Despliegue Inicial

El proceso de despliegue consta de dos fases principales:
1. **Instalar NixOS en la Raspberry Pi**
2. **Configurar el sistema**

## Paso 1: Instalar NixOS en la Raspberry Pi

Elige una de las siguientes opciones según tus preferencias:

### Opción A: Generar Imagen SD Personalizada (Si tienes un sistema con NixOS)

Esta opción te permite crear una imagen SD lista para usar desde cualquier sistema con NixOS.

#### Generar la Imagen

> Si tu máquina no tiene arquitectura ARM, deberás añadir lo siguiente a tu configuración de NixOS:
> ```nix
> boot.binfmt.emulatedSystems = ["aarch64-linux"];
> ```

En tu máquina NixOS:

```bash
# Clonar el repositorio
git clone https://github.com/pluque01/proyecto-final-grado.git rpi4nix
cd rpi4nix

# Generar la imagen SD
nix --experimental-features 'nix-command flakes' build -L ".#nixosConfigurations.rpi4SD.config.system.build.sdImage"
```

La imagen se generará en `./result/sd-image/`. El proceso puede tardar un tiempo considerable la primera vez.

#### Flashear la Imagen

```bash
# Identifica tu tarjeta SD (por ejemplo, /dev/sdX)
lsblk

# Flashea la imagen (CUIDADO: esto borrará todos los datos en la tarjeta)
sudo dd if=./result/sd-image/*.img of=/dev/sdX bs=4M status=progress conv=fsync

# Sincroniza y expulsa la tarjeta
sync
sudo eject /dev/sdX
```

#### Arrancar la Raspberry Pi

1. Inserta la tarjeta SD en tu Raspberry Pi 4
2. Conecta el Pi a la red (cable ethernet) y a la alimentación
3. Espera a que arranque (puede tardar unos minutos la primera vez)
4. Conéctate por SSH usando las credenciales definidas en `sd-configuration.nix`

### Opción B: Instalación Oficial de NixOS

Si prefieres seguir el proceso de instalación estándar de NixOS:

1. Descarga la imagen oficial de NixOS para Raspberry Pi desde [nixos.org](https://nixos.org/download#nixos-iso)
2. Flashea la imagen a una tarjeta SD usando el método anterior o una herramienta como [Rufus](https://rufus.ie/)
3. Arranca la Raspberry Pi y sigue la [guía oficial de instalación](https://nixos.org/manual/nixos/stable/#sec-installation)

## Paso 2: Configurar el Sistema

Una vez que tengas NixOS funcionando en tu Raspberry Pi (independientemente de la opción elegida), sigue estos pasos:

### 1. Clonar el Repositorio

Conéctate a tu Raspberry Pi por SSH y clona la configuración:

```bash
git clone https://github.com/pluque01/proyecto-final-grado.git /home/pi/rpi4nix
cd /home/pi/rpi4nix
# Elimina la documentación y el historial git para crear tu propio repositorio
rm -r doc .git
git init .
```

### 2. Configurar SOPS

#### Instalar SOPS

```bash
nix-shell -p sops age
```

#### Generar tus claves

```bash
# Generar clave age
age-keygen -o ~/.config/sops/age/keys.txt

# Ver tu clave pública
age-keygen -y ~/.config/sops/age/keys.txt
```

#### Configurar `.sops.yaml`

El archivo `.sops.yaml` debe contener tu clave pública. Ejemplo:

```yaml
keys:
  - &admin_pi TU_CLAVE_PUBLICA_AGE
creation_rules:
  - path_regex: secrets.yaml$
    key_groups:
    - age:
      - *admin_pi
```

#### Editar secretos

```bash
sops secrets.yaml
```

Debes configurar los siguientes secretos:

```yaml
tailscale_key: "tskey-auth-xxxxx"
duckdns_token: "tu-token-duckdns"
nextcloud:
  mysql_password: "password-seguro"
  mysql_root_password: "password-seguro"
  admin_password: "password-admin-nextcloud"
```

### 3. Personalizar la Configuración

#### Actualizar variables globales

Edita `flake.nix` y actualiza las variables en `globals`:

```nix
globals = {
  containerUser = "containers";
  dataFolder = "/mnt/data";  # Ajusta según tu montaje
  hostname = "tu-dominio.duckdns.org";  # Tu dominio DuckDNS
  letsEncryptEmail = "tu-email@ejemplo.com";
  mkServiceHost = service: "${service}.${globals.hostname}";
};
```

#### Verificar hardware-configuration.nix

Asegúrate de que `hardware-configuration.nix` refleje tu configuración de hardware (disco, particiones, etc.).

Para generar este archivo automáticamente, puedes usar:

```bash
sudo nixos-generate-config --show-hardware-config > /home/pi/rpi4nix/hardware-configuration.nix
```

### 4. Construir y Aplicar la Configuración

Ahora aplica la configuración completa al sistema:

```bash
# Primera vez: construir sin aplicar (opcional, para verificar)
sudo nixos-rebuild build --flake .#rpi4

# Aplicar la configuración
sudo nixos-rebuild switch --flake .#rpi4
```

Este proceso:
- Descargará e instalará todos los paquetes necesarios
- Configurará los servicios del sistema
- Configurará los contenedores Podman
- Activará Tailscale, Prometheus, Grafana, etc.

El proceso puede tardar bastante tiempo la primera vez, especialmente en Raspberry Pi.

### 5. Verificar los Servicios

#### Verificar contenedores

```bash
# Listar contenedores en ejecución (desde el usuario containers)
podman ps

# Ver logs de un contenedor
podman logs <nombre-contenedor>
```

#### Verificar servicios del sistema

```bash
# Estado de Tailscale
sudo systemctl --user --machine=containers@ status tailscale

# Estado de Prometheus
sudo systemctl --user --machine=containers@ status prometheus

# Estado de Grafana
sudo systemctl --user --machine=containers@ status grafana
```

## Actualizaciones

### Actualizar el Sistema

```bash
cd /home/pi/rpi4nix

# Actualizar flake.lock
nix flake update

# Aplicar actualizaciones
sudo nixos-rebuild switch --flake .#rpi4
```

### Aplicar Cambios de Configuración

```bash
cd /home/pi/rpi4nix

# Edita los archivos de configuración según necesites
# Luego aplica los cambios:

sudo nixos-rebuild switch --flake .#rpi4
```

### Rollback en Caso de Problemas

```bash
# Listar generaciones disponibles
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

# Volver a una generación anterior
sudo nixos-rebuild switch --rollback
```

## Acceso a los Servicios

Una vez desplegado, los servicios estarán disponibles en:

- **Nextcloud**: `https://nextcloud.tu-dominio.duckdns.org`
- **Grafana**: `https://grafana.tu-dominio.duckdns.org`

Las credenciales por defecto:
- **Nextcloud**: Usuario `admin`, contraseña según `nextcloud/admin_password` en secrets.yaml
- **Grafana**: Usuario `admin`, contraseña por defecto (cambia en primer acceso)

## Recursos Adicionales

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [NixOS & Flakes Book](https://nixos-and-flakes.thiscute.world/)
- [Podman Documentation](https://docs.podman.io/)
- [SOPS Documentation](https://github.com/Mic92/sops-nix)
- [Traefik Documentation](https://doc.traefik.io/traefik/)


## Licencia

Este proyecto está bajo licencia MIT.