#lang scribble/sigplan @10pt

@(require scribble/manual
          (only-in pict bitmap scale)
          scriblib/figure scriblib/footnote)

@title{Introduction}

Racket's power comes from being able to support and create other languages.
It provides powerful tools that make defining and modifying syntax easy, and
allows these languages to be integrated seamlessly into DrRacket, its built
in integrated developer environment (IDE). This focus on languages feeds itself;
as languages are built over a common core, powerful tools become available that
can make creating and supporting new languages even easier. This document will
cover efforts to improve Racket support for the Java programming language
in the form of the ProfessorJ learning tool. It will also go over progress made
towards using this support to integrate a powerful parsing tool into DrRacket.
Finally, it will discuss how a tool like this can then be used to add support
for even more languages. 
