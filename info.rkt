#lang info

(define collection "match-plus")
(define version "0.1")

(define scribblings '(["scribblings/match-plus.scrbl"]))

(define deps
  '("base"))
(define build-deps
  '("racket-doc"
    "rackunit-lib"
    "scribble-lib"))
