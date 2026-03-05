.PHONY: install serve drafts

install:
	bundle install

serve:
	bundle exec jekyll serve --livereload

drafts:
	bundle exec jekyll serve --livereload --drafts
