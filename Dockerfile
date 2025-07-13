# 使用更稳定的Alpine版本
FROM alpine:3.18

# 安装Python3 - 使用可靠的镜像源并添加重试机制
RUN echo "https://dl-cdn.alpinelinux.org/alpine/v3.18/main" > /etc/apk/repositories && \
    echo "https://dl-cdn.alpinelinux.org/alpine/v3.18/community" >> /etc/apk/repositories && \
    apk add --no-cache --virtual .build-deps curl && \
    for i in $(seq 1 5); do apk update && break || sleep 5; done && \
    apk add --no-cache python3 && \
    ln -sf /usr/bin/python3 /usr/bin/python && \
    apk del .build-deps && \
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
