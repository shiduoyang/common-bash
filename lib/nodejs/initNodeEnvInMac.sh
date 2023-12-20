#!/bin/bash
## 在mac中初始化Node.js的开发环境

# 检查 Homebrew 是否已安装
if ! command -v brew >/dev/null; then
    echo "Homebrew not found. Installing Homebrew..."
    # 安装 Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed."
fi

# 验证 Homebrew 安装是否成功
if command -v brew >/dev/null; then
    echo "Homebrew installation was successful."
else
    echo "Homebrew installation failed."
fi


# 更新Homebrew的配方和包索引
brew update

# 声明一个包含所有需要软件包的数组
echo "start install base packages"
packages=(docker node.js mysql redis git)
# 循环遍历数组，检查每个软件包是否已安装，并在需要时安装它
for pkg in "${packages[@]}"; do
    if brew list --formula $pkg >/dev/null 2>&1; then
        echo "Package '$pkg' is already installed."
    else
        echo "Installing package '$pkg'..."
        brew install $pkg
    fi
done
brew services start mysql
brew services start redis

## 安装IDE
echo "start install ide"
brew cask install visual-studio-code

## 安装typescript
echo "start install typescript about"
npm install -g typescript