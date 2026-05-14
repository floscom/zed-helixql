#!/usr/bin/env bash
# Validate all .scm queries against the pinned tree-sitter-helixql grammar.
# Mirrors what zed-industries/extensions CI does at package time.
#
# Usage: scripts/check.sh
# Requires: node + tree-sitter CLI (npm i -g tree-sitter-cli) and git.

set -euo pipefail
cd "$(dirname "$0")/.."

ROOT="$(pwd)"
WORK="$ROOT/.local-test"
GRAMMAR_DIR="$WORK/tree-sitter-helixql"
GRAMMAR_REPO="https://github.com/benwoodward/tree-sitter-helixql.git"
GRAMMAR_COMMIT="$(awk -F\" '/^commit *=/ {print $2}' extension.toml)"

# Resolve tree-sitter CLI binary (npm or brew install)
if command -v tree-sitter >/dev/null; then
  TS=tree-sitter
else
  TS="$(npm prefix -g 2>/dev/null)/bin/tree-sitter"
  [ -x "$TS" ] || { echo "tree-sitter CLI not found. Run: npm i -g tree-sitter-cli"; exit 1; }
fi

mkdir -p "$WORK"
if [ ! -d "$GRAMMAR_DIR/.git" ]; then
  git clone "$GRAMMAR_REPO" "$GRAMMAR_DIR"
fi
git -C "$GRAMMAR_DIR" fetch --quiet origin
git -C "$GRAMMAR_DIR" checkout --quiet "$GRAMMAR_COMMIT"
(cd "$GRAMMAR_DIR" && "$TS" generate >/dev/null)

# Point tree-sitter's parser-directories at the work dir so --scope resolves.
mkdir -p "$HOME/.config/tree-sitter"
CFG="$HOME/.config/tree-sitter/config.json"
if [ ! -f "$CFG" ] || ! grep -q "$WORK" "$CFG"; then
  printf '{ "parser-directories": ["%s"], "theme": {} }\n' "$WORK" > "$CFG"
fi

# Pick the first .hx file under examples/ as the test input.
SAMPLE="$WORK/sample.hx"
if [ ! -f "$SAMPLE" ] && [ -f examples/sample.hx ]; then
  cp examples/sample.hx "$SAMPLE"
fi
[ -f "$SAMPLE" ] || { echo "Missing $SAMPLE — add examples/sample.hx"; exit 1; }

fail=0
for f in languages/helixql/*.scm; do
  printf "%-40s" "$(basename "$f"):"
  if "$TS" query "$f" "$SAMPLE" --scope source.helixql >/dev/null 2>err.log; then
    echo "ok"
  else
    echo "FAIL"
    cat err.log
    fail=1
  fi
done
rm -f err.log
exit $fail
