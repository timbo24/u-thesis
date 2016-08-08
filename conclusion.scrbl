#lang scribble/sigplan @10pt

@(require scribble/manual
          (only-in pict bitmap scale)
          scriblib/figure scriblib/footnote)

@title{Conclusion}

This document shows efforts made towards adding language support for Java
as well as a parser tool. The driving goal initially was in adding the SDF
tool, but much of the work went into extending support for Java. There is still
a lot of work to do to further support Java and its integration into
Racket and to eventually merge it back. This also details efforts and framework
to getting the parsing tool translated and integrated once more work is done with
Java. 