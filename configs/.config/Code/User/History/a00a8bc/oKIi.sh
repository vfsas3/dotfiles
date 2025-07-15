#!/bin/bash

# Caminho do backup local
BACKUP_DIR="$HOME/dotfiles-backup"

# Caminho do repositório Git
REPO_DIR="$HOME/dotfiles-repo"

# URL do teu repositório Git
REPO_URL="git@github.com:vfsas3/dotfiles.git" # <- muda isto

echo "🚀 A iniciar backup do setup..."

# Cria diretório se não existir
mkdir -p "$BACKUP_DIR/configs"

# Copiar dotfiles
cp ~/.bashrc ~/.zshrc ~/.profile ~/.gitconfig ~/.xinitrc ~/.tmux.conf "$BACKUP_DIR/" 2>/dev/null
cp -r ~/.config "$BACKUP_DIR/configs"

# Inicializa ou atualiza repositório Git
if [ ! -d "$REPO_DIR/.git" ]; then
    echo "📦 Clonando repositório Git..."
    git clone "$REPO_URL" "$REPO_DIR"
fi

# Limpa conteúdo antigo e copia novo backup
rm -rf "$REPO_DIR"/*
cp -r "$BACKUP_DIR"/* "$REPO_DIR"

# Commit e push
cd "$REPO_DIR"
git add .
git commit -m "🧭 Backup automático em $(date +'%Y-%m-%d %H:%M:%S')" || echo "Nenhuma alteração nova."
git push origin main

echo "✅ Backup enviado para o GitHub!"
