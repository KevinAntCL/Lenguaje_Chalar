%{                                                                                          
#include "simple.tab.h"                                                                     
extern int line_number;                                                                     
%}                                                                                          


%option noyywrap                                                                            
 
%%                                                                                          
"Float"	{ return TFLOAT; }                  
"Int"	{ return TINT; }
"SingleChar"	{ return TCHAR; }
"Double"	{ return TDOUBLE; }
"String"	{ return TSTRING; }
"DateType"	{ return TDATE; }                       
";" {  return TSEMICOLON; }
":" {  return TCOLON; }  
"<" {  return TLESS_THAN; }
">" {  return TMORE_THAN; }
"==" {  return TEQUAL_AS; }
"!=" {  return TNOT_EQUAL; }
"+" {  return TSUM; }
"-" {  return TSUB; }
"*" {  return TMULTI; }
"/" {  return TDIV; }
"=" { return TASIGNATION; }
"Code_Initialization" {  return TCODE_INIT; }
"Code_End" {  return TCODE_END; }
"Program_Name" {  return TPROGRAM_NAME; }
"Library_Section" {  return TLIB_SECTION; }  
"Library_Section_End" {  return TLIB_SECTION_END; }    
"Variables_Section" {  return TVAR_SECTION; }  
"Variables_Section_End" {  return TVAR_SECTION_END; } 
"Main_Section" {  return TMAIN_SECTION; }   
"Main_Section_End" {  return TMAIN_SECTION_END; }   
"Import"  {  return TIMPORT_LIB; }   
"For" { return TFOR; }
"While" { return TWHILE; }
"If" { return TIF; }
"(" { return TOPEN_PAR; }
")" { return TCLOSE_PAR; }
"{" { return TOPEN_KEY; }
"}" { return TCLOSE_KEY; }                                                       
[_a-zA-Z][_a-zA-Z0-9]*	{
				yylval.sval = malloc(strlen(yytext));
			strncpy(yylval.sval, yytext, strlen(yytext));
						  return TIDENTIFIER; } 
[ \t\r]+          /* eat up whitespace */                                                   
[\n] { line_number++; }                                                                     
%%