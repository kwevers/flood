FROM registry.fedoraproject.org/fedora-minimal:43

RUN set -x \
  && microdnf -y install nodejs-npm mediainfo

ARG PACKAGE=flood
ARG VERSION=4.9.5

# Get specified version from npm
RUN npm i -g "${PACKAGE}"@"${VERSION}" &&\
    node --version &&\
    npm ls --global &&\
    npm cache clean --force

# Expose port 3000
EXPOSE 3000

# Flood
ENV FLOOD_OPTION_HOST="0.0.0.0"
ENTRYPOINT ["npx", "flood"]