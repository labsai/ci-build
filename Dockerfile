FROM maven:3.5-jdk-11

RUN apt-get update && apt-get install -y --no-install-recommends \
		apt-utils \
		ca-certificates \
		curl \
		python-pip \
		bash \
		git \
		tar  && rm -rf /var/cache/apk/*

ENV DOCKER_BUCKET download.docker.com
ENV DOCKER_VERSION 18.06.1-ce
ENV DOCKER_SHA256 83be159cf0657df9e1a1a4a127d181725a982714a983b2bdcc0621244df93687

RUN set -x \
	&& curl -fSL "https://${DOCKER_BUCKET}/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz" -o docker.tgz \
	&& echo "${DOCKER_SHA256} *docker.tgz" | sha256sum -c - \
	&& tar -xzvf docker.tgz \
	&& mv docker/* /usr/local/bin/ \
	&& rmdir docker \
	&& rm docker.tgz \
	&& docker -v

RUN pip install docker-compose

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["sh"]
