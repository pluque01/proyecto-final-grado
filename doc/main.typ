#import "template.typ": *

// use styling for spellcheck only in the spellchecker
// keep the correct styling in pdf or preview
// should be called after the template
#show: lt(overwrite: false)

#show: project.with(
  title: "Infraestructura colaborativa autoalojada y reproducible",
  subtitle: "Aplicación de principios IaC para el despliegue y mantenimiento de servicios locales",
  authors: (
    "Pablo Luque Salguero",
  ),
  directors: (
    "Juan Julián Merelo Guervos": (
      gender: "male",
      department: "Arquitectura y Tecnología de Computadores",
      university: "Universidad de Granada",
    ),
  ),
  city: "Granada",
  grado: "Grado en Ingeniería Informática",
  abstract: "El trabajo desarrolla un sistema de servicios colaborativos autoalojado y reproducible, siguiendo principios de Infrastructure as Code. A través de una configuración declarativa se integran almacenamiento, gestión de contraseñas y documentación compartida en un entorno seguro y sostenible. El proyecto demuestra que es posible mantener una infraestructura completa bajo control propio, reduciendo la dependencia de plataformas externas y facilitando su despliegue y mantenimiento.",
  abstract-en: "This project develops a self-hosted and reproducible system of collaborative services, following Infrastructure as Code principles. Through a declarative configuration, it integrates storage, password management, and shared documentation within a secure and sustainable environment. The work demonstrates that a complete infrastructure can be maintained under full user control, reducing dependence on external platforms and simplifying deployment and maintenance.",
  keywords: "infraestructura como código, autoalojado, reproducibilidad, NixOS, automatización, servicios colaborativos, administración de sistemas",
  keywords-en: "infrastructure as code, self-hosting, reproducibility, NixOS, automation, collaborative services, systems administration",
  acknowledgements: "A mi familia y amigos por su apoyo durante la realización de este trabajo, y al tutor por su orientación y seguimiento a lo largo del proyecto.",
)

#include "Chapters/1.introduccion.typ"
#include "Chapters/2.estado_arte.typ"
#include "Chapters/3.metodologia.typ"
#include "Chapters/4.planificación.typ"
#include "Chapters/5_implementacion/5.implementacion.typ"
#include "Chapters/6.validacion.typ"
#include "Chapters/7.costes.typ"
#include "Chapters/8.conclusiones.typ"


#bibliography("references.bib")
