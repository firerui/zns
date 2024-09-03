FROM golang:1.23.0-alpine3.20 AS go-builder
WORKDIR /app

RUN apk --no-cache --no-progress add git \
    && git clone https://github.com/firerui/zns.git \
    && cd /app/zns/cmd/zns \
    && go build

FROM alpine:3.20
WORKDIR /app
COPY --from=go-builder /app/zns/cmd/zns/zns .
RUN chmod +x /app/zns 
CMD ["/app/zns", "-free"]
