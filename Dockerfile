# 构建阶段
FROM python:3.9-alpine AS builder

WORKDIR /app
COPY uups4.py .

# 清理不必要的缓存文件
RUN find / -type d -name __pycache__ -exec rm -rf {} + && \
    rm -rf /var/cache/apk/*

# 最终阶段 - 使用更小的基础镜像
FROM alpine:3.16

# 安装最小化Python运行时
RUN apk add --no-cache python3 py3-pip && \
    # 清理缓存
    rm -rf /var/cache/apk/*

WORKDIR /app

# 从构建阶段复制脚本
COPY --from=builder /app/uups4.py .

# 设置权限
RUN chmod +x uups4.py

# 暴露UDP端口
EXPOSE 987/udp

# 设置容器入口
CMD ["python3", "./uups4.py"]
