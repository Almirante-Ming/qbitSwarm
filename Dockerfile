FROM node:18-alpine
WORKDIR /app
RUN npm install -g bittorrent-tracker
CMD ["bittorrent-tracker", "--udp", "--http", "--ws"]