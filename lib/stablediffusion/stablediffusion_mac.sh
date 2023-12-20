#!/bin/bash
## mac安装stablediffusion的安装脚本

# 检查是否传入了路径参数
if [ -z "$1" ]; then
    echo "Error: 需要传入一个安装路径."
    echo "Usage: $0 <~/Documents/stabledf>"
    exit 1
fi

# 将参数1赋值给DIRECTORY变量
DIRECTORY=$1
echo "stablediffusion将安装至: $DIRECTORY"

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
packages=(cmake protobuf rust python@3.10 git wget)

# 循环遍历数组，检查每个软件包是否已安装，并在需要时安装它
for pkg in "${packages[@]}"; do
    if brew list --formula $pkg >/dev/null 2>&1; then
        echo "Package '$pkg' is already installed."
    else
        echo "Installing package '$pkg'..."
        brew install $pkg
    fi
done

# 设置Git的http.postBuffer为500MB来处理大文件下载
git config --global http.postBuffer 524288000

# 检查 DIRECTORY 目录是否存在
if [ ! -d "$DIRECTORY" ]; then
    echo "Directory '$DIRECTORY' does not exist. Creating it..."
    mkdir -p "$DIRECTORY"
else
    echo "Directory '$DIRECTORY' already exists."
fi

# clone stable-duffusion-webui
STABLE_DIFFUSION_WEBUI_PATH="$DIRECTORY/stable-diffusion-webui"
if [ ! -d "$STABLE_DIFFUSION_WEBUI_PATH" ]; then
    echo "stable-diffusion-webui folder does not exist within $DIRECTORY. Cloning..."
    git clone https://github.Com/AUTOMATIC1111/stable-diffusion-webui
else
    echo "stable-diffusion-webui folder already exists at $STABLE_DIFFUSION_WEBUI_PATH."
fi

cd "$STABLE_DIFFUSION_WEBUI_PATH"
echo "first start webui, installing"
./webui.sh