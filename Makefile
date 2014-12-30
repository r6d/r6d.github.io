all: run
	date

clean:
	rm -rv _site/

run:
	jekyll serve .


