   /* cs152-calculator */
   
%{   
   /* write your C code here for defination of variables and including headers */
   int currLine = 1, currPos = 1;
%}


   /* some common rules, for example DIGIT */
DIGIT    [0-9]
   
%%
   /* specific lexer rules in regex */

"-"            {printf("MINUS\n"); currPos += yyleng;}
"+"            {printf("PLUS\n"); currPos += yyleng;}
"*"            {printf("MULT\n"); currPos += yyleng;}
"/"            {printf("DIV\n"); currPos += yyleng;}
"="            {printf("EQUAL\n"); }
"("            {printf("L_PAREN\n"); currPos += yyleng;}
")"            {printf("R_PAREN\n"); currPos += yyleng;}
{DIGIT}+       {printf("NUMBER %s\n", yytext); currPos += yyleng;}
[ \t]+         {/* ignore spaces */ currPos += yyleng;}

"\n"           {currLine++; currPos = 1;}

.              {printf("Error at line %d, column %d: unrecognized symbol \"%s\"\n", currLine, currPos, yytext); exit(0);}

%%
	/* C functions used in lexer */

int main(int argc, char ** argv)
{
   if(argc >= 2)
   {
      yyin = fopen(argv[1], "r");
      if(yyin == NULL)
      {
         yyin = stdin;
      }
   }
   else
   {
      yyin = stdin;
   }
   yylex();
}

