FROM scratch AS ctx
COPY build_files /

FROM quay.io/fedora/fedora-bootc:43

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    dnf install -y basesystem coreutils util-linux shadow-utils nano && \
    /ctx/00-base.sh && \
    /ctx/01-sway.sh
    
RUN bootc container lint
