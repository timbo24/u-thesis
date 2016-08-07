#lang scribble/sigplan @10pt

@(require scribble/manual
          (only-in pict bitmap scale)
          scriblib/figure scriblib/footnote)

@title{Introduction}

Racket’s power comes from the tools it provides for the creation and extension
of programming languages. Tools that include its hygienic macro system
for modifying syntax at compile time and a special @tt{#lang} module form
for creating and integrating new languages into Dr Racket, its built in  integrated
developer environment (IDE). However, with all of its powerful tools, one area that would
benefit greatly from an update is parsing. The current yacc-style
lexer and parser tools have their limitations, including the necessity of
defining separate parsing and tokenization phases, limited error recovery,
and limited grammar support. 

The Spoofax Language Workbench offers a combination Syntax Definition Formalism (SDF)
and Scannerless Generalized LR Parser (SGLR) that resolve these issues and
would make a powerful addition to Racket. Having to develop a grammar with
LL(k) or LR(k) restrictions in mind or having to refactor existing grammars can be prohibitive.
SGLR handles this by parsing ambiguity in parallel which means that it can parse
@emph{any} context free grammar (CFG). These tools also provide a simplified development
process: the SDF meta-language provides clear syntax for grammar definition all within
a single module, although a grammar can span multiple modules. An example grammar
using the SDF syntax is shown in @figure-ref{fig:sdf-example}. Extensive
work has gone into the error recovery and error reporting features of SGLR,
it allows illformed programs to be parsed while still providing useful information
about the wellformed portions. This is especially useful for parsing in an interactive
environment such as an IDE, where code updates often do result in illformed programs.
Both of these tools are implemented using Java as part of an Eclipse IDE plugin,
@figure-here["fig:sdf-example" "Example SDF grammar" ]{
 @(scale (bitmap "sdf-example.png") .25)}
so bringing them natively to Racket is an issue.
@;TODO add reference to permissive grammars research paper

Going along with Racket's focus on powerful tools to help build new languages
it aims to provide support for pre-existing languages. Professor J is a tool developed by
former Universit of Utah Phd student Kathryn E Gray[3] for teaching Java
programming to students. It allows teachers to introduce language features
and concepts progressively by splitting Java into various various language levels.
It includes a Java to Racket compiler with support for an early version of Java.
This is a good opportunity to therefore add updated support for Java and the Professor J
tool as a whole as well as make efforts towards bringing a powerful parser to Racket.

The goal would then be to define a package and use @tt{#lang sdf} to allow developers
to seamlessly write grammars like @figure-ref{fig:sdf-example} directly in Dr Racket,
using it to add even more support for new and existing languages. Another important goal
for this project is to improve the Professor J learning tool, and specifically the compiler.
Adding not only new Java support but other changes to make it easier to extend and work on
and merging those changes back with the git repo.

This document 
