FROM maven:3.6.1-jdk-12

RUN apt-get update && apt-get install -y --no-install-recommends \
		apt-utils \
		ca-certificates \
		curl \
		python-pip \
		bash \
		git \
		tar  && rm -rf /var/cache/apk/*

ENV DOCKER_BUCKET download.docker.com
ENV DOCKER_VERSION 18.09.6
ENV DOCKER_SHA256 1f3f6774117765279fce64ee7f76abbb5f260264548cf80631d68fb2d795bb09

RUN set -x \
	&& curl -fSL "https://${DOCKER_BUCKET}/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz" -o docker.tgz \
	&& echo "${DOCKER_SHA256} *docker.tgz" | sha256sum -c - \
	&& tar -xzvf docker.tgz \
	&& mv docker/* /usr/local/bin/ \
	&& rmdir docker \
	&& rm docker.tgz \
	&& docker -v


RUN pip install --upgrade setuptools

RUN pip install docker-compose

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["sh"]
