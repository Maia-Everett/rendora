FROM golang:1.13
WORKDIR /app
COPY ./go.mod ./go.sum /app/
RUN go mod download
COPY . /app
RUN make build


FROM alpine:latest  
RUN apk --no-cache add ca-certificates
WORKDIR /rendora
COPY --from=0 /app/cmd/rendora/rendora /usr/bin
ENTRYPOINT ["rendora"]