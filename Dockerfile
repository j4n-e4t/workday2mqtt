# Use the official Python image as the base image
FROM python:3.8-slim

# Set the working directory in the container
WORKDIR /workday2mqtt

# Copy the application files to the container
COPY . .

# Install the dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Install cron and create log directory
RUN apt-get update && apt-get install -y cron && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /var/log/cron

# Give execution rights on the cron job
RUN chmod 0644 /workday2mqtt/crontab

# Apply cron job
RUN crontab /workday2mqtt/crontab

# Make entrypoint executable
RUN chmod +x /workday2mqtt/entrypoint.sh

# Command to run cron job and keep the container running
ENTRYPOINT "/workday2mqtt/entrypoint.sh"
