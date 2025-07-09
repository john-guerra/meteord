FROM debian:bookworm
LABEL org.opencontainers.image.authors="duto_guerra@hotmail.com"

ENV METEORD_DIR=/opt/meteord
COPY scripts $METEORD_DIR

ARG NODE_VERSION
ENV NODE_VERSION=${NODE_VERSION:-22.16.0}
ONBUILD ENV NODE_VERSION=${NODE_VERSION:-22.16.0}

# Allow Meteor to run as root in Docker
ENV METEOR_ALLOW_SUPERUSER=true
ONBUILD ENV METEOR_ALLOW_SUPERUSER=true

RUN bash $METEORD_DIR/lib/install_base.sh
RUN bash $METEORD_DIR/lib/install_node.sh
RUN bash $METEORD_DIR/lib/install_phantomjs.sh
RUN bash $METEORD_DIR/lib/post-build-cleanup.sh

EXPOSE 80
RUN chmod +x $METEORD_DIR/run_app.sh
ENTRYPOINT ["bash", "/opt/meteord/run_app.sh"]