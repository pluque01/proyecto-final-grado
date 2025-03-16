#import "template.typ": *

#show: project.with(
  title: "Placeholder title",
  subtitle: "Placeholder subtitle",
  authors: (
    "Pablo Luque Salguero",
  ),
  directors: (
    "Juan Julián Merelo Guervos",
  ),
  city: "Granada",
  grado: "Grado en Ingeniería Informática",
)

#include "Chapters/1.introduccion.typ"
#include "Chapters/2.estado_arte.typ"
#include "Chapters/3.metodologia.typ"
#include "Chapters/4.planificación.typ"
#include "Chapters/5.implementacion.typ"
#include "Chapters/6.costes.typ"
#include "Chapters/7.conclusiones.typ"


#bibliography("references.bib")
