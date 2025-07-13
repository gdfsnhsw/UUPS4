# 使用最新稳定版Alpine镜像
FROM alpine:3.19

# 安装Python3并清理缓存（合并所有操作到单层）
RUN apk update && \
    apk add --no-cache python3 && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    rm -rf /var/cache/apk/*

# 设置工作目录
WORKDIR /app

# 复制脚本并设置权限
COPY uups4.py .
RUN chmod +x uups4.py

# 暴露UDP端口
EXPOSE 987/udp

# 启动脚本
ENTRYPOINT ["python", "./uups4.py"]
