.PHONY: all

all: generated/Core/Basics.elm

generated/Core/Basics.elm: generated/modules.elms codegen/Gen/Basics.elm codegen/Generate.elm node_modules/elm-codegen/bin/elm-codegen
	rm -f generated/**/*.elm
	yarn elm-codegen run --flags-from generated/modules.elms

codegen/Gen/Basics.elm: codegen/elm.codegen.json node_modules/elm-codegen/bin/elm-codegen
	yarn elm-codegen install

node_modules/elm-codegen/bin/elm-codegen: package.json yarn.lock
	yarn install

generated/modules.elms: Makefile
	mkdir -p generated
	find ${ELM_HOME}/0.19.1/packages/elm/core/1.0.5/src -type f -name '*.elm' | xargs awk 'FNR==1 && NR!=1 {print "---SNIP---"}{print}' > $@
