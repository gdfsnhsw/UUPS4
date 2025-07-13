# 使用最小Alpine镜像
FROM alpine:3.18

# 安装Python3（不安装pip和额外依赖）
RUN apk add --no-cache python3 && \
    # 创建python命令别名
    ln -s /usr/bin/python3 /usr/bin/python

# 设置工作目录
WORKDIR /app

# 复制脚本并设置权限
COPY --chmod=755 uups4.py .

# 暴露UDP端口
EXPOSE 987/udp

# 启动脚本
ENTRYPOINT ["python", "./uups4.py"]
