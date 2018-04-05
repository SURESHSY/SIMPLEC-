%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>

#include "lex.yy.c"
//void yyerror(const char*);
void codegen();
void push(char *);
void codegen_assign();
//void codegen_umin();
void label1();
void label2();
void label3();
char st[100][10];
int top=0;
char i_[2]="0";
char temp[2]="t";
%}
//%name parse
%error-verbose
%start Program
%token IF TYPE RELOP LOGOP UOP OPENCURL CLOSECURL SEMIC OPENPAR CLOSEPAR ELSE ARIMOP MAIN 
%token WHILE FOR CONTINUE BREAK RETURN COMMA EQUALS U_OP ID NUM COUT CIN ENDL COUTOP CINOP COUTSTR
%token PLUS MINUS MUL DIV AND OR LT LTEQ GT GTEQ EQ NEQ
%token PE ME MULE DIVE PP MM INT CHAR DOUBLE FLOAT VOID
%%
Program: INT MAIN OPENPAR CLOSEPAR compound_stmt	{print_struct();printf("successful");}
       ;
compound_stmt: OPENCURL Decl Stmt CLOSECURL 
	     | OPENCURL Stmt CLOSECURL 
	     | OPENCURL Decl CLOSECURL
	     ;
Stmt: AssignExpr Stmt 
    | compound_stmt Stmt  
    | selection_stmt Stmt 
    | iteration_stmt Stmt
    | cout_stmt Stmt
    | cin_stmt Stmt
    | jump_stmt	Stmt
    | E SEMIC Stmt
    |
    ;
selection_stmt: IF OPENPAR cond CLOSEPAR compound_stmt 
	      | IF OPENPAR cond CLOSEPAR compound_stmt ELSE compound_stmt
	      ;
iteration_stmt: WHILE OPENPAR {label1();} cond {label2();} CLOSEPAR compound_stmt {label3();}
              ;
jump_stmt: CONTINUE SEMIC 
	 | BREAK SEMIC 
	 | RETURN E SEMIC	
	 ;
cond: expr 
    | expr logOp expr
    ;
expr:relexp 
    | logexp								
    ;		
relexp: E relOp E   {codegen();}
      ;
logexp: E logOp E   {codegen();}
      ;
logOp: AND
	|OR
     ;
relOp:LT      {push("<");}
	|GT     {push(">");}
	|LTEQ   {push("<=");}
	|GTEQ	  {push(">=");}
	|NEQ    {push("!=");}
	|EQ     {push("==");}
      ;
Decl: Type VarList SEMIC
    | Type AssignExpr
    |Arr
    ;
Arr :Type ID '['NUM']' SEMIC
    |Type ID '['']' SEMIC
    |Type ID '['NUM']' COMMA VarList SEMIC
    |Type ID '['']' COMMA VarList SEMIC
    |ID '['NUM']'
    |ID '['']' 
    ;
Type: INT
    |CHAR
    |DOUBLE
    |FLOAT
    |VOID
    ;
VarList: VarList COMMA ID
	 |VarList COMMA Arr
       | ID
       |Arr
       ;
AssignExpr:ID EQUALS {push("=");} E {codegen_assign();} SEMIC
	  ;
E: E PLUS {push("+");} T {codegen();} 
 |E MINUS {push("-");} T  {codegen();}
 |T
 ;
T: T MUL {push("*");} F  {codegen();}
 | T DIV {push("/");} F  {codegen();}
 | F
 ;
F: ID  {push(id);}
 | NUM {push(num);}
 | OPENPAR E CLOSEPAR 
 | UnaryExpr 
 | Unary_operation
 ;
Unary_operation: ID u_op ID 
	       | ID u_op NUM 
               | ID u_op OPENPAR E CLOSEPAR
	       ;
u_op: PE 
    |ME
    |MULE
    |DIVE
    ;
UnaryExpr: PP ID    {push("=");push(id);push("+");push("1");codegen();codegen_assign();}
         | ID PP    {push("=");push(id);push("+");push("1");codegen();codegen_assign();}
         | MM ID    {push("=");push(id);push("-");push("1");codegen();codegen_assign();}
         | ID MM    {push("=");push(id);push("-");push("1");codegen();codegen_assign();}
	   ;
cout_stmt:COUT COUTOP COUTSTR COUTOP ENDL SEMIC
	   |COUT COUTOP ID SEMIC
	   |COUT COUTOP COUTSTR SEMIC
         ;
cin_stmt:CIN CINOP ID SEMIC
        |CIN CINOP ID CINOP ID SEMIC
        ;
%%
int main(void){
	printf("Enter the input:");
	return (yyparse());
}
void yyerror(char* s){
	fprintf(stderr,"%s\n",s);
	
}
int yywrap(){
	return 1;
}

void push(char *v)
{
	strcpy(st[++top],v);
}
void codegen()
{
	strcpy(temp,"t");
	strcat(temp,i_);
	printf("%s = %s %s %s\n",temp,st[top-2],st[top-1],st[top]);
	top-=2;
	strcpy(st[top],temp);
	i_[0]++;
}

void codegen_assign()
{
printf("%s %s %s\n",st[top-2],st[top-1],st[top]);
top-=2;
}

void label1()
{
printf("L%d: \n",lnum);
}


void label2()
{
 strcpy(temp,"t");
 strcat(temp,i_);
 printf("%s = not %s\n",temp,st[top]);
 printf("if %s  goto L%d\n",temp,lnum+1);
 i_[0]++;
 }

void label3()
{
printf("goto L%d \n",lnum);
printf("L%d: \n",lnum);
}

