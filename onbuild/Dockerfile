FROM otud/meteord3.x_imagemagick:base
LABEL org.opencontainers.image.authors="duto_guerra@hotmail.com"

ARG NODE_VERSION
ENV NODE_VERSION=${NODE_VERSION:-22.16.0}
ONBUILD ENV NODE_VERSION=${NODE_VERSION:-22.16.0}

# Allow Meteor to run as root in Docker
ENV METEOR_ALLOW_SUPERUSER=true
ONBUILD ENV METEOR_ALLOW_SUPERUSER=true

ONBUILD COPY ./ /app
ONBUILD RUN bash $METEORD_DIR/lib/install_meteor.sh
ONBUILD RUN bash $METEORD_DIR/lib/build_app.sh
