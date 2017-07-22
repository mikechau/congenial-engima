FROM apiaryio/emcc:latest

ENV EMALPACK_DIR=/emalpack \
    CLAPACK_VERSION=3.2.1

WORKDIR ${EMALPACK_DIR}

RUN set -ex \
    && apt-get update -y \
    && apt-get install -y \
      build-essential \
      wget \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

RUN wget http://www.netlib.org/clapack/clapack.tgz -O /tmp/clapack.tgz \
  && tar xvf /tmp/clapack.tgz \
  && mv "CLAPACK-${CLAPACK_VERSION}" clapack \
  && cp clapack/make.inc.example clapack/make.inc \
  && cd clapack/F2CLIBS/libf2c \
  && make all \
  && rm -rf /tmp/clapack.tgz

COPY package.json .

RUN npm install

COPY . .

RUN chmod +x scripts/custom_build.sh \
#  && "${EMALPACK_DIR}/scripts/custom_build.sh"
