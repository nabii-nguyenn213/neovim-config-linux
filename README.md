# neovim-config-linux

- Create a folder locates at `/home/user/.config/nvim/`. Clone the repository in that folder, make sure the structure
as below : 
```
/home/user/.config/nvim/
    ├── coc-settings.json
    ├── init.vim
    ├── lua/
    ├── plugged/
    ├── settings/
```

- Requirement : Git, Nodejs, Python [pynvim], ... (For more information just run `:checkhealth`)

- Run `:checkhealth` to see if everything is set up correctly.
- Run `:PlugInstall` to install Plugins in the folder `/home/user/.config/nvim/plugged`. May need to create `plugged/` folder inside the neovim config folder (run `mkdir ~/.config/nvim/plugged/` in the terminal). 
    - Uncomment all the plugins you don't need and run `:PlugClean` to delete those plugins. 

- For **Coc Configuration** : run `:CocInstall ...` (e.g `:CocInstall pyright`)
- For **Tree-sitter Configuration** : run `TSInstall ...` (e.g `:TSInstall python`)

