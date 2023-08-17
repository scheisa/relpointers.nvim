# relpointers.nvim

The goal of this plugin is to make relative line jumps easier. You can specify
the number of pointers and the distance between them, change the hl group to
your liking (any of the `vim.api.nvim_set_hl()` settings should work), the default
autocmd is provided (you can change its pattern if you want).

## Demo

https://github.com/scheisa/relpointers.nvim/assets/108890393/b28dc50e-dcea-4250-9751-4c306d3bb6cf

## Instalation
[lazy.nvim](https://github.com/folke/lazy.nvim)
```lua
{ "scheisa/relpointers.nvim" }
```

[packer.nvim](https://github.com/wbthomason/packer.nvim)
```lua
use { "scheisa/relpointers.nvim" }
```

## Usage 
Just call `require("relpointers").setup({})` function in your config file.Use `require("relpointers").disable()` to disable the plugin.

## Configuration
```lua
require("relpointers").setup({
    amount = 2,
    distance = 5,

    hl_properties = { underline = true },

    pointer_style = "line region",

    white_space_rendering = "\t\t\t\t\t",

    virtual_pointer_position = -4,
    virtual_pointer_text = "@",

    enable_autocmd = true,
    autocmd_pattern = "*",
})
```
### amount
Amount of pointers below or under cursor (multiply by 2 to see actuall amount)
### distance 
Distance between pointers
### hl_properties = {}
Any arguments which work with `vim.api.nvim_set_hl()` would work
### pointer_style
Currently there is 2 styles - "line region" and "virtual"
#### "line region"
 **currently works only with the whole line**

You can specify region which will be highlighted on the line, (1 for the whole
line)

Use `white_space_rendering` to specify how lines without any symbols should be
displayed. Default value is 5 tabs
#### "virtual"
Uses `vim.api.nvim_buf_set_extmark()` to work.

Position could be specified, default one is located in signcolumn (-4), use
`virtual_pointer_position` to change it.

You can change its text by using `virtual_pointer_text`.

You still can use`hl_properties` to change highlights ( I recommend to use
something like `hl_properties = { link = "Visual" }` or `hl_properties = { link = "IncSearch" }`
instead of default underline highlight)

### enable_autocmd 
Enables default autocmd
### autocmd_pattern
You could specify a pattern for default autocmd. 
Example:
- "*" - will work with any filetypes
- "*.lua" - will work only with `.lua` extension



## NOTE
> - this plugin uses `vim.fn.clearmatches()` so if you are using default autocmd
all matches would be cleared on every cursor move 

> - idea of this plugin is not mine, I saw a basic implementation of this 
in ThePrimeagen's discord unfortunally I can't find it now to specify who is the
original authour. I rewrote it, implemented some of my personal ideas and 
made it to be a plugin-like instead of lua function.
