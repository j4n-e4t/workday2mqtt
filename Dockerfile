# Stage 1: Install dependencies
LABEL org.opencontainers.image.source=https://github.com/j4n-e4t/workday2mqtt

FROM python:3.8-slim as builder
WORKDIR /workday2mqtt
COPY . .
RUN pip install --no-cache-dir -r requirements.txt

# Stage 2: Create final image
FROM python:3.8-slim
COPY --from=builder /workday2mqtt /workday2mqtt
COPY --from=builder /usr/local /usr/local
WORKDIR /workday2mqtt
RUN apt-get update && apt-get install -y cron && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /var/log/cron \
    && chmod 0644 /workday2mqtt/crontab \
    && crontab /workday2mqtt/crontab \
    && chmod +x /workday2mqtt/entrypoint.sh
ENTRYPOINT ["/workday2mqtt/entrypoint.sh"]