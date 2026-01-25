# Dotfiles

Meus dotfiles gerenciados com [chezmoi](https://www.chezmoi.io/) para configurar um ambiente de desenvolvimento Linux completo.

## Instalação

### Primeira vez (nova máquina)

```bash
# Instalar chezmoi e aplicar dotfiles
chezmoi init https://github.com/SEU_USUARIO/dotfiles.git
chezmoi apply
```

Ou instalação rápida em uma única linha:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply SEU_USUARIO
```

### Manter atualizado

```bash
# Atualizar dotfiles do repositório remoto
chezmoi update

# Aplicar mudanças
chezmoi apply
```

## O que está incluído

- **Bash** - Configuração com integrações (asdf, Homebrew, Cargo, NVM)
- **Vim** - Setup completo com vim-plug e plugins para desenvolvimento
- **Neovim** - Configuração moderna em Lua com lazy.nvim, LSP, Treesitter
- **Tmux** - Keybindings customizados e status bar personalizada
- **Git** - Aliases úteis e configuração de merge/diff tool

## Comandos úteis do chezmoi

```bash
# Navegar até o diretório do repositório
chezmoi cd

# Ver status das mudanças
chezmoi status

# Editar um arquivo de configuração
chezmoi edit ~/.vimrc

# Aplicar mudanças após editar
chezmoi apply

# Adicionar um novo dotfile
chezmoi add ~/.novo_arquivo

# Ver diferenças antes de aplicar
chezmoi diff

# Ver o que será aplicado
chezmoi apply --dry-run
```

## Workflow para atualizar os dotfiles

Após fazer mudanças nos dotfiles:

```bash
# 1. Navegar até o repositório
chezmoi cd

# 2. Ver o que mudou
chezmoi status

# 3. Ver diferenças detalhadas (opcional)
chezmoi diff

# 4. Commit e push das mudanças
git add .
git commit -m "Descrição das mudanças"
git push
```

## Softwares Recomendados

- [bat](https://github.com/sharkdp/bat)
- [flatpak install flathub com.jetpackduba.Gitnuro](https://flathub.org/apps/com.jetpackduba.Gitnuro)
- [flatpak install flathub com.github.Murmele.Gittyup](https://flathub.org/apps/com.github.Murmele.Gittyup)
