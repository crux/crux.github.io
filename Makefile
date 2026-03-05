.PHONY: install serve drafts theme

ROUGE_THEME ?= base16.solarized.light

install:
	bundle install

serve:
	bundle exec jekyll serve --livereload

drafts:
	bundle exec jekyll serve --livereload --drafts

# EXPERIMENTAL - not yet useful in practice.
# Rouge built-in themes have incomplete token coverage (e.g. missing .gu for markdown
# subheadings) and their generated CSS conflicts with existing layout rules in style.scss.
# The sed filter strips background-color and table rules, but token gaps remain.
# Keeping this target for future exploration.
# Available themes: github, github.dark, monokai, gruvbox.dark, base16.solarized.dark
# Override with: make theme ROUGE_THEME=monokai
theme:
	{ printf '@use "variables" as *;\n\ncode {\n  font-family: $$Monospace;\n  font-size: 0.8em;\n}\n\n.highlight {\n  margin: 0px 0 20px 0;\n  overflow: auto;\n  padding: 0px 7px 7px 10px;\n}\n\n'; bundle exec rougify style $(ROUGE_THEME) | sed -e '/background-color/d' -e '/\.highlight table/d'; } > _sass/_highlights.scss
