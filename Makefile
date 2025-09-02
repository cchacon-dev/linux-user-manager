BATS      ?= bats
TEST_DIR  := tests

SCRIPTS   := $(wildcard scripts/*.sh) $(wildcard utils.sh)

.PHONY: test
test:
	$(BATS) $(TEST_DIR)

test-%: $(TEST_DIR)/%.bats
	$(BATS) $<

.PHONY: fmt
fmt:
	shfmt -i 2 -ci -sr -w $(SCRIPTS)

.PHONY: fmt-check
fmt-check:
	shfmt -i 2 -ci -sr -d $(SCRIPTS)

.PHONY: lint
lint:
	shellcheck -x -P SCRIPTDIR $(SCRIPTS)

help:
	@echo "Available targets:"
	@echo "  make test        - Run all Bats tests"
	@echo "  make test-<name> - Run a specific test file (without .bats extension)"
	@echo "  make fmt         - Format shell scripts with shfmt"
	@echo "  make fmt-check   - Verify formatting (no changes)"
	@echo "  make lint        - Lint scripts with ShellCheck"