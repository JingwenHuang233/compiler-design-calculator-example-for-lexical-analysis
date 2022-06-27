   /* cs152-calculator */
   
%{   
   /* write your C code here for defination of variables and including headers */
   int currLine = 1, currPos = 1;
   int numNumbers = 0, numOp = 0, numParens = 0, numEqual = 0;
%}


   /* some common rules, for example DIGIT */
DIGIT    [0-9]
   
%%
   /* specific lexer rules in regex */

"-"            {printf("MINUS\n"); currPos += yyleng; numOp++;}
"+"            {printf("PLUS\n"); currPos += yyleng; numOp++;}
"*"            {printf("MULT\n"); currPos += yyleng; numOp++;}
"/"            {printf("DIV\n"); currPos += yyleng; numOp++;}
"="            {printf("EQUAL\n"); numEqual++;}
"("            {printf("L_PAREN\n"); currPos += yyleng; numParens++;}
")"            {printf("R_PAREN\n"); currPos += yyleng; numParens++;}

(\.{DIGIT}+)|({DIGIT}+(\.{DIGIT}*)?([eE][+-]?[0-9]+)?)   {printf("NUMBER %s\n", yytext); currPos += yyleng; numNumbers++;}
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

   printf("# of Numbers: %d\n", numNumbers);
   printf("# of Operators: %d\n", numOp);
   printf("# of Parentheses: %d\n", numParens);
   printf("# of Equal Signs: %d\n", numEqual);
}

