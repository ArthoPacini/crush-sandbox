# ---------- Build crush with a modern Go ----------
FROM docker.io/golang:1.25-alpine AS crush-builder
RUN apk add --no-cache git
RUN go install github.com/charmbracelet/crush@v0.6.2

# ---------- Slim Alpine runtime ----------
FROM docker.io/alpine:3.22.1

ARG USER_NAME=dev
ARG USER_UID=1000
ARG USER_GID=${USER_UID}

# Base CLI + Python + Go (keep Go for convenience; toolchain auto-download on demand)
RUN apk add --no-cache \
    bash coreutils tree git openssh-client curl wget jq ripgrep \
    python3 py3-pip \
    go build-base \
    ca-certificates tzdata \
 && update-ca-certificates

# Let old Go auto-fetch newer toolchains when needed
ENV GOTOOLCHAIN=auto

# Non-root user
RUN addgroup -g ${USER_GID} ${USER_NAME} \
 && adduser -D -G ${USER_NAME} -u ${USER_UID} ${USER_NAME}

# Copy crush from the 1.24 builder
COPY --from=crush-builder /go/bin/crush /usr/local/bin/crush
RUN chmod +x /usr/local/bin/crush

USER ${USER_NAME}
WORKDIR /home/${USER_NAME}

# Pre-create config dir; devcontainer.json copies your repo's crush.json here
RUN mkdir -p /home/${USER_NAME}/.config/crush

CMD ["sleep","infinity"]