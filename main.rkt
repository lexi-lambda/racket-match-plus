#lang racket/base

(require (for-syntax racket/base
                     racket/syntax
                     syntax/parse)
         racket/match)

(provide define/match*)

(define-syntax (define/match* stx)
  (syntax-parse stx
    [(_ (head:id arg ... . rest) . body)
     (define/with-syntax (arg* ...) (generate-temporaries #'(arg ...)))
     (define rest-arg? (not (null? (syntax-e #'rest))))
     (define/with-syntax rest* (if rest-arg? (generate-temporary #'rest) null))
     (define/with-syntax match*-clause (if rest-arg? #'(arg ... rest) #'(arg ...)))
     (define/with-syntax match*-list (if rest-arg? #'(arg* ... rest*) #'(arg* ...)))
     #`(define (head arg* ... . rest*)
         (match*/derived match*-list #,stx
           [match*-clause . body]))]))

(module+ test
  (require racket/function
           rackunit)

  (define/match* (foo (list a b) (list c d))
    (+ (* a b) (* c d)))

  (check-equal? (foo '(1 2) '(3 4)) 14)
  (check-exn #rx"no matching clause for '\\(\\(\\) \\(\\)\\)"
             (thunk (foo '() '()))))
