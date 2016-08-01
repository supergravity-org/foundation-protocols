TEX_FILES=$(wildcard src/*.tex)

not-containing = $(foreach v,$2,$(if $(findstring $1,$v),,$v))

TEX_FILES:=$(filter-out src/_, $(TEX_FILES))
TEX_FILES := $(call not-containing,src/_,$(TEX_FILES))

PDF_FILES=$(TEX_FILES:src/%.tex=out/%.pdf)


all: deps $(PDF_FILES)

download:
	test -e minutes.zip || wget -c http://mirrors.ctan.org/macros/latex/contrib/minutes.zip
	test -e minutes/minutes.dtx || unzip -o minutes.zip

prepare:
	mkdir -p out

deps: prepare download

out/%.pdf : src/%.tex prepare
	echo "--------------------------------------------"
	echo make $<
	pdflatex -draftmode -interaction nonstopmode -output-directory out $<
	pdflatex -output-directory out $<


.DEFAULT: all
