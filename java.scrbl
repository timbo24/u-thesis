#lang scribble/sigplan @10pt

@(require (only-in pict bitmap scale)
          scriblib/figure
          scriblib/footnote)

@title{Improving Java Support}

@figure-here["fig:java-evol" "Java Language Features"]{
@(scale (bitmap "generic-class.png") .3)}

Professor J was developed with support for all of Java 1.1's features except for
nested classes. The Spoofax tools were developed using Java 7, so effort was taken to
expand both Professor J's and Racket's support for Java. @figure-ref{fig:java-evol}
shows the evolution of Java since 1.1. Key changes came with Java 5 when generics
were introduced (Java's version of parametric polymorphism), autoboxing/unboxing
conversions between primitives and their corresponding Object types, as well as other
tweaks to the syntax. Java 7 saw a few more minor tweaks, but the main focus
was on adding generics, autoboxing/unboxing, and nested classes.

Again, generics were introduced to the language with Java 5. The motivation for the addition,
like typing in general, is to catch errors early and make development more declarative.
The way that generics function within Java is to allow classes, interface, and methods to
be declared as generic. Syntactically this means that one or more type parameters are
introduced within a matching set of angle brackets. Figure @figure-ref{fig:generic-class} shows
an example of a generic class in Java


A
simple example where this is beneficial is with an array object, by forcing a type on
this class, the programmer can be declarative about how he, as well as any other
developer using this code can use the contents of arrays. 
code is run with a specific input. (Should I put a more fully formed example of the benefits of
generics here???) The implementation of generics is such that angle brackets allows the
developer to sprecify type parameters for classes as well as methods. The type parameters
can then be used within the body of the class or method as a placeholder for a type
to be specified when instantiated. Figure @figure-ref{fig:generic-class} shows an example of
a generic class in Java. The T represents this type parameter. Everywhere in the body
of the class where the T ends up needs to be changed to the instantiated type.

In order to handle this a simple conversion can happen that involves a few steps. First
the type paremeter data needs to be picked up in the parser and the AST is modified.
Next, in the type-checker, processing a class, every instance of a type inside of
the class body could potentially be the placeholder. 

@figure-here["fig:generic-class" "Example Generic Class"]{
 @(scale (bitmap "generic-class.png") .3)}

talk about supporting generics

talk about auto boxing unboxing

transition in work to do to improve Professor J, as well as plans to merge back with
github repo. 

