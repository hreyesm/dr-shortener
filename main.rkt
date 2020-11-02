#lang racket

(require koyo/random)
(require net/sendurl)

(define header "https://dr.sh/")
(define filename "dr-shortener.csv")

(define (generate-short)
    (string-append header (generate-random-string 6)))

(define (store-new-key-value out key-value)
    (define key (car key-value))
    (define value (car (cdr key-value)))
    (fprintf out "~a,~a\n" key value)
    (printf "URL has been shortened:\n~a -> ~a" key value))

(define (overwrite-key-value in out line)
    (define key (car (string-split line ",")))
    (define old-value (car (cdr (string-split line ","))))
    (define new-value (generate-short))
    (define old-key-value (string-append key "," old-value))
    (define new-key-value (string-replace line old-value new-value))
    (let loop1
        ([loop-line (read-line in)]
        [file-list empty])
        (if (eof-object? loop-line)
            (let loop2
                ([data file-list])
                (cond
                    [(empty? data)
                        (printf "Short URL has been overwritten:\n~a -> ~a" key new-value)]
                    [(string=? old-key-value (car data))
                        (print old-key-value)
                        (fprintf out "~a\n" new-key-value)]
                    [else
                        (fprintf out "~a\n" (car data))
                        (loop2 (cdr data))]))
            (loop1 (read-line in) (append file-list (list loop-line))))))

(define (read-file in out long)
    (let loop
        ([line (read-line in)])
        (cond
            [(eof-object? line)
                (store-new-key-value out (list long (generate-short)))]
            [(string=? long (car (string-split line ",")))
                (printf "URL has already been shortened.\n\t1. Overwrite existing short URL\n\t2. Add new entry")
                (define input (read))
                (cond
                    [(equal? input 1)
                        (overwrite-key-value in out line)]
                    [(equal? input 2)
                        (store-new-key-value out (list long (generate-short)))]
                    [else (store-new-key-value out (list long (generate-short)))])]
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
    (define out (open-output-file filename #:exists 'append))
    (define in (open-input-file filename))
    (read-file in out long)
    ;;; (close-input-port in)
    (close-output-port out))