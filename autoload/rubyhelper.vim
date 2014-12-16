let s:STRING_PATTERN = '\([''"]\)\(\w\{-}\)\1'
let s:SYMBOL_PATTERN = ':\(\w\+\)'
let s:HASH_VALUE_PATTERN = '\([^,]*\(,\|$\)\)'
let s:HASH_STRING_KEY_PATTERN =
      \s:STRING_PATTERN . '\s\+=>' . s:HASH_VALUE_PATTERN
let s:HASH_SYMBOL_KEY_PATTERN =
      \s:SYMBOL_PATTERN . '\s\+=>' . s:HASH_VALUE_PATTERN
let s:HASH_JSON_KEY_PATTERN =
      \'\(\w\+\):' . s:HASH_VALUE_PATTERN

function! rubyhelper#SearchUnderCursor(pattern)
  let [line, start_col] = searchpos(a:pattern, 'bcnW', line('.'))
  if line > 0 && start_col > 0
    let [line, end_col] = searchpos(a:pattern, 'cenW', line('.'))
    if col('.') >= start_col && col('.') <= end_col
      return [start_col, end_col]
    endif
  endif
  return [0, 0]
endfunction

function! rubyhelper#SearchAndReplaceUnderCursor(search_pattern, replace_pattern)
  let [start_col, end_col] = rubyhelper#SearchUnderCursor(a:search_pattern)
  if start_col > 0 && end_col > 0
    let new_search_pattern = '\%' . start_col . 'v' . a:search_pattern
    exe 's/' . new_search_pattern . '/' . a:replace_pattern . '/'
    return 1
  endif
  return 0
endfunction

function! rubyhelper#SymbolStringSwitch()
  let current_col = col('.')
  let result = rubyhelper#SearchAndReplaceUnderCursor(s:STRING_PATTERN, ':\2')
  if result == 0
    call rubyhelper#SearchAndReplaceUnderCursor(s:SYMBOL_PATTERN, '''\1''')
  endif
  call cursor(line('.'), current_col)
endfunction

function! rubyhelper#HashSyntaxSwitch()
  let current_col = col('.')
  let result = rubyhelper#SearchAndReplaceUnderCursor(s:HASH_STRING_KEY_PATTERN, '\2:\3')
  if result == 0
    let result = rubyhelper#SearchAndReplaceUnderCursor(s:HASH_SYMBOL_KEY_PATTERN, '\1:\2')
    if result == 0
      call rubyhelper#SearchAndReplaceUnderCursor(s:HASH_JSON_KEY_PATTERN, ':\1 =>\2')
    endif
  endif
  call cursor(line('.'), current_col)
endfunction
