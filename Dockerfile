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
#RUN echo " GIT INFO " && git describe --tags --long && echo " END OF GIT INFO "
#RUN echo " GIT INFO " && git version && echo " END OF GIT INFO "
#RUN echo " XXX ----- Creating Version Information ----- XXX" && ./genVersion.sh && cat version_linux.go
ARG GOARCH
RUN echo " XXX ----- XXX" && echo "GOARCH : ${GOARCH}"
RUN CGO_ENABLED=0 GOOS=linux GOARCH=${GOARCH} go build -a -installsuffix cgo -ldflags '-s -w -extldflags "-static"' -buildvcs=false -o solar-chain .
#	RUN apk add upx
#	RUN upx /build/solar-chain
FROM scratch
#FROM alpine
COPY --from=builder /build/solar-chain /app/
COPY --from=builder /build/.env.prod /app/
#RUN apk add bash
WORKDIR /app
ENV SOLAR_CHAIN_ENV=prod
CMD ["./solar-chain"]
