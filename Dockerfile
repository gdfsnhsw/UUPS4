# 使用轻量级Python基础镜像
FROM python:3.9-alpine

# 设置工作目录
WORKDIR /app

# 复制脚本文件
COPY uups4.py .

# 安装依赖 (实际不需要额外依赖，这里保持最小化)
RUN chmod +x uups4.py

# 暴露UDP端口
EXPOSE 987/udp

# 设置容器入口
CMD ["python", "./uups4.py"]
