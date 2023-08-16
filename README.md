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
Just call `require("relpointers").setup({})` function in your config file.

## Configuration
```lua
require("relpointers").setup({
    amount = 2, -- amount of pointers
    distance = 5, -- distance between pointers

    hl_properties = { underline = true }, 

    enable_autocmd = true,
    autocmd_pattern = "*",
    white_space_rendering = "\t\t\t\t\t", -- how should the pointer look if there is no symbols on the line
})
```
