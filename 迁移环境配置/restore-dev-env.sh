#!/bin/bash
###
 # @LastEditors: Tao Yang
 # @Description: 暂无描述
 # @FilePath: /flutter-doc/restore-dev-env.sh
 # @Date: 2025-10-22 10:32:35
 # @LastEditTime: 2025-10-22 10:32:35
 # @Author: Tao Yang
### 

# ========================================
# 🔁 前端开发者 Mac 环境迁移脚本 - 恢复部分
# ========================================

set -e

BACKUP_DIR="$1"

if [ -z "$BACKUP_DIR" ]; then
  echo "❌ 请提供备份目录路径，例如："
  echo "   ./restore-dev-env.sh ~/DevBackup_20251022_1030"
  exit 1
fi

echo "🚀 开始从 $BACKUP_DIR 恢复开发环境..."

# 1️⃣ 安装 Homebrew（如果未安装）
if ! command -v brew &>/dev/null; then
  echo "🍺 正在安装 Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# 2️⃣ 恢复 Brew 包
if [ -f "$BACKUP_DIR/brew/Brewfile" ]; then
  echo "📦 恢复 Homebrew 包..."
  brew bundle --file="$BACKUP_DIR/brew/Brewfile"
fi

# 3️⃣ 恢复 npm 全局包
if [ -f "$BACKUP_DIR/npm/global-packages.txt" ]; then
  echo "📦 恢复 npm 全局包..."
  grep '── ' "$BACKUP_DIR/npm/global-packages.txt" | awk '{print $2}' | cut -d@ -f1 | xargs -I {} npm install -g {}
fi

# 4️⃣ 恢复 VSCode
if [ -f "$BACKUP_DIR/vscode/extensions.txt" ]; then
  echo "🧠 恢复 VSCode 插件..."
  cat "$BACKUP_DIR/vscode/extensions.txt" | xargs -n 1 code --install-extension
  cp -r "$BACKUP_DIR/vscode/User/"* ~/Library/Application\ Support/Code/User/ 2>/dev/null || true
fi

# 5️⃣ 恢复配置文件
echo "⚙️ 恢复配置文件..."
cp -r "$BACKUP_DIR/config/"* ~/

# 6️⃣ 恢复 oh-my-zsh / starship 等
[ -d "$BACKUP_DIR/config/oh-my-zsh" ] && cp -r "$BACKUP_DIR/config/oh-my-zsh" ~/.oh-my-zsh
[ -f "$BACKUP_DIR/config/starship/starship.toml" ] && mkdir -p ~/.config && cp "$BACKUP_DIR/config/starship/starship.toml" ~/.config/

echo "✅ 环境恢复完成！请重启终端以加载新配置。"
