---
vim: et ts=2 sts=2 sw=2
title: vim filetype plugin for scheme programming
keywords: [vim, scheme, guile, programming ]
author: Marc Chantreux <marc.chantreux@renater.fr>
---

before installing and using this plugin, it is *highly* recommended
to learn about the built-in features that made vim an editor of choice
for any s-expr edition


installation

it is highly recommended to use the vim built-in package system.
to do so, please read `:h packages`.
if you don't want to read and trust me, just type

you can install this plugin with

    mkdir -p ~/.vim/pack/vendor/start
    git   -C ~/.vim/pack/vendor/start clone \
      https://github.com:eiro/vim-ft-scheme.git ft-scheme

you're on your own using a 3rd party package manager.

# tips on editing scheme files with vim

## mappings

those ideas may be stolen or adapted to edit even faster:

    " digraphs (:h digraphs) for greek letters are <c-k>*c
    " (where c is a for α, b for β, c for ξ, ...) so
    noremap! <buffer> *l <c-k>*l
    " now can type `*l` to get the λ symbol (and `*<c-v>l` to get `*l`)

    (define f '(this is it)
    )

    " create a new s-expr
    noremap! (( ()<left>
    inoremap (<cr> (<cr>)<c-o>O

    " now if you use the two previous guys, `(` is available to introduce
    " mappings so for example
    map!     <buffer> (d ((define<space>
    map!     <buffer> (m ((map<space>
    noremap! <buffer> (n (newline)
    map!     <buffer> (l ((λ ((
    map!     <buffer> (f ((define ((

## s-expr are text objects

... and vim is very capable with text objects so by default, vim is an
awesome scheme editor. see

    :h text-objects
    :h Q_tm    # quickref on "motion: Text object"
    :h Q_to    # quickref on "Text objects"

so here are some examples
(`|` means "the position of the cursor before the command")



let's say you want to move from

    (display
      (map (λ (x) (* x x)) '(3 4 5)))

to

    (define (f x) (* x x))
    (define foo '(3 4 5))
    (display (map square foo))

  ; if you place the cursor on the lambda
  ; the ( object is (λ (x) (* x x))
  ; replace it by the function name 'square'
  ; type: ca(square

    (display
      (map (λ (x) (* x x)) '(3 4 5)))

    ; replace it by the function name 'square'
    ; type: ca(square



    (λ (x) (* x x))
    (display
      (map square '(3 4 5)))



    ; to

    (display
      (map (λ (x) (* x x)) '(3 4 5)))


    ; place the cursor inside the lambda (for example on λ)
    ; type da(

    (display
      (map  '(3 4 5)))

    (λ (x) (* x x))

(λ (x) (* x x))

    (display
      (map  '(3 4 5))
    )

    :h Q_tm    # quickref on "motion: Text object"
    :h Q_to    # quickref on "Text objects"

  (display
    (map (λ (x) (* x x) )))



* apply something 
* select '()


s-expressions are vim blocks so vim is, by default, an
awesome scheme editor

  (display
    '(display "("))

*

  (define-syntax λ
    (syntax-rules ()
      ((λ sign ...)
       (lambda sign ...))))

there things you should know about vim when editing scheme files
