((method_declaration
  (modifier
    name: (identifier) @_annot_name
    arguments: (annotation_argument_list
      (string_literal 
        (string_content) @injection.content)))
  (#eq? @_annot_name "Query")
  (#set! injection.language "SQL"))
