FROM node:lts-alpine AS builder

WORKDIR /app

RUN corepack enable 

COPY package.json pnpm-lock.yaml .

RUN pnpm install --frozen-lockfile --prod

FROM node:lts-alpine AS runner 

WORKDIR /app 

ENV NODE_ENV = production

COPY --from=builder /app/node_modules ./node_modules

COPY --from=builder /app/package.json ./

COPY . . 

EXPOSE 3000

USER node 

CMD ["node","./bin/www"]