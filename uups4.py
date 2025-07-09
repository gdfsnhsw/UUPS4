#!/usr/bin/env python3
import socket
import logging

# 配置日志
logging.basicConfig(level=logging.INFO, format="%(asctime)s - %(levelname)s - %(message)s")

# 配置 UDP 监听地址和端口
UDP_IP = "0.0.0.0"
UDP_PORT = 987

# 响应模板
RESPONSE_TEMPLATE = (
    "HTTP/1.1 200 OK\r\n"
    "host-id:0123456789AB\r\n"
    "host-type:PS4\r\n"
    "host-name:MyPS4\r\n"
    "host-request-port:{port}\r\n"
    "device-discovery-protocol-version:00020020\r\n"
    "system-version:07020001\r\n"
    "running-app-name:Youtube\r\n"
    "running-app-titleid:CUSA01116\r\n"
    "\r\n"
)

def main():
    # 创建 UDP 套接字
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    try:
        sock.bind((UDP_IP, UDP_PORT))
        logging.info(f"Listening on {UDP_IP}:{UDP_PORT}")

        while True:
            try:
                # 接收数据
                data, addr = sock.recvfrom(1024)
                logging.info(f"Received message from {addr[0]}[{addr[1]}]: {data.decode('utf-8', errors='ignore')}")

                # 构造响应
                response = RESPONSE_TEMPLATE.format(port=addr[1])
                sock.sendto(response.encode('utf-8'), addr)
                logging.info(f"Sent response to {addr[0]}[{addr[1]}]")
            except Exception as e:
                logging.error(f"Error handling request: {e}")
    except KeyboardInterrupt:
        logging.info("Shutting down server...")
    finally:
        sock.close()
        logging.info("Socket closed.")

if __name__ == "__main__":
    main()
