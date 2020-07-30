### TODO 一级构建打包和生成可执行文件
FROM golang:alpine AS builder

### 开启go module和国内代理
ENV GO111MODULE=on
ENV GOPROXY=https://goproxy.cn,direct

RUN mkdir -p /builder

COPY main.go /builder/
COPY go.mod /builder

RUN cd /builder \
    && go mod tidy \
    && go mod vendor \
    && go build -ldflags='-s -w' -o main main.go

### TODO 二级构建压缩可执行文件
FROM gruebel/upx AS upx

COPY --from=builder /builder/main /builder/

RUN upx /builder/main

### TODO 三级构建 可执行文件放入小型linux中
FROM alpine:latest

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

ENV apk update -no-cache

COPY --from=upx /builder/main /work/

WORKDIR /work/

EXPOSE 8080

CMD ["/work/main"]