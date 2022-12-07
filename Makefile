TMPFILES	= *.{log,aux,toc,out,lof,lot,snm,nav,vrb,bak,bbl,blg,ent,bak*}
LATEX		= pdflatex -interaction=nonstopmode
BIB			= bibtex
SHELL		= /bin/bash # fix for not running clean

default:	beamer

all:		beamer handout notes dualmon

beamer:		beamer.pdf
handout:	handout.pdf
notes:		notes.pdf
dualmon:	dualmon.pdf
article:	article.pdf
glossary:	glossary.pdf

%-watch:
	make $*
	find . -name '*.tex' | entr -d make $*
	# while inotifywait -e close_write *.tex content/* images/* *.bib; do make $*; done

%.pdf: %.tex main.tex $(wildcard content/*) $(wildcard images/*) $(wildcard *.bib)
	$(LATEX) $<
	$(BIB)   $*
	$(LATEX) $<
	$(LATEX) $<

clean:
	rm -f $(TMPFILES)
	rm -f *.pdf

%-pdf:
	make $*
	rm -f $(TMPFILES)

open:
	open beamer.pdf
