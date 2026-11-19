// A3 Hochformat, tonersparend: weißer Grund, farbige Konturen, kaum Flächen. --input sw=1 = schwarz-weiß.
#import "plakat.typ": plakat
#set page(paper: "a3", margin: 0pt)
#plakat(sw: sys.inputs.at("sw", default: "0") == "1")
