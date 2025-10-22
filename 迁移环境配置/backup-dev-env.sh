#!/bin/bash
# ========================================
# 🧩 前端开发者 Mac 环境迁移脚本 - 备份部分
# 作者：ChatGPT（为 willowramirez 定制）
# ========================================

set -e

BACKUP_DIR="$HOME/DevBackup_$(date +%Y%m%d_%H%M)"
mkdir -p "$BACKUP_DIR"/{brew,npm,vscode,config,ssh}

echo "🚀 开始备份开发环境到：$BACKUP_DIR"

# 1️⃣ Brew 包
if command -v brew &>/dev/null; then
  echo "🍺 备份 Homebrew 包..."
  brew bundle dump --file="$BACKUP_DIR/brew/Brewfile"
else
  echo "⚠️ 未检测到 Homebrew，跳过。"
fi

# 2️⃣ npm 全局包
if command -v npm &>/dev/null; then
  echo "📦 备份 npm 全局包..."
  npm list -g --depth=0 > "$BACKUP_DIR/npm/global-packages.txt" || true
fi

# 3️⃣ VSCode 插件与配置
if command -v code &>/dev/null; then
  echo "🧠 备份 VSCode 插件与配置..."
  code --list-extensions > "$BACKUP_DIR/vscode/extensions.txt"
  mkdir -p "$BACKUP_DIR/vscode/User"
  cp -r ~/Library/Application\ Support/Code/User/* "$BACKUP_DIR/vscode/User/" 2>/dev/null || true
else
  echo "⚠️ 未检测到 VSCode，跳过。"
fi

# 4️⃣ 常见配置文件
echo "⚙️ 备份配置文件..."
for file in ~/.zshrc ~/.bashrc ~/.gitconfig ~/.npmrc ~/.pnpmrc ~/.yarnrc ~/.gitignore_global ~/.p10k.zsh; do
  [ -f "$file" ] && cp "$file" "$BACKUP_DIR/config/" || true
done

# 5️⃣ SSH 密钥
if [ -d ~/.ssh ]; then
  echo "🔑 备份 SSH 配置（不含私钥内容）..."
  cp ~/.ssh/config "$BACKUP_DIR/ssh/config" 2>/dev/null || true
  cp ~/.ssh/*.pub "$BACKUP_DIR/ssh/" 2>/dev/null || true
fi

# 6️⃣ 终端与工具配置
echo "💻 备份 oh-my-zsh / starship / alacritty 等配置..."
[ -d ~/.oh-my-zsh ] && cp -r ~/.oh-my-zsh "$BACKUP_DIR/config/oh-my-zsh"
[ -f ~/.config/starship.toml ] && mkdir -p "$BACKUP_DIR/config/starship" && cp ~/.config/starship.toml "$BACKUP_DIR/config/starship/"

echo "✅ 备份完成！文件位于：$BACKUP_DIR"
echo "📦 建议使用 iCloud / AirDrop / USB 拷贝该目录到新电脑。"
