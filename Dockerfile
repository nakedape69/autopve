FROM python:3.14-slim-trixie

RUN echo "**** install runtime dependencies ****" && \
    apt-get update && \
    apt-get install -y openssh-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ADD requirements.txt .
RUN python -m pip install --root-user-action=ignore --no-cache-dir -r requirements.txt

WORKDIR /app
ADD . /app
RUN mkdir -p /app/logs

EXPOSE 8080
ENV PYTHONUNBUFFERED True

ENTRYPOINT ["/app/resources/docker-entrypoint.sh"]
CMD ["python", "main.py"]
