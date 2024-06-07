; extends

(fenced_code_block
  (info_string (language) @_language)
  (#any-of? @_language "cs" "c_sharp")
  (code_fence_content) @c_sharp)
