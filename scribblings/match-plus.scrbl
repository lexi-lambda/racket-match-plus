#lang scribble/manual

@(require (for-label match-plus
                     racket/base
                     racket/match)
          scribble/eval)

@(define make-match-plus-eval
   (make-eval-factory '(racket/base match-plus)))

@title{Extra Utilities for @racket[match]}

@defmodule[match-plus]

@section{Pattern Matching in Simple Functions}

@defform[(define/match* (head-id args) body)
         #:grammar
         ([args (code:line match-expr ...)
                (code:line match-expr ... @#,racketparenfont{.} rest-expr)])]{
Allows inline pattern-matching in simple function definitions with behavior similar to
@racket[match-lambda**]. However, only one match clause may be specified since the match patterns are
inline with the formals definition. This means an error will be raised if pattern-matching fails, but
it is ideal if a function is already contracted in such a way that successful pattern-matching is
guaranteed.

Equivalent to:

@(racketblock
  (define (head-id args*)
    (match* (args*)
      [(args) body])))

where @racket[args*] is a list of unique identifiers generated corresponding to each @racket[_arg].

@(examples #:eval (make-match-plus-eval)
  (struct point (x y) #:transparent)
  (define/match* (point-add (point a b) (point c d))
    (point (+ a c) (+ b d)))
  (point-add (point 5 9) (point -3 2)))}
