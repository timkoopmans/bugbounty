_ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
SHELL:=/bin/bash

default: help

help: #: Show help topics
	@grep "#:" Makefile* | grep -v "@grep" | sort | sed "s/\([A-Za-z_ -]*\):.*#\(.*\)/$$(tput setaf 3)\1$$(tput sgr0)\2/g"

subfinder: #: build ProjectDiscover subfinder
	@git subrepo clone git@github.com:projectdiscovery/subfinder.git vendor/subfinder
	@cd vendor/subfinder/v2/cmd/subfinder; go build . ;mv subfinder $(_ROOT_DIR)/bin/;$(_ROOT_DIR)/bin/subfinder -h

httpx: #: build ProjectDiscover httpx
	@git subrepo clone git@github.com:projectdiscovery/httpx.git vendor/httpx
	@cd vendor/httpx/cmd/httpx; go build . ;mv httpx $(_ROOT_DIR)/bin/;$(_ROOT_DIR)/bin/httpx -h

proxify: #: build ProjectDiscover proxify
	@git subrepo clone git@github.com:projectdiscovery/proxify.git vendor/proxify
	@cd vendor/proxify/cmd/proxify; go build . ;mv proxify $(_ROOT_DIR)/bin/;$(_ROOT_DIR)/bin/proxify -h

dnsx: #: build ProjectDiscover dnsx
	@git subrepo clone git@github.com:projectdiscovery/dnsx.git vendor/dnsx
	@cd vendor/dnsx/cmd/dnsx; go build . ;mv dnsx $(_ROOT_DIR)/bin/;$(_ROOT_DIR)/bin/dnsx -h

smuggles: #: build smuggles
	@git git@github.com:danielthatcher/smuggles.git vendor/smuggles
	@cd vendor/smuggles; go build . ;mv smuggles $(_ROOT_DIR)/bin/;$(_ROOT_DIR)/bin/smuggles -h

http-request-smuggling:
	@git subrepo clone git@github.com:anshumanpattnaik/http-request-smuggling.git vendor/http-request-smuggling
	@cd vendor/http-request-smuggling; pip3 install -r requirements.txt