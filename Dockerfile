FROM golang:1.14-alpine AS build

### 开启go module和国内代理
ENV GO111MODULE=on
ENV GOPROXY=https://goproxy.cn,direct

RUN mkdir -p /go/src/auto/

COPY main.go /go/src/auto/
COPY go.mod /go/src/auto/

RUN cd /go/src/auto \
    && go mod tidy \
    && go mod vendor \
    && go build -o main main.go


FROM alpine:latest

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

ENV apk update

COPY --from=build /go/src/auto/main /home/work/main

WORKDIR /home/work/

EXPOSE 8080

CMD ["/home/work/main"]