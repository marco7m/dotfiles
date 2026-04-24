# Dotfiles

Dotfiles gerenciados com [chezmoi](https://www.chezmoi.io/) para montar um ambiente de desenvolvimento Linux com Bash, Neovim, Vim, tmux e Git.

## O que este repositório configura

- `~/.bashrc`
- `~/.config/nvim`
- `~/.vimrc` e `~/.vim`
- `~/.tmux.conf`
- `~/.gitconfig`

## Instalação do zero

Os passos abaixo assumem Ubuntu/Debian. Em outra distro, instale os pacotes equivalentes.

### 1. Instale os pacotes de sistema

```bash
sudo apt update
sudo apt install -y \
  git curl build-essential unzip tar \
  ripgrep fd-find \
  tmux vim ranger xterm \
  universal-ctags cscope \
  libnotify-bin meld
sudo snap install nvim --classic
```

Notas:

- `nvim` deve ser `0.11.x` ou superior. Este repositório foi validado com `NVIM v0.11.6`.
- `universal-ctags` é importante para o `tagbar`, especialmente em projetos Rust.
- `ranger`, `xterm`, `cscope` e `meld` não são obrigatorios para abrir o shell, mas sao esperados por partes da configuracao.

### 2. Instale e aplique o chezmoi

Se ainda nao tiver o `chezmoi` instalado:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply https://github.com/marco7m/dotfiles.git
```

Se ja tiver o `chezmoi` instalado:

```bash
chezmoi init --apply https://github.com/marco7m/dotfiles.git
```

### 3. Reabra o shell

```bash
exec bash -l
```

### 4. Crie o arquivo local opcional

Este repositório nao versiona configuracoes locais da maquina. Se quiser um lugar para aliases, tokens, paths extras ou segredos locais:

```bash
touch ~/.bashrc.my
```

### 5. Bootstrap do Vim

O `vim-plug` ja faz parte do repositório, mas os plugins precisam ser baixados na primeira maquina:

```bash
vim +PlugInstall +qall
```

### 6. Bootstrap do Neovim

Abra o Neovim pela primeira vez:

```bash
nvim
```

Depois rode estes comandos dentro do Neovim:

```vim
:Lazy restore
:TSUpdate
:checkhealth
```

Notas:

- `:Lazy restore` e o passo mais importante em maquina nova. Ele garante que os plugins fiquem exatamente nas versoes de `lazy-lock.json`.
- `:TSUpdate` atualiza os parsers ja instalados pelo `nvim-treesitter`.
- Os LSPs definidos em `mason-lspconfig` sao instalados automaticamente. Se quiser conferir o estado deles, rode `:Mason`.
- Se voce usa GitHub Copilot, finalize a autenticacao depois com `:Copilot setup`.

### 7. Bootstrap do tmux

Abra o `tmux` uma vez:

```bash
tmux
```

Dentro do tmux, instale os plugins do TPM com:

```text
Ctrl-b I
```

## Sequencia curta para maquina nova

Se eu estiver configurando uma maquina nova do zero, a sequencia que devo seguir e esta:

```bash
sudo apt update
sudo apt install -y git curl build-essential unzip tar ripgrep fd-find tmux vim ranger xterm universal-ctags cscope libnotify-bin meld
sudo snap install nvim --classic
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply https://github.com/marco7m/dotfiles.git
exec bash -l
touch ~/.bashrc.my
vim +PlugInstall +qall
nvim
```

Dentro do `nvim`:

```vim
:Lazy restore
:TSUpdate
:checkhealth
```

Depois:

```bash
tmux
```

E dentro do `tmux`:

```text
Ctrl-b I
```

## Atualizar uma maquina existente

```bash
chezmoi update
chezmoi apply
```

Comandos uteis:

```bash
chezmoi cd
chezmoi status
chezmoi diff
chezmoi apply --dry-run
```

## Notas importantes

- O `~/.bashrc` tenta integrar `asdf`, Homebrew, Cargo e `nvm`, mas agora so ativa essas integracoes se elas existirem na maquina.
- O arquivo `~/.bashrc.my` e opcional e serve para configuracoes especificas da maquina que nao devem ir para o repositório.
- O Neovim deste repositório depende do `lazy-lock.json`. Em maquina nova, prefira `:Lazy restore` antes de qualquer `:Lazy update`.
- Se algum plugin do Neovim ficar fora de sincronia com o lockfile, `:Lazy restore` deve ser a primeira tentativa de correção.

## Softwares recomendados

- [bat](https://github.com/sharkdp/bat)
- [dust](https://github.com/bootandy/dust)
- [eza](https://github.com/eza-community/eza/)
- [btop](https://github.com/aristocratos/btop)
- [Gitnuro no Flathub](https://flathub.org/apps/com.jetpackduba.Gitnuro)
- [Gittyup no Flathub](https://flathub.org/apps/com.github.Murmele.Gittyup)
