#lang scribble/sigplan @10pt

@title{Improving Java Support in Racket}

@authorinfo["Tim Knutson" "University of Utah" "u0851247@utah.edu"]

@abstract{Professor J is a tool developed by former University of Utah Phd student Kathryn Gray[3]
for teaching Java programming to students. It allows teachers to introduce language features
and concepts progressively by splitting Java into various various language levels.
It includes a Java to Racket compiler with partial support for Java 1.1.
The structure of the compiler is a yacc style lexer and parser which produces an abstract
syntax tree (AST) consisting of mutable structs. The mutable option allowing
each struct's state to be modified with the @tt{set!} operator. This AST is
first type checked and then the compiler translates each part into a corresponding
racket form, taking advantage of racket’s @tt{racket/class} package.}

@include-section{intro.scrbl}
@include-section{profj.scrbl}
@include-section{sdf-sglr.scrbl}
@;@include-section{conclusions}