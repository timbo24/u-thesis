#lang racket

(require scriblib/autobib)
(provide (all-defined-out))

(define-cite ~cite citet generate-bibliography)

(define profj
  (make-bib
   #:title "ProfessorJ: A Gradual Intro to Java through Language Levels"
   #:author (authors "Kathryn E Gray"
                     "Matthew Flatt")
   #:location (journal-location "OOPSLA Educators' Symposium")
   #:date 2003))

(define natural-flex-error-recovery
  (make-bib
   #:title "Natural and Flexible Error Recovery for Generated Modular Language Environments"
   #:author (authors "Maartje de Jonge"
                     "Lennart C.L. Kats"
                     "Emma Soderberg"
                     "Eelco Visser")
   #:location (techrpt-location #:institution "Delft University of Technology" #:number "TUD-SERG-2012-021")
   #:date 2012))

(define drracket
  (make-bib
   #:title "DrScheme: A Programming Environment for Scheme"
   #:author (authors "Robert Bruce Findler"
                     "John Clements"
                     "Cormac Flanagan"
                     "Matthew Flatt"
                     "Shriram Krishnamurthi"
                     "Paul Steckler"
                     "Matthias Felleisen")
   #:location (journal-location "Journal of Functional Programming"
                                #:volume 12
                                #:number 2)
   #:date 2002))

(define mini-java
  (make-bib #:author "Eric Roberts"
            #:title "An Overview of MiniJava"
            #:location (proceedings-location "SIGCSE")
            #:date 2001))

(define lwc2016
  (make-bib #:author (authors "Daniel Feltey"
                              "Spencer P. Florence"
                              "Tim Knutson"
                              "Vincent St-Amour"
                              "Ryan Culpeper"
                              "Matthew Flatt"
                              "Robert Bruce Findler"
                              "Matthias Felleisen")
            #:title "Languages the Racket Way"
            #:location (proceedings-location "2016 Language Workbench Challenge")
            #:date 2016))

(define sdf
  (make-bib #:author "Eelco Visser"
            #:title "Syntax Definition for Language Prototyping"
            #:location (dissertation-location #:institution "University of Amsterdam"
                                     #:degree "Ph.D.")
            #:date 1997))
            
                                