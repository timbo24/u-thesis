#lang scribble/sigplan @10pt

@(require (only-in pict bitmap scale)
          scriblib/figure
          scriblib/footnote)

@title{Professor J}

With each part of the tool working, including all required libraries with source code,
most of the effort remaining was modifying Professor J's compiler. The structure of
the compiler is a yacc style lexer and parser which produces an abstract
syntax tree (AST) consisting of mutable structs. The mutable option allowing
each struct's state to be modified with the @tt{set!} operator. This AST is
first type checked and then the compiler translates each part into a corresponding
racket form, taking advantage of racket’s @tt{racket/class} package. 

@section[#:tag "sub:java"]{Improving Java support}

Professor J was developed with support up to Java 1.1. The documentation
shows that some language features were not implemented upon its completion.
The Spoofax tools were developed using Java 7, so effort was taken to
expand both Professor J's and Racket's support for Java by adding both
the missing features from Java 1 and 1.1 as well as all up to 7. A summary
is shown in @figure-ref{fig:java-evol}. It is a large list so it was important
to prioritize the language features with the largest impact. The focus was on 
generics (Java's version of parametric polymorphism), autoboxing/unboxing
conversions between primitives and their corresponding Object types, and then
nested classes. 

@figure-here[#:style left-figure-style
             "fig:java-evol"
             "Java language evolution"]{
 @bold{@larger{Java 1/1.1 (Not implemented in Professor J)}}
 @itemlist[@item{nested classes (static nested and inner)}
           @item{switch}
           @item{labeled statements (compiles but does not work correctly)}
           @item{reflection}
           @item{unicode}
           @item{@tt{synchronized} keyword (compiles but is ignored)}]
 @bold{@larger{Java 2}}
 @itemlist[@item{@tt{strictfp} keyword}]
 @bold{@larger{Java 4}}
 @itemlist[@item{@tt{assert} keyword}]
 @bold{@larger{Java 5}}
 @itemlist[@item{generics}
           @item{autoboxing/unboxing}
           @item{enumerations: use of @tt{enum} keyword to create typesafe, ordered list of values}
           @item{varargs: last parameter of a method can be followed by ellipses, any number of parameters of the type can be used and placed inside of an array and passed to the method}
           @item{for each}
           @item{static imports}]
 @bold{@larger{Java 7}}
 @itemlist[@item{strings in switch}
           @item{improved type inference}
           @item{simplification of varargs}
           @item{underscores allowed in numeric literals}]}

Nested classes can be handled as is by simply reusing code and
allowing classes to be members like methods and fields. Local and anonymous
classes were also introduced in Java 1.1 and additional work must go further
into adding support for them.

The motivation for the addition of generics, like typing in general, is
to catch errors early and make development more declarative and readable.
The way that generics function within Java is to allow classes, interface, and methods to
be declared as generic. Syntactically this means that one or more type parameters are
introduced into the header within a matching set of angle brackets. Figure @figure-ref{fig:generic-class} shows
an example of a generic class in Java.

@figure-here["fig:generic-class" "Example Generic Class"]{
 @(scale (bitmap "generic-class.png") .3)}

In order to introduce this into the compiler, the type variables are saved during parsing.
When the type-checker hits a class or method, it then does a search of all members and
replaces all instances of the type parameter and replaces it with an Object type. This
works because every class inherits from type Object.

The next large change was with autoboxing and unboxing, which allows Java to
automatically convert from primitive types to corresponding Object types and vice versa.
Difficulty arose from this due to the mutable nature of the AST.

(Expand more on this stuff if need be)

@bold{TODO}
@bold{Java}
@itemlist[@item{libraries}]
@bold{Improvements towards Professor J (What would have made this easier)}
@itemlist[@item{Documentation}
          @item{More Functional}
          @item{typed}
          @item{modular}
          @item{merging}]
@bold{Tool integration}
@itemlist[@item{#lang}
          @item{make a package}
          @item{attach reader to SDF parse function via (port->string is)}
          @item{syntax-coloring}
          @item{etc.}]
		
