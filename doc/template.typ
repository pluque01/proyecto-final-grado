//LTeX: enabled=false
#import "requirements.typ": *
#let traducir_mes = fecha => {
  // Month translation dictionary
  let meses = (
    "January": "enero",
    "February": "febrero",
    "March": "marzo",
    "April": "abril",
    "May": "mayo",
    "June": "junio",
    "July": "julio",
    "August": "agosto",
    "September": "septiembre",
    "October": "octubre",
    "November": "noviembre",
    "December": "diciembre",
  )

  // Replace month in english for the translation
  let fecha_traducida = fecha
  for llave in meses.keys() {
    if fecha.contains(llave) {
      fecha_traducida = fecha_traducida.replace(llave, meses.at(llave))
    }
  }
  fecha_traducida
}

// Variable definition
#let serif-font = ("Charis SIL", "Charter")
#let sans-font = ("Open Sans", "Noto Sans")
#let ugr-color = rgb(233, 44, 48)
#let default-color = black
#let reference-color = black

// Project definition
#let project(
  title: "",
  subtitle: "",
  authors: (),
  directors: (),
  city: "",
  grado: "",
  date: none,
  abstract: none,
  bibliography-file: none,
  inside-margin: 4cm, // Inner margin (binding side)
  outside-margin: 3cm, // Outer margin
  y-margin: 5cm,
  body,
) = {
  // Set the document's basic properties.
  set document(author: authors, title: title)
  // Disable numbering by default, numbering will be set on footer manually
  set page(numbering: none)

  // Define custom color for links
  show link: it => {
    text(fill: ugr-color, it)
  }

  // Define custom caption
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: image): set figure.caption(position: bottom)
  show figure.caption: it => context {
    set text(fill: default-color, weight: "bold")
    it.supplement + " "
    it.counter.display() + ": "
    set text(fill: black, weight: "regular")
    it.body
  }

  // Define custom color for references
  show ref: set text(fill: reference-color)

  // Define custom enum with format
  set enum(
    indent: 1em,
    full: true, // necessary to receive all numbers at once, so we can know which level we are at
    numbering: (..nums) => {
      let nums = nums.pos() // just positional args
      let num = nums.last() // just the current level’s number
      let level = nums.len() // level is the amount of numbers available

      // format for current level (or stop at i. If going too deep)
      let format = ("1.", "[a]", "i.").at(calc.min(2, level - 1))
      let result = numbering(format, num) // formatted number
      text(fill: default-color, weight: "bold", result)
    },
  )
  show enum: it => {
    // Necessary to not accumulate indentation
    set enum(indent: 0em)
    it
  }

  // Define custom list
  set list(
    indent: 1em,
    marker: (
      text(fill: default-color)[■],
      text(fill: default-color)[□],
      text(fill: default-color)[◦],
    ),
  )
  show list: it => {
    // Necessary to not accumulate indentation
    set list(indent: 0em)
    it
  }

  // Set body font family.
  set text(font: sans-font, lang: "es")

  // Adjust heading settings
  show heading: set text(font: serif-font, fill: default-color)
  show heading: set block(below: 16pt) // Bottom margin
  show heading.where(level: 1): it => {
    set text(size: 24pt, weight: "regular")
    pagebreak(to: "even", weak: true)
    stack(
      spacing: 20pt,
      if not regex("(Índice.*)|(Bibliografía)") in it.body.fields().text {
        let title-content = text(size: 16pt, weight: "regular", "Capítulo ")
        let title-number = text(size: 64pt, weight: "light", str(counter(heading).get().first()))
        let title-height = measure(title-content).height
        let padding = 1em

        // Create a container with relative positioning
        block(
          width: 100%,
          inset: (top: title-height / 2),
          {
            // Draw the box
            box(
              width: 100%,
              height: title-height + padding,
              stroke: 1pt,
              radius: 0pt,
              fill: none,
            )
            // Place the heading on top, centered horizontally
            place(
              bottom + left,
              dy: title-height / 2,
              stack(
                dir: ltr,
                block(
                  fill: white,
                  outset: (x: 0.5em),
                  title-content,
                ),
                block(
                  fill: white,
                  title-number,
                ),
              ),
            )
          },
        )
        v(16pt)
      },
      it.body,
    )
    v(24pt)
  }
  show heading.where(level: 2): it => {
    set text(size: 20pt, weight: "regular")
    it
  }
  show heading.where(level: 3): it => {
    set text(size: 16pt, weight: "regular")
    it
  }
  set heading(numbering: "1.")

  // Codly startup
  show: codly-init.with()
  codly(languages: codly-languages)

  // Title page.
  set page(margin: 4cm)
  v(0.6fr)
  grid(
    columns: 1fr, rows: auto, align: horizon, column-gutter: 16pt,
    gutter: 40pt,
    image(
      "Figures/Template/ugr2.png",
      width: 100%,
    ),
    grid.cell(
      block(
        width: 100%,
        stack(
          spacing: 12pt,
          align(
            center,
            par(
              leading: 0.3em,
              text(font: serif-font, 16pt, weight: 300, "TRABAJO FIN DE GRADO"),
            ),
          ),
          align(
            center,
            par(
              leading: 0.3em,
              text(font: serif-font, 14pt, weight: 300, smallcaps(grado)),
            ),
          ),
        ),
      ),
    ),
    grid.cell(
      block(
        width: 100%,
        stack(
          spacing: 16pt,
          // Título
          align(
            center,
            par(leading: 0.3em, text(font: serif-font, 18pt, weight: 700, title)),
          ),
          line(length: 100%, stroke: 2pt),
          // Texto adicional
          if subtitle != "" {
            align(
              center,
              par(
                leading: 0.3em,
                text(font: serif-font, 14pt, weight: 500, subtitle),
              ),
            )
          },
        ),
      ),
    ),
  )
  v(2fr)
  // Author information.
  align(
    center,
    table(columns: auto, align: center, stroke: none, if authors.len() > 1 {
        table.header(strong("Autores"))
      } else {
        table.header(strong("Autor"))
      }, ..authors.map(author => author)),
  )
  align(
    center,
    table(columns: auto, align: center, stroke: none, if authors.len() > 1 {
        table.header(strong("Directores"))
      } else {
        table.header(strong("Director"))
      }, ..directors.map(director => director)),
  )
  v(9.6fr)
  align(
    center,
    image("Figures/Template/etsiit_logo.png"),
  )
  align(
    center,
    par(
      leading: 0.75em,
      text(
        font: serif-font,
        14pt,
        "Escuela Técnica Superior de Ingenierías Informática y de Telecomunicación",
      ),
    ),
  )
  v(1.2em)
  // -------------------------------------------------------------
  // Date on front page
  if date != none {
    text(1.1em, date)
  } else {
    align(
      center,
      text(
        14pt,
        font: serif-font,
        city + ", " + traducir_mes(datetime.today().display("[day] de [month repr:long] de [year]")),
      ),
    )
  }
  // -------------------------------------------------------------

  v(1.2em, weak: true)
  pagebreak()


  let hydra-context = (
    book: true,
  )
  set page(
    margin: (inside: inside-margin, outside: outside-margin, y: y-margin),
    // Hydra header definition
    header: context {
      if calc.odd(here().page()) {
        align(right, emph(hydra(2)))
        line(length: 100%)
      } else {
        align(left, emph(hydra(1)))
        let headings = query(heading.where(level: 1))
        if headings.find(h => h.location().page() == here().page()) == none {
          line(length: 100%)
        }
      }
    },
  )

  // Custom numbering for figures (<section><fig_number>)
  set figure(numbering: (..num) => numbering("1.1", counter(heading).get().first(), num.pos().first()))
  show heading.where(level: 1): it => {
    counter(math.equation).update(0)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)
    it
  }
  // -------------------------------------------------------------

  // -------------------------------------------------------------
  // Custom outline for figures
  let colon-entry(it) = {
    link(
      it.element.location(),
      text(fill: black, it.indented([#it.prefix().children.at(2).], it.inner())),
    )
  }
  show outline: out => {
    //if calc.even(here().page()) {
    //  pagebreak()
    //}
    show outline.entry: it => if out.target == selector(heading) { it } else { colon-entry(it) }
    out
  }
  // -------------------------------------------------------------

  // -------------------------------------------------------------
  // Page numbering
  counter(page).update(2)
  // Page footer definition
  set page(
    footer: context [
      // #line(length: 100%, stroke: 0.5pt + black)
      #set align(right)
      #counter(page).display("1")
    ],
  )
  // -------------------------------------------------------------


  // Table of contents settings
  show outline.entry.where(level: 1): it => {
    v(16pt, weak: true)
    strong(it)
  }
  outline(depth: 3, indent: auto)
  outline(title: "Índice de figuras", target: figure.where(kind: image))
  outline(title: "Índice de tablas", target: figure.where(kind: table))

  set par(justify: true)

  body
}

#let lt(overwrite: false, seperate-sections-level: 3) = {
  if not sys.inputs.at("spellcheck", default: overwrite) {
    return doc => doc
  }
  return doc => {
    show math.equation.where(block: false): it => [0]
    show math.equation.where(block: true): it => []
    show bibliography: it => []
    set par(justify: false, leading: 0.65em, hanging-indent: 0pt)
    set page(height: auto)
    show raw: set text(lang: "es", region: "ES")
    show raw.where(block: false): it => [0]
    show raw.where(block: true): it => []
    show block: it => it.body
    show page: set page(numbering: none)
    show heading: it => if it.level <= seperate-sections-level {
      pagebreak() + it
    } else {
      it
    }
    show footnote: it => [0]
    set footnote.entry(separator: none)
    show text.where(weight: "bold")
      .or(text.where(weight: "italic"))
      .or(text.where(weight: "black"))
      .or(text.where(weight: "semibold")): it => text(weight: "regular", it)
    show strong: it => it.body
    show emph: it => it.body
    doc 
  }
}
//LTeX: enabled=true
