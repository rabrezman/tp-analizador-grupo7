%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
extern char *yytext;
extern int yyleng;
extern int yylex(void);
extern void yyerror(char*);
int validarLongitud(void);
int buscarIdentifDeclarado(void);
void agregarIdentificador(void);
char idtifDeclarados[30][32];
int i=0;
int error=0;
int existeIdentificador=0;

%}
%union{
   char* cadena;
   int num;
}

%token ASIGNACION PUNTOYCOMA COMA SUMA RESTA PARENTIZQUIERDO PARENTDERECHO FDT
%token <cadena> IDENTIFICADOR INICIO FIN LEER ESCRIBIR
%token <num> CONSTANTE

%%

objetivo: programa FDT
;
programa: INICIO sentencias FIN
;
sentencias: sentencias sentencia 
| sentencia
;
sentencia: identificador ASIGNACION expresion PUNTOYCOMA
| LEER PARENTIZQUIERDO identificadores PARENTDERECHO PUNTOYCOMA
| ESCRIBIR PARENTIZQUIERDO expresiones PARENTDERECHO PUNTOYCOMA
;
identificadores: identificador 
| identificadores COMA identificador
;
identificador: IDENTIFICADOR {error = validarLongitud(); if(error){return 0;} existeIdentificador = buscarIdentifDeclarado(); if(!existeIdentificador){agregarIdentificador();}}
;
expresiones: expresion 
| expresiones COMA expresion
;
expresion: primaria 
| expresion operadorAditivo primaria
;
primaria: IDENTIFICADOR {existeIdentificador = buscarIdentifDeclarado(); if(!existeIdentificador){yyerror("error semantico, no se encuentra el identificador declarado"); return 0;}}
| CONSTANTE 
| PARENTIZQUIERDO expresion PARENTDERECHO
;
operadorAditivo: SUMA 
| RESTA
;

%%

int main(){
   yyparse();
}
void yyerror(char* s){
   printf("Ocurrio: %s", s); 
}
int yywrap(){
   return 1;
}

int validarLongitud(void){
   if(yyleng > 32){
	yyerror("error semantico, el identificador no puede tener mas de 32 caracteres\n");
	return 1;	
   }
   return 0;
}

int buscarIdentifDeclarado(void){
   int idEncontrado = 0;
   for(int j=0;j<i;j++){
    	if(strcmp(idtifDeclarados[j], yytext)==0){
        	idEncontrado = 1;
    	}
   }
  return idEncontrado;
}

void agregarIdentificador(void){
   strcpy(idtifDeclarados[i], yytext);
   i++;
}