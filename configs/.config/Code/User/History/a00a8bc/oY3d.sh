#!/bin/bash

# Caminho onde o backup será guardado
BACKUP_DIR="$HOME/hypr-backup"
BACKUP_TAR="$HOME/hyprland-backup-$(date +%F).tar.gz"

echo "📦 A criar backup em: $BACKUP_DIR"
mkdir -p "$BACKUP_DIR/configs"

# 1. Configs principais
echo "🛠️  A copiar configurações do Hyprland e utilitários..."
cp -r ~/.config/hypr ~/.config/waybar ~/.config/rofi ~/.config/dunst ~/.config/kitty "$BACKUP_DIR/configs" 2>/dev/null

# 2. Wallpapers
echo "🖼️  A copiar wallpapers..."
find ~/.config/hypr -iname 'wall*' -exec cp {} "$BACKUP_DIR/" \; 2>/dev/null

# 3. Fonts, temas e ícones
echo "🎨 A copiar fontes, ícones e temas..."
cp -r ~/.local/share/fonts ~/.themes ~/.icons "$BACKUP_DIR/" 2>/dev/null

# 4. Shell configs
echo "💻 A copiar configs do shell..."
cp ~/.bashrc ~/.zshrc ~/.profile ~/.bash_profile "$BACKUP_DIR/" 2>/dev/null

# 5. Lista de pacotes instalados (Arch-based)
echo "📄 A exportar lista de pacotes..."
pacman -Qe > "$BACKUP_DIR/pkglist.txt" 2>/dev/null
yay -Qe > "$BACKUP_DIR/aurlist.txt" 2>/dev/null

# 6. Criar arquivo comprimido
echo "📦 A empacotar backup..."
tar -czf "$BACKUP_TAR" -C "$HOME" hypr-backup

# 7. Limpeza
rm -rf "$BACKUP_DIR"

echo "✅ Backup criado com sucesso: $BACKUP_TAR"
