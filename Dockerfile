FROM golang:alpine 

RUN apk update && apk add ca-certificates openssl git

ARG cert_location=/usr/local/share/ca-certificates

# Get certificate from "github.com"
RUN openssl s_client -showcerts -connect github.com:443 </dev/null 2>/dev/null|openssl x509 -outform PEM > ${cert_location}/github.crt
# Get certificate from "proxy.golang.org"
RUN openssl s_client -showcerts -connect proxy.golang.org:443 </dev/null 2>/dev/null|openssl x509 -outform PEM >  ${cert_location}/proxy.golang.crt
# Update certificates
RUN update-ca-certificates

RUN mkdir -p /build/go
ADD . /build/
WORKDIR /build 
RUN GOPATH=/build/go CGO_ENABLED=0 GOOS=linux GOARCH=${GOARCH} go build -a -installsuffix cgo -ldflags '-s -w -extldflags "-static"' -buildvcs=false -o hello-harness .
RUN mkdir /app
RUN cp /build/hello-harness /app && cp /build/.env.dev /app
WORKDIR /app
ENV HELLO_HARNESS_ENV=dev
CMD ["./hello-harness"]
