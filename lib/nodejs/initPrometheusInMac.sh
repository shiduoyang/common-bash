#!/bin/bash
# 在mac中安装prometheus

brew search prometheus
brew install prometheus
brew services start prometheus
echo "prometheus init successed, open http://localhost:9090"