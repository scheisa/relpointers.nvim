# relpointers.nvim

## Instalation
[lazy.nvim](https://github.com/folke/lazy.nvim)
```lua
{ "scheisa/relpointers.nvim" }
```

[packer.nvim](https://github.com/wbthomason/packer.nvim)
```lua
use { "scheisa/relpointers.nvim" }
```

## Configuration
```lua
require("relpointers").setup({
    amount = 2,
    distance = 5,

    hl_properties = { underline = true },

    enable_autocmd = true,
    autocmd_pattern = "*",
    white_space_rendering = "\t\t\t\t\t",
})
```
