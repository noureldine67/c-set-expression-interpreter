%option noyywrap
%{
#include <stdlib.h>
#include "tp2.tab.h"
%}

ELEMENTS_VALIDES [1-9]|1[0-9]|2[0-9]|3[0-2]

%%

[a-zA-Z] { yylval = yytext[0]; return IDENT; }
[{},] { return yytext[0]; }
":="  { return ASSIGNER; }
"DIFF" { return DIFF; }
"diff" { return DIFF_MINUSCULE; }
"COMP" { return COMP; }
"comp" { return COMP_MINUSCULE; }
"INTER" { return INTER; }
"inter" { return INTER_MINUSCULE; }
"UNION" { return UNION; }
"union" { return UNION_MINUSCULE; }
"\n"  { return yytext[0]; }
{ELEMENTS_VALIDES} { yylval = atoi(yytext); return ELEMENT; }
[ \t]+ { ; }

%%
