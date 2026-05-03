# MinVim

My fast simple minimal well-structured NeoVim configuration.

**Rather making compromises than bloating and slowing down.**

This NeoVim configuration was built with simplicity in mind. It uses a mostly
minimal set of plugins (specs) and is in my best attempt structured with
performance in mind. It is a code division, yet easification of
`kickstart.nvim`, which was used as an inspiration. Lua modules are split by
meaningful human context, not technical designs.

Not meaningful configuration was avoided, to reduce the technical footprint/debt
and ensure very high cognitive and systematic compatbiility to vanilla (Neo)Vim.
This configuration leverages `netrw` and native tabs and it just uses
`telescope.nvim` to navigate beyond those capabilities (to find files or
buffers).

> An idiot admires complexity, a genius admires simplicity.
>
> - Terry A. Davis

## Features

- State of the art plugin system using `lazy.nvim` with folke's clear
  suggestions using the one-spec-per-file approach and prefering `main`/`opts`
  over the `config` callback, open Lazy via `<Space>l`
- State of the art fuzzy finding using `telescope.nvim` via `ripgrep` with
  improved defaults such as a sane dynamic layout strategy and a consistent
  result ordering, `<Space>b` to navigate buffers, `<Space>e` to find files and
  `<C-7>` to live grep
- Smart syntax highlighting and indenting using `nvim-treesitter`
- With `dprint` or `prettier` configurations in the `pwd` ancestor tree as well
  as when editing files with advanced formatting requirements (where
  `nvim-treesitter`'s experimental indentation just isn't good enough anymore)
  the built-in `formatprg` and `equalprg` is set to launch the preferred
  external formatter, respectively
- Free AI powered code suggestions using Windsurf (opt-in, boot via `<Space>me`,
  authenticate via `<Space>ma`)
- Free inline translations via DeepL (opt-in, authenticate by exporting your
  `DEEPL_AUTH_KEY` before launching `nvim`, then translate in visual mode via
  `<leader>trxx` where `xx` is your target language code, i.e. `<leader>tren`
  for English or `<leader>trde` for German)
- Save all buffers with persistent auto session storage (`Session.vim`) as well
  as hidden buffer clean up when hitting `<Space>ss`
- Bridges for `firenvim` and `vscode-neovim` to use NeoVim in the browser and in
  VSCode/VSCodium/Windsurf
- Overly simplified user commands (`cmds`) to substitute otherwise necessary
  dependencies
- A backed-in lua util library for common tasks (`utils`)
- **Zen focus**, no file trees, uses `netrw` bindings explore files as well as
  `telescope.nvim` bindings to find files, `<leader>ss` saves all buffers and
  closes them when they are not visible to keep your buffer management clean
  (use window splitters or native tabs to keep relevant buffers open, or save
  single buffers with `<C-s>`)
- **LSP free** by design, because LSPs are too slow and complex, use an IDE
  instead, I want my terminal to be snappy and fast
- A simple `.vimrc` for you to upload to remote systems to let `vim` in your SSH
  sessions behave more like your `nvim`
- Also compatible with `tmux`, use `<C-t>` as your PREFIX in `tmux`, so that you
  can rely on the `<C-b>` in remote sessions where you should use `vim`, not
  `nvim`
- Smart theming adapts to system brightness with
  [Tonsky highlights](https://tonsky.me/blog/syntax-highlighting/) for light
  mode

## Installation + Quickstart

> [!CAUTION]
> Before you start backup your `$HOME/.config/nvim` directory. Please read the
> `./install` script before running it! I'm not responsible for any damage. This
> repository is primary for me to backing up my personal custom configuration,
> but maybe it is beneficial to you.

You should fork this repo in a seperate branch, so you can adjust my
configuration for your personal needs.

### Ensure dependencies

Ensure you have:

- NeoVim (`nvim`)
- tree (`tree`) used by `GitTree`
- ripgrep (`rg`) used by `telescope`

### Clone configuration

```sh
git clone git@github.com:<yourusername>/minvim.git
cd minvim
git checkout -b custom
./install
```

### Ensure additional formatters

To support advanced formatting beyond treesitter, please install

- `dprint` for markdown (global), json and web files in general (project only)
- `prettier` optionally for markdown (global) and web files all galore (project
  only)
- `shfmt` for sh files
- `rust` for rust files
- `go` for go files
- `zig` for zig files
- `flutter` for dart files

### Make an alias launcher

To automatically reload the persistent session that is created when hitting
`<Space>ss`, please add this alias your rc files:

```sh
alias vim='{ f() { command -v nvim >/dev/null 2>&1 && { export NVIM_APPNAME="nvim" && export DEEPL_AUTH_KEY="$(sshstore deepl-key)" && { test "$#" -eq 0 && nvim +"sil! so Session.vim" || nvim "$@"; }; } || vim "$@"; }; }; f'
```

> [!NOTE]
> `sshstore` is a function that I have written to protect my API keys using the
> `ssh-agent`. You can see its implementation
> [here](https://gist.github.com/martin-braun/ffda926798d6a9334d92ab6e867252ce).
> You can also just store your API key in plain text, since the API is free, but
> it is not recommend. If you skip setting `DEEPL_AUTH_KEY`, `deepl.vim` will
> not load which is a fine option if you don't need translations integrated into
> NeoVim. `deepl.vim` is also compatible with Visual Studio Code or one of its
> supported forks, but you have to launch the IDE from within `nvim`, unless you
> set the `DEEPL_AUTH_KEY` environment variable in an alias that covers the
> `code`/`windsurf` CLI launcher as well. This all leads to the fact that
> launching any VSCode forks from your App Drawer will disable the plugin.

### Finalize

Restart your terminal and launch `vim` (your custom alias) to launch
`nvim +"sil! so Session.vim"` which sources a local session if it exists. From
there, simply **f**ind your **k**eymaps via `<Space>fk` or just explore
[keymaps.lua](./lua/keymap.lua) and
[telescope_maps.lua](./lua/maps/telescope_maps.lua)

> [!TIP]
> If you put `Session.vim` into your (global) `.gitignore`, the permanent
> session storage does not become part of your working changes in any local git
> repository.

## Update

Updating from upstream means to pull and merge my `master` into your `custom`
branch. You should resolve any conflicts afterwards.

_t.b.d_

## Compatibility Bridges

### VSCode

This configuration is compatible with
[vscode-neovim/vscode-neovim](https://github.com/vscode-neovim/vscode-neovim),
but it recommends you to use [these keybindings](.vscode/keybindings.json) and
[these settings](.vscode/settings.json) in VSCode to make all work properly.

Your VSCode will share the **Zen focus** mentality by following the concept of
this configuration. Tabs are treated like buffers and native tabs in NeoVim and
share the same keybindings. Tabs are hidden, `<leader>b` will browse these.
`<leader>ss` will save all tabs and close them when they are not visible to keep
your tab management clean. Use window splitters to keep relevant buffers open or
fallback to the traditional `<C-s>` binding.

> [!CAUTION]
> Trusted mode in VSCode is disabled, you want to browse and validate unknown
> projects in NeoVim, not your full-fledged IDE.

Next, please install the [recommend extensions](.vscode/extensions.json). Simply
open this repository in VSCode and accept installing suggested extensions to
make everything work properly.

> [!TIP]
> You can link the configurations to all IDEs to keep it in sync with this
> repository:
>
> I.e. on macOS:
>
> ```sh
> ln -sf "$(pwd)/.vscode/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"
> ln -sf "$(pwd)/.vscode/keybindings.json" "$HOME/Library/Application Support/Code/User/keybindings.json"
> ln -sf "$(pwd)/.vscode/settings.json" "$HOME/Library/Application Support/VSCodium/User/settings.json"
> ln -sf "$(pwd)/.vscode/keybindings.json" "$HOME/Library/Application Support/VSCodium/User/keybindings.json"
> ln -sf "$(pwd)/.vscode/settings.json" "$HOME/Library/Application Support/Windsurf/User/settings.json"
> ln -sf "$(pwd)/.vscode/keybindings.json" "$HOME/Library/Application Support/Windsurf/User/keybindings.json"
> ```

> [!WARNING]
> The Cascade window in Windsurf has no proper focus clause for the keybinding
> setup, so leader keyboard shortcuts will only work in the editor window while
> it's open. Cascade can be toggled via `<C-l>`.

### FireNvim

This configuration is compatible with
[glacambre/firenvim](https://github.com/glacambre/firenvim). To install the
browser bridge and transform a textarea to a Neovim window, you have to trigger
it with (`<C-e>` / `<M-e>`) in the browser (which is changable in the browser
settings.

Keybindings for tabs, `netrw` as well as formatters are disabled in this mode.
The plugin always needs to load to ensure it being installed prior browser
usage, since it can't hook nvim into the browser before that.

## FAQ

### How to hide files ignored by `.gitignore` when doing `<C-e>` (`netrw`)?

You can't. I tried to use `git ls-files` to obtain the unignored file tree and
feed it into `vim.g.netrw_list_hide` (see [netrw.lua](./lua/netrw.lua), however
`netrw_list_hide` treats all the files as patterns which makes it insanely slow
on code bases with lots of unignored files such as build artifacts.

It was so depressing, that I understood why people end up replacing `netrw` with
something with more feature rich that comes with the ability to hide git-ignored
files.

Since this configuration aims to be very dependency-slim and bloat-free, I wrote
a user command to complement the lack of the feature in `netrw` with a
compromise:

Wanting to explore the file tree without git-ignored files often means you know
about a common ancestorial directory, but don't know the filename (or you would
use `telescope`) or where it's located at (or you would use `netrw` witout the
feature). You know the file you search for is already part of your unignored
files, since you want to edit it in `nvim`, and thus it makes sense to see and
explore the tree with git-ignored files hidden.

Hit `<C-g>` or run `:GitTree` to run my
[GitTree user command](./lua/cmds/git_tree_user_command.lua), it will pipe the
`git ls-files` command to `tree` and then write it to a temporary buffer. You
cannot navigate in this buffer, so prepend the keystroke or append the command
with a number to specify how many levels deep you want to show the tree, i.e.
`8<C-g>` or `:GitTree 8` for 8 levels.

Pick a level you are confident about, from here search for your common ancester
and move along. To navigate to a file move the cursor to a file and hit `gf`.
For any other file options, simply `0f.y$` and use your terminal.

### How to search and replace all files in my working directory?

NeoVim doesn't offer this out of the box, so many plugins exist. However, it
wasn't hard to yet again roll my own
[Grep user command](./lua/cmds/grep_user_command.lua) to do this and I used
native functionality by leveraging the quickfix list to browse your results and
verify your changes.

Although, you can also use the command to only search, `telescope` is more handy
for plain search operations. However, the command starts to shine when you want
to try to mass replace in many files, but it requires caution: **Save all your
work (`<Space>ss`) and then commit your changes or at the very least stage (and
stash) them.** The command will open the buffer for each affected file and apply
the replacement without any prompt. If you save a buffer changes will be
applied. **If you save all buffers all changes will be applied.**

- To start, run the command like this: `:Grep! s/foo/bar/g **/*.lua` (replaces
  `foo` with `bar` in all `lua` files.
- Use `<Space>n` and `<Space>p` to navigate between changes
- Use `u` to undo changes on that particular buffer (or `<Space>X` to simply
  delete this buffer without applying the proposed changes
- Use `<Space>q` to close the quickfix list, the changed buffers remain open
- Use `<Space>l` to open the quickfix list and jump to the last selected change
  again
- To undo everything, just `ZQ` and restart `vim` which will reload your
  previous session before starting the entire operation
