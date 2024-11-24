%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
extern void yyerror(char*);
extern char *yytext;

%}

letra [a-zA-Z]
digito [0-9]
constante {digito}+
identificador {letra}({letra}|{digito})*

%%

" " { }
":=" {return (ASIGNACION);}
";" {return (PUNTOYCOMA);}
"," {return (COMA);}
"+" {return (SUMA);}
"-" {return (RESTA);}
"(" {return (PARENTIZQUIERDO);}
")" {return (PARENTDERECHO);}
inicio {return (INICIO);}
fin {return (FIN);}
leer {return (LEER);}
escribir {return (ESCRIBIR);}
{identificador} {return (IDENTIFICADOR);}
{constante} {return (CONSTANTE);}
"\n" { }
<<EOF>> {return (FDT);}
. {yyerror("ERROR LEXICO, el caracter utilizado no pertenece al lenguaje\n"); return 0;}

%%