FROM debian:buster
MAINTAINER John Alexis Guerra Gomez

ENV METEORD_DIR /opt/meteord
COPY scripts $METEORD_DIR

ARG NODE_VERSION
ENV NODE_VERSION ${NODE_VERSION:-8.11.3}
ONBUILD ENV NODE_VERSION ${NODE_VERSION:-8.11.3}

RUN bash $METEORD_DIR/lib/install_base.sh
RUN bash $METEORD_DIR/lib/install_node.sh
RUN bash $METEORD_DIR/lib/install_phantomjs.sh
RUN bash $METEORD_DIR/lib/cleanup.sh

EXPOSE 80
RUN chmod +x $METEORD_DIR/run_app.sh
ENTRYPOINT exec $METEORD_DIR/run_app.sh