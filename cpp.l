id [a-zA-Z0-9]+
%{
#include<stdio.h>
#include<string.h>
#include "y.tab.h"
#include "symbol.h"
%}
alpha [a-zA-Z]
digit [0-9]
%%
\"({alpha}|{digit}|[ ])*\"    {return COUTSTR; }
[0-9]+				{strcpy(num,yytext);return NUM;}
"||"                           {return AND;}
"&&"			        {return OR;}

"<"                   {return LT;}
">"			    {return GT;}
"<="		          {return LTEQ;}
">="			    {return GTEQ;}
"!="                  {return NEQ;} 
"=="			    {return EQ;}

"+=" 				{return PE;}
"-="				{return ME;}
"*="				{return MULE;}
"/="				{return DIVE;}

">>"                    {return CINOP;}
"<<"                    {return COUTOP;}
if				{return IF;}
else				{return ELSE;}
cout                    {return COUT;}
cin                     {return CIN;}	
endl				{return ENDL;}

"+"      			{return PLUS;}
"-"				{return MINUS;}
"*"				{return MUL;}
"/"				{return DIV;}

main				{return MAIN;}
while				{return WHILE;}
"#include".+            ;
"#define".+             ;

continue			{return CONTINUE;}
break				{return BREAK;}
return				{return RETURN;}

","				{return COMMA;}
"="				{return EQUALS;}
"++"                    {return PP;}
"--"			{return MM;}


int 				{return INT;}
char 				{return CHAR;}
double 				{return DOUBLE;}
float 				{return FLOAT;}
void 				{return VOID;}


[a-zA-Z][a-zA-Z0-9]*			{strcpy(id,yytext);addID(yytext);return ID;}
"("				{return OPENPAR;}
")"				{return CLOSEPAR;}
"{"				{return OPENCURL;}
"}"				{return CLOSECURL;}
";"				{return SEMIC;}
\/\/.*                  ;	
\/\*(.*\n)*.*\*\/       ;
[" "|\t|\n]				;
.                               {return yytext[0];}
%%
