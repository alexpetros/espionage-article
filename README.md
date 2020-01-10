# Reciprocal Tolerance Article
## Introduction
This is the source file for my espionage article! You can download it yourself and build the PDF locally.  

## Build Instructions
### Requirements
You need a TeX installation with pdflatex, biber, and latexmk. If you've ever built a TeX file locally, you almost certainly have all of these. 

If you don't have one, search around. For OSX, `brew cask install mactex` will install everything you need. 

Even though you shouldn't need the GUI, don't install `mactex-no-gui`, because that doesn't include latexmk for some reason.

### Commands
* `make` builds the thesis and outputs a `thesis.pdf` file in the top directory
* `make open` builds the thesis and then opens the pdf for you in your preferred reader
* `make clean` removes all the artifact files from a top-level build.  

## Other toos
### Bibliography 
I used the excellent LaTeXTools package for Sublime, and Zotero's BetterBibLaTeX to create the `.bib` file.

In order to properly connect the two, you need to switch the LaTeXTools `biblography` preference from `"traditional"` to `"new"`. This changes the parser to one that is capable of reading the preferred BibLaTeX date format.

