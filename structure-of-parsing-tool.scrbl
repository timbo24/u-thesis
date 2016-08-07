#lang scribble/sigplan @10pt

@(require scribble/manual
          (only-in pict bitmap scale)
          scriblib/figure scriblib/footnote)

@title{Structure of Parsing Tool}

The SDF Meta-language consists of a syntax for describing the grammar of
a language as well as rules for disambiguating a parse. A grammar defined
with the SDF will produce a parse table. The underlying SGLR parser,
which acts as a parse table evaluator, takes as input the program
to be parsed as well as this SDF2 generated parse table.  The result is either
a syntax tree or syntax forest. Translation therefore can be split between
the tools and they can be kept modular as in @figure-ref{fig:parsing-tool-struct}.

@figure-here["fig:parsing-tool-struct" "Parsing tool structure" ]{
 @(scale (bitmap "tool-structure.png") .15)}

The Spoofax team provides a commandline tool
that takes in SDF grammar definition modules concatenated into a single file with the
form:
@codeblock|{
definition
   <Module>+
   }|

This provides the basis of the translation. With a working standalone tool
of the form of @figure-ref{fig:sdf-standalone} showing how to use the tool
to read in a definition file and write the parse table to a @tt{.tbl} file.
It is important to have the
tool running with the build path containing all source code because of
how Professor J is structured to translate code and resolve packages and imports.


@figure-here["fig:sdf-standalone" "Example standalone SDF2 use" ]{
 @(scale (bitmap "sdf-standalone.png") .3)}

The code in @figure-ref{fig:jsglr-standalone} shows a working version of the SGLR
by importing an SDF generated parse table as well as a program file. It also
shows the use of @tt{parse} to produce either a parse tree or parse forest.


@figure-here["fig:jsglr-standalone" "Example standalone JSGLR use" ]{
 @(scale (bitmap "jsglr-standalone.png") .25)}