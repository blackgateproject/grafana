FROM grafana/grafana:latest

USER root

# Create environment config directories
RUN mkdir -p /opt/grafana/config/local \
             /opt/grafana/config/public \
             /opt/grafana/config/server

# Copy configurations for each environment
COPY ./config/local/ /opt/grafana/config/local/
COPY ./config/public/ /opt/grafana/config/public/
COPY ./config/server/ /opt/grafana/config/server/

# Add our custom entrypoint script
COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
