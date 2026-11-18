#!/usr/bin/env bash
# 玑衡 · A股量化资讯工作台 —— 一键本地启动脚本
# 用法：./start.sh [端口]（默认 8000）
set -e

PORT="${1:-8000}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 优先用系统 python3，找不到则提示
PY="$(command -v python3 || true)"
if [ -z "$PY" ]; then
  echo "未找到 python3，请先安装 Python 3。" >&2
  exit 1
fi

echo "=============================================="
echo "  玑衡 · A股量化资讯工作台"
echo "=============================================="
echo "  本地地址 : http://localhost:${PORT}"
echo "  停止服务 : 按 Ctrl+C"
echo "  （行情与快讯直接来自东方财富公开接口，需联网）"
echo "=============================================="

cd "$DIR"
# 自动打开浏览器（macOS / Linux 通用，失败不阻塞）
( sleep 1; command -v open >/dev/null 2>&1 && open "http://localhost:${PORT}" ) &
( sleep 1; command -v xdg-open >/dev/null 2>&1 && xdg-open "http://localhost:${PORT}" ) &

exec "$PY" -m http.server "$PORT" --bind 127.0.0.1
