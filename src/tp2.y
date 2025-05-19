%{
#include <stdio.h>
#include <assert.h>
#define TAILLE 26
extern int yylex();
extern void yylex_destroy();
extern FILE *yyin;
void yyerror(char *message);

// Tableau contenant les identifiants
int tableau_ensemble[TAILLE] = {0};

// Récupérer à bonne valeur à partir d'un identifiant
int indice_tableau(int ident) {
  if (ident >= 'a' && ident <= 'z') {
    return ident - 'a';
  }
  else {
    // Non "case-sensitive"
    return ident - 'A';
  }
}

// Afficher un entier sous forme d'ensemble
void afficher_ensemble(int e) {
    int premier = 1;  // Indicateur pour savoir s'il s'agit du premier élément
    printf("{ ");
    for (int i = 1; i <= 32; i++) {
        // Tester si ième bit est à 1
        if (e & (1 << (i - 1))) {
            if (!premier) {
                printf(", ");
            }
            printf("%d", i);
            premier = 0;
        }
    }
    printf("}\n");
}
%}


%token ELEMENT IDENT UNION INTER DIFF COMP UNION_MINUSCULE INTER_MINUSCULE DIFF_MINUSCULE COMP_MINUSCULE ASSIGNER
%start liste

%%

liste : %empty { ; }
      | liste instruction'\n' { ; }
      | '\n' { return 0; /* Pour quitter le programme */ }

instruction : IDENT ASSIGNER expression { tableau_ensemble[indice_tableau($1)] = $3; }
            | IDENT { afficher_ensemble(tableau_ensemble[indice_tableau($1)]); }

expression : operande { $$ = $1; }
           | operande operateur2 operande  {
            if ($2 == UNION) { $$ = $1 | $3; }
            else if ($2 == INTER) $$ = $1 & $3;
            else if ($2 == DIFF) $$ = $1 & ~($3);
           }
           | operateur1 operande { $$ = ~($2) & 0xFFFFFFFF; }

operateur2 : UNION { $$ = UNION; }
           | INTER { $$ = INTER; }
           | DIFF { $$ = DIFF; }
           | UNION_MINUSCULE { $$ = UNION; }
           | INTER_MINUSCULE { $$ = INTER; }
           | DIFF_MINUSCULE { $$ = DIFF; }

operateur1 : COMP
           | COMP_MINUSCULE

operande : IDENT { $$ = tableau_ensemble[indice_tableau($1)]; }
         | ensemble { $$ = $1; }

ensemble : '{' '}' { $$ = 0; }
         | '{' liste_elements '}' { $$ = $2; }

liste_elements : ELEMENT { $$ = 1 << ($1 - 1); }
               | ELEMENT ',' liste_elements { $$ = (1 << ($1 - 1)) | $3; }
%%

void yyerror(char *message) {
  fprintf(stderr, "%s\n", message);
}


int main(int argc, char **argv) {
  assert(argc == 2);
  // Fermer l'entrée standart et ouvrir argv[1] à la place
  yyin = freopen(argv[1], "r", stdin);
  assert(yyin != NULL);
  // Analyse syntaxique
  int r =yyparse();
  assert(fclose(yyin) == 0);
  yylex_destroy();
  fprintf(stderr, "r -> %d\n", r);
  return 0;
}
