
main := "main.go"

_help:
  @just --list -f {{justfile()}} --list-heading '' --unsorted

# ------------------------------ General ------------------------------

[group('general')]
var:
  @just --evaluate

[group('general')]
shell:
  #!/usr/bin/env bash
  export ENV_SET="local"
  nix develop --extra-experimental-features "nix-command flakes" -c zsh

# ------------------------------ App ------------------------------

[group('app')]
build:
  @nix --extra-experimental-features "nix-command flakes" build --print-out-paths

[group('app')]
closure: build
  @nix-store -qR ./result

[group('app')]
run-build: build
  ./result/bin/app

# ------------------------------ Go ------------------------------

[group('go')]
edit:
  $EDITOR {{main}}

[group('go')]
test:
  go test ./...

[group('go')]
run:
  @go run ./{{main}}

