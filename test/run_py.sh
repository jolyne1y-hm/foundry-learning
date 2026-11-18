#!/bin/bash
# 1. 切换到项目根目录
cd /home/jolyne1y/ethernaut-challenges

# 2. 用虚拟环境的 python 运行传入的参数 ($1 代表传进来的参数 x)
./.venv/bin/python3 -u test/exp_1.py "$1"