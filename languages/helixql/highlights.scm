; ============================================================================
; HelixQL highlighting for Zed
; Tree-sitter grammar: github.com/benwoodward/tree-sitter-helixql
; ============================================================================

; Comments
(comment) @comment

; Literals
(string_literal) @string
(integer) @number
(float) @number
(boolean) @boolean
(none) @constant.builtin
(now) @constant.builtin
(ID) @constant.builtin

; Generic identifiers (fallback)
(identifier) @variable
(identifier_upper) @type

; Anonymous traversal placeholder `_`
(anonymous_traversal "_" @variable.builtin)

; ---------------------------------------------------------------------------
; Keywords
; ---------------------------------------------------------------------------

[
  "QUERY"
  "RETURN"
  "FOR"
  "IN"
] @keyword

(index)   @keyword
(default) @keyword
(count)   @keyword

; Step keywords
(where_step "WHERE" @keyword)
(range_step "RANGE" @keyword)
(update     "UPDATE" @keyword)
(drop       "DROP"   @keyword)
(exists     "EXISTS" @keyword)

; Boolean / comparison operators
(and "AND" @keyword.operator)
(or  "OR"  @keyword.operator)
(GT  "GT"  @keyword.operator)
(GTE "GTE" @keyword.operator)
(LT  "LT"  @keyword.operator)
(LTE "LTE" @keyword.operator)
(EQ  "EQ"  @keyword.operator)
(NEQ "NEQ" @keyword.operator)

; Schema declaration markers
[
  "N::"
  "E::"
  "V::"
] @keyword

; Edge schema field labels
[
  "From:"
  "To:"
  "Properties"
] @keyword

; Traversal source roots
(start_node   "N" @keyword)
(start_edge   "E" @keyword)
(start_vector "V" @keyword)

; ---------------------------------------------------------------------------
; Builtin functions / methods
; ---------------------------------------------------------------------------

; Graph traversal steps
(out_e         "OutE"         @function.builtin)
(in_e          "InE"          @function.builtin)
(from_n)                       @function.builtin
(to_n)                         @function.builtin
(out           "Out"          @function.builtin)
(in_nodes      "In"           @function.builtin)
(shortest_path "ShortestPath" @function.builtin)

; Edge endpoint helpers
(to   "To"   @function.builtin)
(from "From" @function.builtin)

; Creation / mutation
(AddN          "AddN"      @function.builtin)
(AddE          "AddE"      @function.builtin)
(AddV          "AddV"      @function.builtin)
(BatchAddV     "BatchAddV" @function.builtin)
(search_vector "SearchV"   @function.builtin)

; ---------------------------------------------------------------------------
; Specific identifier roles (override the generic rules above)
; ---------------------------------------------------------------------------

; Query name
(query_def name: (identifier) @function)

; Schema names
(node_def   name: (identifier_upper) @type)
(edge_def   name: (identifier_upper) @type)
(vector_def name: (identifier_upper) @type)

; Parameter names
(param_def name: (identifier) @variable.parameter)

; Field / property names
(field_def     name: (identifier) @property)
(new_field     key:  (identifier) @property)
(update_field  key:  (identifier) @property)
(mapping_field (identifier) @property ":")
(object_access field: (identifier) @property)
(property_access property: (identifier) @property)

; Closure parameter
(closure_step "|" (identifier) @variable.parameter "|")

; Assignment LHS
(get_stmt variable: (identifier) @variable)

; For-loop iterable variable
(for_loop iterable: (identifier) @variable)

; ---------------------------------------------------------------------------
; Types
; ---------------------------------------------------------------------------

(named_type) @type.builtin
(date_type)  @type.builtin
(ID_TYPE)    @type.builtin

(type_args (identifier_upper) @type)

; ---------------------------------------------------------------------------
; Operators / punctuation
; ---------------------------------------------------------------------------

[
  "<-"
  "=>"
  "::"
  "."
  ".."
  "!"
] @operator

[
  ":"
  ","
] @punctuation.delimiter

[
  "("
  ")"
  "{"
  "}"
  "["
  "]"
  "<"
  ">"
] @punctuation.bracket

"|" @punctuation.special
