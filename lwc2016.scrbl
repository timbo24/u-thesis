#lang scribble/sigplan @10pt

@(require scribble/manual
          (only-in pict bitmap scale)
          scriblib/figure scriblib/footnote)

@title{2016 Language Workbench Challenge}

The Language Workbench Challenge is an opportunity for various  language
development communities to show off their perspectives and tools.

Racket's focus is on its powerful language transformation properties as
well as the ability, discussed in @secref{sub:#lang}, to seamlessly incorporate
languages ontop of core Racket.
The challenge included implementing a subset of Java called MiniJava
and then showing how to implement additional features on top of the
core language. The solution features these various transformations that Racket can
incorporate in order to compile MiniJava down to base to Racket. The @tt{#lang}
component includes a front end
parser and lexer based on ProfessorJ's yacc style definitions. The real benefit of
both expanding Java support with ProfessorJ and
applying that to something like SDF is that it can instantly be incorporated
into DrRacket and aid in the creation of new languages. 

This is a quick demonstration of how, once translated with ProfessorJ, these tools
would be used to provide support for a new language, in this case MiniJava. 
The front end parsing and lexing were incorporated into Racket using @tt{#lang mini-java}.
This involves defining a reader that uses the parse
function provided by the yacc parser. @Figure-ref{fig:example-reader} shows how
to incorporate the SDF tool instead, once a sdf definition is written using the ProfessorJ
translated tool, it can be imported by the reader for mini-java.
The grammar definition is imported on
line 16 providing the parse-table it generates for use on line 22.  Both
parse-table-manager% and sglr% classes result from translating the SGLR tool into
Racket using ProfessorJ, this allows the read-syntax definition to incorporate
the SGLR parse function.

@figure*["fig:example-reader" "Example reader incorporation parsing tool" ]{                                                                              
 @codeblock[#:line-numbers 1]|{
              #lang racket

              (module reader syntax/module-reader
                mini-java/infix-mini-java
                #:read-syntax
                (λ (name in)
                  (read-syntax name in))
  
                #:read
                (λ (in)
                  (map syntax->datum (read-syntax 'prog in)))
  
                #:whole-body-readers?
                #t
                
                (require "mini-java-grammar-definition.sdf"
                         sglr)

                (let* [(ptm (new parse-table-manager%))
                       (sglr (instantiate sglr%
                                          (list (send ptm get-factory)
                                                parse-table)))]
  
                  (define (read-syntax name in)
                    (send sglr parse (port->string in) name 'program))))
              }|
 }

Now, that provides the ability to define a @tt{#lang mini-java} file
and it will automatically connect the SGLR parser. 
This demonstrates how straight forward it is to
incorporate new language front ends into Racket, and how this power comes from
Racket's focus on expanding its language support. 
