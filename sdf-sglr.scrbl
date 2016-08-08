#lang scribble/sigplan @10pt

@(require scribble/manual
          (only-in pict bitmap scale)
          scriblib/figure scriblib/footnote)

@title{SDF + SGLR}

Although full Java 7 support was not completed, the framework for integrating a parsing
tool, written in Java, into Racket and Dr Racket can now be established. Racket's current
yacc style lexing and parsing tools have their limitations and adding one that
could accept all context free grammars, simplify grammar definitions, and most
importantly provide robust error recovery and reporting would benefit Racket. Not only that
but adding a tool like this would also make future integration of languages, and other tools,
much easier as well.

The Spoofax Language Workbench offers a combination Syntax Definition Formalism (SDF)
and Scannerless Generalized LR Parser (SGLR) that resolve the issues raised by Racket's current
parsing tools and would make a powerful addition to Racket. Having to develop a grammar with
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

The goal would then be to define a package and use @tt{#lang sdf} to allow developers
to seamlessly write grammars like @figure-ref{fig:sdf-example} directly in Dr Racket,
using it to add even more support for new and existing languages. Another important goal
for this project is to improve the Professor J learning tool, and specifically the compiler.
Adding not only new Java support but other changes to make it easier to extend and work on
and merging those changes back with the git repo.

@section[#:tag "sub:sdf-sglr"]{Structure of Parsing Tool}

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

@section[#:tag "sub:sdf-sglr"]{@tt{#lang sdf}}

"describe signifacants of #lang"
With @tt{#lang} Racket provides a powerful way to incorporate new languages into
its ecosystem. Developers can simply type @tt{#lang language-of-choice} at the top
of a window in Dr Racket and if the package exists, they can simply begin writing
in the syntax of that language. It can be used to integrate something like the SDF
meta-language into racket was well. Once complete users can write in the exact syntax as
@fig-ref{fig:sdf-example} except with @tt{#lang sdf} prepended.

Once both tools are translated, a @tt{#lang} can be created by defining the reader
that is called once racket sees @tt{#lang sdf}. It will then use this to interpret
the syntax of the definitions window and usually what happens is that it produces
a syntax-object which will either continue to be processed, or will be compiled
with Racket. Instead, what the SDF grammar definition should do is produce a parse
table file. From @fig-ref

@figure-here["fig:sdf-example" "Example SDF grammar" ]{
 @(scale (bitmap "sdf-example.png") .25)}