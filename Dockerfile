FROM golang:1.15.0-alpine AS builder
LABEL stage=builder

RUN apk add --no-cache git 

# Install UPX
ADD https://github.com/upx/upx/releases/download/v3.96/upx-3.96-amd64_linux.tar.xz /usr/local
RUN xz -d -c /usr/local/upx-3.96-amd64_linux.tar.xz | \
    tar -xOf - upx-3.96-amd64_linux/upx > /bin/upx
RUN chmod a+x /bin/upx

WORKDIR /go/src/hello
ENV GOPATH /go

COPY src/ ./
RUN echo $GOPATH
RUN go get 
RUN CGO_ENABLED=0 GOOS=linux go build -a hello.go
RUN /bin/upx hello



FROM scratch AS final
WORKDIR /
COPY --from=builder /go/src/hello/hello .

COPY etc /etc
# COPY src/entrypoint.sh /entrypoint.sh
# RUN chmod +x /entrypoint.sh
#ENTRYPOINT ["/entrypoint.sh"]

USER MyUser
CMD [ "/hello" ]