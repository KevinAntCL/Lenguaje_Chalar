/*  LENGUAJE:  CHALAR
	HECHO POR: KEVIN ANTONIO CHAVEZ LARA
	MATRICULA: 185380 */    

%{                                                                                   

   #include<stdio.h>
   #include <stdarg.h> 
   #include "simple_shared.h"                                                        


  void yyerror (char const *);
  int yylex();

  
   int yydebug=1;                                                                    
   int indent=0;                                                                     
                                                                    
%}     

%union
{
  char * sval;
  int ival;
};
                                                            
%token TFLOAT                                                                         
%token TINT
%token TCHAR
%token TDOUBLE
%token TSTRING 
%token TDATE                                                                        
%token <sval> TIDENTIFIER
%token TCODE_INIT
%token TPROGRAM_NAME
%token TLIB_SECTION
%token TLIB_SECTION_END
%token TIMPORT_LIB
%token TVAR_SECTION
%token TVAR_SECTION_END
%token TSEMICOLON
%token TCOLON
%token TSUM
%token TSUB
%token TMULTI
%token TDIV
%token TMAIN_SECTION
%token TMAIN_SECTION_END  
%token TASIGNATION     
%token TFOR
%token TWHILE
%token TIF
%token TLESS_THAN
%token TMORE_THAN
%token TEQUAL_AS
%token TNOT_EQUAL
%token TOPEN_PAR
%token TCLOSE_PAR           
%token TOPEN_KEY
%token TCLOSE_KEY
%token TCODE_END                                                  
 
%% /* Grammar rules and actions follow */      

CodeInit: TCODE_INIT TPROGRAM_NAME TIDENTIFIER TCOLON LibrarySection VariableSection MainSection TCODE_END TOPEN_PAR TCLOSE_PAR TSEMICOLON
		{ printf("Linea: %3d - Programa principal. \n", line_number);}
	;

LibrarySection : TLIB_SECTION TCOLON LibraryList TLIB_SECTION_END TOPEN_PAR TCLOSE_PAR TSEMICOLON
		{ printf("Linea: %3d - Seccion de librerias. \n", line_number);}
	;

LibraryList : OneLibrary
		{ printf("Linea: %3d - Una libreria. \n", line_number);}
		| OneLibrary LibraryList 
		{ printf("Linea: %3d - Una o mas librerias. \n", line_number);}
	;

OneLibrary : TIMPORT_LIB TLESS_THAN TIDENTIFIER TMORE_THAN TSEMICOLON  
		{ printf("Linea: %3d - Importacion de una libreria. \n", line_number);}
	;

VariableSection : TVAR_SECTION TCOLON DeclarationsList TVAR_SECTION_END TOPEN_PAR TCLOSE_PAR TSEMICOLON
		{ printf("Linea: %3d - Seccion de variables. \n", line_number);}
	;

MainSection : TMAIN_SECTION TCOLON SentenceList TMAIN_SECTION_END TOPEN_PAR TCLOSE_PAR TSEMICOLON
		{ printf("Linea: %3d - Seccion princial del codigo. \n", line_number);}
	;

SentenceList : OneSentence 
		{ printf("Linea: %3d - Una sentencia. \n", line_number);}
		| OneSentence SentenceList 
		{ printf("Linea: %3d - Una o mas sentencias. \n", line_number);}
	;

OneSentence : TIDENTIFIER TSEMICOLON
		{ printf("Linea: %3d - Identificacion de una sentencia. \n", line_number);}
		| TIDENTIFIER TASIGNATION TIDENTIFIER TSEMICOLON 
		{ printf("Linea: %3d - Asignacion de una variable. \n", line_number);}
		| TIDENTIFIER TASIGNATION TIDENTIFIER OperationList TIDENTIFIER TSEMICOLON 
		{ printf("Linea: %3d - Asignacion de una variable con una operacion. \n", line_number);}
		| TWHILE TOPEN_PAR TIDENTIFIER ConditionList TIDENTIFIER TCLOSE_PAR OneSentence 
		{ printf("Linea: %3d - Ciclo WHILE con condicional. \n", line_number);}
		| TIF TOPEN_PAR TIDENTIFIER ConditionList TIDENTIFIER TCLOSE_PAR OneSentence 
		{ printf("Linea: %3d - Estructura IF con condicional. \n", line_number);}
		| TFOR TOPEN_PAR TIDENTIFIER TSEMICOLON TIDENTIFIER TSEMICOLON TIDENTIFIER TCLOSE_PAR OneSentence 
		{ printf("Linea: %3d - Ciclo FOR. \n", line_number);}
		| TOPEN_KEY SentenceList TCLOSE_KEY TSEMICOLON { printf("Linea: %3d - Sentencia cerrada en llaves. \n", line_number);}
	;

DeclarationsList : OneDeclaration 
		{ printf("Linea: %3d - Una declaracion. \n", line_number);}
		| OneDeclaration DeclarationsList 
		{ printf("Linea: %3d - Una o mas declaraciones. \n", line_number);}
	;

OperationList : TSUM
		{ printf("Linea: %3d - Simbolo de suma. \n", line_number);}
		| TSUB
		{ printf("Linea: %3d - Simbolo de resta. \n", line_number);}
		| TMULTI
		{ printf("Linea: %3d - Simbolo de multiplicacion. \n", line_number);}
		| TDIV
		{ printf("Linea: %3d - Simbolo de division. \n", line_number);}

ConditionList : TLESS_THAN
		{ printf("Linea: %3d - Simbolo menor que. \n", line_number);}
		| TMORE_THAN
		{ printf("Linea: %3d - Simbolo mayor que. \n", line_number);}
		| TEQUAL_AS
		{ printf("Linea: %3d - Simbolo igual que. \n", line_number);}
		| TNOT_EQUAL
		{ printf("Linea: %3d - Simbolo diferente que. \n", line_number);}
                                      
OneDeclaration : TypeSpecifier IdentifierDum TSEMICOLON                                              
        { printf("Linea: %3d - Declaracion de tipo de dato. \n", line_number); }                   
	;
                                                                                    
TypeSpecifier : TFLOAT                                                                          
        { printf("Linea: %3d - Tipo de dato: flotante. \n", line_number);}                         
        | TINT 
		{ printf("Linea: %3d - Tipo de dato: entero. \n", line_number);}
		| TCHAR 
		{ printf("Linea: %3d - Tipo de dato: caracter. \n", line_number);}
		| TDOUBLE 
		{ printf("Linea: %3d - Tipo de dato: doble. \n", line_number);}
		| TSTRING 
		{ printf("Linea: %3d - Tipo de dato: string. \n", line_number);}  
		| TDATE 
		{ printf("Linea: %3d - Tipo de dato: fecha. \n", line_number);}                          
	;

IdentifierDum : TIDENTIFIER                                                                     
        { printf("Linea: %3d - Identificador: %s\n", line_number, $1);} 
	;                                                                                    
%%                                                                                   
 

 #include <stdio.h>
 void yyerror(char const *s)
 {
 fprintf(stderr,"%s\n",s);
 }


int main ()                                                                              
{                                                                                    
  yyparse ();                                                                        
}