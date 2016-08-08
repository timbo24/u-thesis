#lang scribble/sigplan @10pt

@(require (only-in pict bitmap scale)
          scriblib/figure
          scriblib/footnote
          scribble/manual)

@title{ProfessorJ}

ProfessorJ is a tool developed by former University of Utah Phd student Kathryn Gray
for teaching Java programming to students. It allows teachers to introduce language features
and concepts progressively by splitting Java into various various language levels.
It includes a Java to Racket compiler with partial support for Java 1.1.
The structure of the compiler is a yacc style lexer and parser which produces an abstract
syntax tree (AST) consisting of mutable structs. This AST is
first type checked and then the compiler translates each part into a corresponding
Racket form, taking advantage of racket’s @tt{racket/class} package.

The compiler is the main focus, and especially the efforts to go from Java 1.1 to Java 7.
@Secref{sub:java} covers this part, and the challenges that occured as well as discussing
what still needs to be done. Next, @secref{sub:structure} will discuss some additional changes
around the code that would help and make the code easier to maintain, and benefit
ProfessorJ as a tool to be used by others and to support additional changes in the future.

@section[#:tag "sub:java"]{Improving Java support}

ProfessorJ was developed with support up to Java 1.1. The documentation
shows that some language some features were not completed initially.
@Figure-ref{fig:java-evol} shows a summary of all syntax updates to the language.
There are many changes, but only a few were significant alterations. The focus was on static
nested classes, generics (Java's version of parametric polymorphism), and 
autoboxing/unboxing conversions between primitives and their corresponding Object types.
@figure-here[#:style left-figure-style
             "fig:java-evol"
             "Java language evolution"]{
 @bold{@larger{Java 1/1.1 (Not implemented in ProfessorJ)}}
 @itemlist[@item{static nested classes}
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
allowing classes to be members like methods and fields. Inner classes are handled
but not parsed correctly, so additional changes to the parser were required in
order to make sure that these were also handled correctly. 

The motivation for the addition of generics, like typing in general, is
to catch errors early and make development more declarative and readable.
The way that generics function within Java is to allow classes, interface, and methods to
be declared as generic. Syntactically this means that one or more type parameters are
introduced into the header within a matching set of angle brackets.  @Figure-ref{fig:generic-class} shows
an example of a generic class in Java. 

@figure-here["fig:generic-class" "Example generic class"]{
 @(scale (bitmap "generic-class.png") .3)}

This is the largest change to the syntax of the language, and modifications first go
to the lexer and parser where the matching angle bracket form is handled and type
variables are stored. This must be done in the build-info phase of compilation,
where ProfessorJ resolves imports. Without replacing type parameters the compiler will
be looking out in the package structure to import it, which will cause errors.
So if the class saved type parameters it simply does a search of all members and
replaces all instances of the type parameter with an Object type. This
works because every class inherits from type Object.

The next large change was with autoboxing and unboxing, which allows Java to
automatically convert from primitive types to corresponding Object types and vice versa.
This requires modifying the AST within the type-checker.

This was the extent of progress made to add new features in terms of Java support. There
are however other additions to the tool that would benefit other developers and
make it easier to update.

@section[#:tag "sub:structure"]{Further work and considerations}

There are ways to improve ProfessorJ beyond adding new language constructs. Ways that
make it easier to reason about some of the code, and make working with it more explicit.
The plan is to add these features in the future and eventually merge back with the main
github repository at @url{https://github.com/mflatt/profj}.

The code does a good job of stating function inputs and outputs via comments; however,
using an actual type system could improve readability, as well as prevent
runtime errors. Something like Typed Racket would force strict adherence to types
and would force good habits. What this could do is highlight type errors at
compile time, highlighting protions of code to test and modify. Instead, modifications
can be made with normal Racket, but without thorough testing it is easy for
simple type issues to slip through especially in edge cases. With larger code bases
this can exacerbate this issue, so a type systems addition would be welcome.

Functional programming has an emphasis on preserving state. This
philiosophy has its justifications. It can make functions clearer, so that
the main focus of computation within a function is on what value is returned.
It also makes changes to values to be more explicit again, adding to clarity.
For the most part ProfessorJ is done functionally aside from its mutable AST.
It might therefore be worth it to modify the code to do this. It would
involve threading it through across phases of the compiler. 

If at any point the AST needs to be modifed, instead of returning the passed value,
it can be functionally updated, and a newly modifed version is passed on instead.
Lenses make this update simple, instead of defining a @tt{struct}, you can use
@tt{struct/lens} to automatically generate a functional setter and getter. That allows
an updated struct to be generated without destroying the original. Therefore, if at any
point within the compilation, a modification can occur and the AST will automatically
be threaded through.

The last piece of additional help might simply be with better documentation. It was
not always clear how different parts of the program worked together, and although
it was coded very modularly, simple aid in the form of comments around complex lambdas
and functions would have gone a long way in providing clarity. 
