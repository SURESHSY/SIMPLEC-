//#ifndef HSYMBOLTABLE
//#define HSYMBOLTABLE
#include<stdio.h>
#include <string.h>

char num[10];
char id[10];
int lnum;

int value=0;

struct st{  
int id;      
char name[10];
char val[10];
char num;
}; 

struct st table[100];

int search(char *s)
{
	for(int i=0;i<value;i++)
	{
		if(strcmp(s,table[i].name)==0)
			return 0;
	}
	return 1;
}



void addID(char *s)
{
	if(search(s)==1){
		table[value].id=value;
	 	strcpy(table[value].name,s);
	 	//strcpy(table[value++].val,s);
	 	/*if(search(id)==0){
	 	
	 	}*/
	 	value++;
	}
	else
	{
		//do nothing
	}
}

void print_struct()
{
	FILE *fp;
	fp=fopen("out.txt","w");
	for(int i=0;i<value;i++)
	{
		fprintf(fp,"%d\t%s\t%s\t\n",table[i].id,table[i].name,table[i].val);
	}
	//printf("%s=%s",id,num);
}

//#endif
