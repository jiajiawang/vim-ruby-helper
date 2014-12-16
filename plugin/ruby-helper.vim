if exists("g:loaded_ruby_helpers") || &cp || v:version < 700
  finish
endif
let g:loaded_ruby_helpers = 1

nmap <silent> <leader>rss :call rubyhelper#SymbolStringSwitch()<CR>
nmap <silent> <leader>rhs :call rubyhelper#HashSyntaxSwitch()<CR>
