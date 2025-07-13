# 使用更小的基础镜像
FROM alpine:3.18

# 单层操作：安装依赖并清理缓存
RUN echo "https://dl-cdn.alpinelinux.org/alpine/v3.18/main" > /etc/apk/repositories \
 && echo "https://dl-cdn.alpinelinux.org/alpine/v3.18/community" >> /etc/apk/repositories \
 && apk add --no-cache \
    # 直接安装所需软件（去掉虚拟包）
    python3 \
    # 添加重试机制
    && for i in 1 2 3 4 5; do apk update && break || sleep 5; done \
    # 创建符号链接
    && ln -sf /usr/bin/python3 /usr/bin/python \
    # 清理缓存（Alpine自动处理，但为保险保留）
    && rm -rf /var/cache/apk/*

# 设置工作目录
WORKDIR /app

# 复制脚本并设置权限
COPY uups4.py ./
RUN chmod +x uups4.py

# 暴露UDP端口
EXPOSE 987/udp

# 使用exec形式启动
ENTRYPOINT ["python", "./uups4.py"]
