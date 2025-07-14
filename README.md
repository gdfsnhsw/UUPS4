# UUPS4
1.创建docker-compose.yml
   ```bash
services:
  uups4:
    image: gdfsnhsw/uups4:latest
    container_name: uups4
    restart: always
    environment:
      - TZ=Asia/Shanghai
    network_mode: "host"
   ```
2.使用 Docker Compose 启动插件
   ```bash
   docker compose up
   ```
3.日志
   ```bash
   docker logs -f uups4
   ```
