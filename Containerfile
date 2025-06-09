FROM registry.fedoraproject.org/fedora-minimal:43

# Install nodejs and deps
RUN set -x \
  && microdnf -y install nodejs-npm mediainfo \
  # Create workdir
  && mkdir /flood

# Copy npm package spec
COPY package*.json /flood

# Set workdir
WORKDIR /flood

# Install npm packages
RUN node --version \
    && npm install \
    && npm ls \
    && npm cache clean --force

# Expose port 3000
EXPOSE 3000

# Flood
ENV FLOOD_OPTION_HOST="0.0.0.0"
ENTRYPOINT ["npx", "flood"]