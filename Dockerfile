FROM golang:alpine as builder
RUN apk update && \
    apk add make git

WORKDIR /build

COPY go.mod .
COPY .git .
COPY . .

RUN make

FROM alpine:3.8
RUN apk update && \
    apk add git

COPY --from=builder /build/bin/dep_gen /usr/local/bin

ENTRYPOINT ["dep_gen"]
