FROM node:20.10.0
WORKDIR /app

# 破坏缓存的构建参数
ARG CACHEBUST=1

# 清空工作目录（可能冗余，可移除）
RUN rm -rf /app/*

# 克隆最新代码（浅克隆加速）
RUN git clone --branch main --depth 1 \
    https://github.com/gggaaallleee/SPIDER.git  /app/SPIDER

# 移动文件（建议直接克隆到/app）
RUN mv /app/SPIDER/* /app/ && rm -rf /app/SPIDER

# 调试步骤（可选）
RUN ls -la /app

# 验证必要文件存在
RUN test -f /app/package.json || (echo "package.json missing" && exit 1)

COPY .env .env
RUN npm install && npm run build

EXPOSE 3000
CMD ["npm", "start"]