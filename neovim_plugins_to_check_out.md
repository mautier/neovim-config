See [awesome-neovim](https://github.com/rockerBOO/awesome-neovim) for many plugins.

# To check out
- [Gitsigns](https://github.com/lewis6991/gitsigns.nvim): git integration (extends vim-fugitive).
- [Trouble](https://github.com/folke/trouble.nvim): displays LSP info, compilation errors, etc.
    - Unclear if specific such plugins need to be used?
    - Integrates with telescope too.
- [Debug Adapter Protocol](https://github.com/mfussenegger/nvim-dap): drive a debugger (run, break, inspect, etc) from neovim.
- [which-key.nvim](https://github.com/folke/which-key.nvim): similar to spacemacs, shows a list of `key -> action` when you hesitate.
- [nvim-window](https://gitlab.com/yorickpeterse/nvim-window): like easymotion and hop, but for windows within a tab!
- [stabilize.nvim](https://github.com/luukvbaal/stabilize.nvim): prevent annoying motion when opening a quick-fix window or similar.
    - May not be so useful when using telescope's overlay.

# LSP

The LSP situation remains complicated.

- Neovim 0.5 bundles an LSP client.
- Claimed by the Neovim website to be less feature-rich and out-of-the-box than [CoC.nvim](https://github.com/neoclide/coc.nvim).
    - CoC is in typescript, urgh.
    - Also, it's obsessed with VS Code.
- See [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) and its wiki for details on to configure many language servers.

## Rust

- An example setup: [https://github.com/EdenEast/nightfox.nvim/issues/5]

# Colorschemes

- [marko-cerovac/material.nvim](https://github.com/marko-cerovac/material.nvim)
    - Integrates with maaaaany plugins: treesitter, LSP stuff, git stuff, telescope, nerdtree, etc.
    - Multiple styles: deepocean, palenight, and darker look pretty good.
- [rose-pine/neovim](https://github.com/rose-pine/neovim)
    - Looks pretty nice.
    - Many integrations with other neovim plugins.
    - Fancy website & many integrations outside of vim.
- [EdenEast/nightfox.nvim](https://github.com/EdenEast/nightfox.nvim)
    - Pretty stuff.
    - Lots of vim plugin integrations.

# Fonts

On nerdfonts, look for DejaVu Mono.

# Code forges

- [octo.nvim](https://github.com/pwntester/octo.nvim): fetch github pull requests, interact with them, review them.
    - Look absolutely amazing; maybe a similar thing exists for gerrit?

# Clipping / registers

- [nvim-neoclip.lua](https://github.com/AckslD/nvim-neoclip.lua): displays the contents of the various registers in telescope

# File browsing

- Telescope has a simple file browser.
- [chadtree](https://github.com/ms-jpq/chadtree): an improvement over NERDTree (allegedly).

# Running code in neovim

- [sniprun](https://github.com/michaelb/sniprun): visually select a chunk of code, and compile/run it!
    - Cool when struggling with pandas and numpy probably?

- [vim-ultest](https://github.com/rcarriga/vim-ultest): run unit tests and display markers showing what passed/failed.

# Containers

See [this section](https://github.com/rockerBOO/awesome-neovim#remote-development).
