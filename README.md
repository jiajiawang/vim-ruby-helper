# ruby-helper.vim

A vim plugin that provides helper functions of ruby editing.

## Installation

Use [Vundle](https://github.com/gmarik/Vundle.vim)

Add `Plugin 'jiajiawang/vim-ruby-helper'` to your vimrc file.

Then run `:PluginInstall`

## Usage

### String Symbol Swith
`<leader>rss` - Converts string/symbol under cursor to symbol/string

`'foobar'` becomes `:foobar`

`:foobar` becomes `'foobar'`

### Hash Syntax Swith
`<leader>rhs` - Converts between old and new hash syntax

`'foo' => 'bar'` becomes `foo: 'bar'`

`:foo => 'bar'` becomes `foo: 'bar'`

`foo: 'bar'` becomes `:foo => 'bar'`

