# Maintenance commands for this zsh config. Run `make` (or `make help`) to list
# them. Targets are self-documenting via the `## ` comments below.

.DEFAULT_GOAL := help
.PHONY: help bench profile install update link

# Absolute path to this repo, derived from the Makefile's own location so `link`
# works no matter where the repo is cloned (the README promises it can live
# anywhere). Trailing slash stripped.
CONFIG_DIR := $(patsubst %/,%,$(dir $(realpath $(lastword $(MAKEFILE_LIST)))))
ZSHRC ?= $(HOME)/.zshrc

help: ## List available commands
	@echo "Usage: make <target>\n"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-9s\033[0m %s\n", $$1, $$2}'

bench: ## Benchmark zsh init time (appends a row to bench/results.md)
	@./bench/bench.zsh

profile: ## Show a per-component init profile (what's slow)
	@ZSH_PROFILE=1 zsh -i -c exit

install: ## Install brew deps + plugin submodules
	brew bundle
	git submodule update --init --recursive

update: ## Update plugin submodules to their latest upstream
	git submodule update --remote --merge

link: ## Add a guarded source line for this config to ~/.zshrc (idempotent)
	@if grep -q 'setup\.zsh' "$(ZSHRC)" 2>/dev/null; then \
		echo "$(ZSHRC) already sources setup.zsh; nothing to do."; \
	else \
		printf '\n[[ -f %s/setup.zsh ]] && source %s/setup.zsh\n' \
			"$(CONFIG_DIR)" "$(CONFIG_DIR)" >> "$(ZSHRC)"; \
		echo "Added source line to $(ZSHRC) (pointing at $(CONFIG_DIR))."; \
	fi
