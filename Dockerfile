FROM golang:alpine as builder

RUN apk update && apk add ca-certificates openssl git

ARG cert_location=/usr/local/share/ca-certificates

# Get certificate from "github.com"
RUN openssl s_client -showcerts -connect github.com:443 </dev/null 2>/dev/null|openssl x509 -outform PEM > ${cert_location}/github.crt
# Get certificate from "proxy.golang.org"
RUN openssl s_client -showcerts -connect proxy.golang.org:443 </dev/null 2>/dev/null|openssl x509 -outform PEM >  ${cert_location}/proxy.golang.crt
# Update certificates
RUN update-ca-certificates

RUN mkdir /build 
ADD . /build/
WORKDIR /build 
ARG GOARCH
RUN echo " XXX ----- XXX" && echo "GOARCH : ${GOARCH}"
RUN CGO_ENABLED=0 GOOS=linux GOARCH=${GOARCH} go build -a -installsuffix cgo -ldflags '-s -w -extldflags "-static"' -buildvcs=false -o hello-harness .
FROM scratch
COPY --from=builder /build/hello-harness /app/
COPY --from=builder /build/.env.dev /app/
WORKDIR /app
ENV HELLO_HARNESS_ENV=dev
CMD ["./hello-harness"]
