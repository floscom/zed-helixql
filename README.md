# Zed HelixQL

Syntax highlighting for [HelixDB](https://helix-db.com)'s **HelixQL** query language in the [Zed editor](https://zed.dev).

Activates on files with the `.hx` or `.hql` extension.

## What it highlights

- Schema declarations (`N::User`, `E::Follows`, `V::Embedding`) and their `From:` / `To:` / `Properties` blocks
- `QUERY` definitions, parameters, `FOR ... IN`, `RETURN`
- Graph traversal steps: `Out`, `In`, `OutE`, `InE`, `FromN`, `ToN`, `ShortestPath`
- Creation steps: `AddN`, `AddE`, `AddV`, `BatchAddV`, `SearchV`
- Filtering / control: `WHERE`, `EXISTS`, `RANGE`, `COUNT`, `UPDATE`, `DROP`
- Boolean / comparison operators: `AND`, `OR`, `GT`, `GTE`, `LT`, `LTE`, `EQ`, `NEQ`
- Primitive types: `String`, `Boolean`, `F32`–`F64`, `I8`–`I64`, `U8`–`U128`, `ID`, `Date`
- Strings, numbers, booleans, `NONE`, `NOW`, `INDEX`, `DEFAULT`
- Operators (`<-`, `=>`, `::`, `..`, `!`) and brackets

No language server — this is a highlight-only extension.

## Install (dev / local)

1. Clone this repo.
2. In Zed: `cmd-shift-p` → **"zed: install dev extension"** → pick this directory.
3. Open any `.hx` / `.hql` file.

## Install (from the extension store)

Once merged into [`zed-industries/extensions`](https://github.com/zed-industries/extensions), you can find it in Zed's extensions panel as **HelixQL**.

## Credits

Built on the MIT-licensed [`benwoodward/tree-sitter-helixql`](https://github.com/benwoodward/tree-sitter-helixql) grammar.

## License

MIT — see [LICENSE](LICENSE).
