#lang info

(define collection 'multi)
(define version "0.1")

(define scribblings '(["scribblings/match-plus.scrbl"]))

(define deps '())

(define build-deps
  '("racket-doc"
    "rackunit-lib"
    "scribble-lib"
    "match-plus-lib"))
