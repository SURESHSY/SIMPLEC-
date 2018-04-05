yacc -d cpp.y
lex cpp.l
gcc -w y.tab.c -ll -ly
./a.out < a.cpp

