FROM gliderlabs/alpine:3.4

RUN apk-install \
    python3 \
    supervisor && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    rm -r /root/.cache

RUN mkdir -p /app

COPY requirements.txt lib/marathon-autoscaler/ /app/
COPY supervisord.conf /etc/supervisor.d/marathon_autoscaler.ini
RUN pip install -r /app/requirements.txt
CMD ["/usr/bin/supervisord"]
