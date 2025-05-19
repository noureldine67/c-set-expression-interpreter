# Interpréteur d'expressions ensemblistes

Ce projet est un interpréteur d'expressions ensemblistes développé en C à l'aide des outils **Lex** et **Yacc**. Il permet de manipuler des ensembles d'entiers compris entre 1 et 32, en utilisant des opérations classiques telles que l'union, l'intersection, la différence et le complément.

## Fonctionnalités

* Déclaration d'ensembles avec les accolades `{}`
* Affectation avec `:=` à une variable mono-lettre (a..z ou A..Z, non sensible à la casse)
* Opérations prises en charge :

  * **Union** : `union`, `UNION`
  * **Intersection** : `inter`, `INTER`
  * **Différence** : `diff`, `DIFF`
  * **Complément** : `comp`, `COMP`
* Affichage du contenu d'une variable simplement en écrivant son nom
* Syntaxe tolérante aux majuscules et minuscules pour les opérateurs et identifiants

## Exemple d'utilisation

```
A := { }
a := { 1, 22 }
b := a UNION { 3 }
B
C := { 1, 3, 5 }
A := B inter C
a
```
Résultat attendu :

```
{ 1, 3, 22 }
{ 1, 3 }
```