#lang racket

(require koyo/random)
(require net/sendurl)

(define header "https://dr.sh/")
(define filename "dr-shortener.csv")

(define (generate-short)
    (string-append header (generate-random-string 6)))

(define (store-key-value key-value)
    (define key (car key-value))
    (define value (car (cdr key-value)))
    (define out (open-output-file filename #:exists 'append))
    (fprintf out "~a,~a\n" key value)
    (close-output-port out)
    (printf "URL has been shortened:\n~a -> ~a" key value))

(define (read-file in long)
    (let loop
        ([line (read-line in)])
        (cond
            [(eof-object? line)
                (store-key-value (list long (generate-short)))]
            [(string=? long (car (string-split line ",")))
                (displayln "URL has already been shortened")]
            [else (loop (read-line in))])))

(define (open-url in short)
    (let loop
        ([line (read-line in)])
        (cond
            [(eof-object? line)
                (printf "URL not found")]
            [(string=? short (car (cdr (string-split line ","))))
                (send-url (car (string-split line ",")))]
            [else (loop (read-line in))])))

(define (main long)
    (define in (open-input-file filename))
    (read-file in long)
    ;;; (open-url in long)
    (close-input-port in)
)
