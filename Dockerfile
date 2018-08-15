FROM golang:1.10.3 AS builder

# Download and install the latest release of dep
RUN curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh

# Copy the code from the host and compile it
WORKDIR $GOPATH/src/golang-gin-kubernetes-boilerplate
COPY Gopkg.toml Gopkg.lock ./
RUN dep ensure --vendor-only
COPY . ./
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix nocgo -o /app ./src

FROM scratch
COPY --from=builder /app ./
ADD .env ./
ENTRYPOINT ["./app"]
EXPOSE 8080