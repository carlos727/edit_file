default["file"]["path"] = 'C:\Eva\Files\plantilla.txt'

default["search"]["pattern"] = /{{Pie.MensajeResolucion}}/
default["replace"]["text"] = <<-RPL
Tipo C=100% aplica INC $20 + IVA 19%
{{#newline}}
{{#newline}}
{{Pie.MensajeResolucion}}
RPL

default["mail"]["to"] = 'cbeleno@redsis.com'
