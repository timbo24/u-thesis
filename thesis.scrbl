#lang scribble/sigplan @10pt

@title{Improving Java Support in Racket}

@authorinfo["Tim Knutson" "University of Utah" "u0851247@utah.edu"]

@abstract{Racket thrives on building an ecosystem full of other languages and the
          tools to develop and integrate those languages. This paper discusses
          progress made in extending support for Java via the ProfessorJ learning
          tool, the goal of continuing and eventually merging work back with that
          master branch, as well as an application in terms of translating a parsing tool
          from Java into Racket.}

@include-section{intro.scrbl}
@include-section{profj.scrbl}
@include-section{sdf-sglr.scrbl}
@include-section{conclusion.scrbl}

@;@(generate-bibliography)