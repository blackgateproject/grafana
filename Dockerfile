FROM grafana/grafana:latest

# Copy configuration files
COPY grafana.ini /etc/grafana/grafana.ini
COPY grafana.db /var/lib/grafana/grafana.db

# Set proper permissions using numeric IDs instead of user/group names
USER root
RUN chmod 644 /etc/grafana/grafana.ini && \
    chmod 660 /var/lib/grafana/grafana.db && \
    # Use numeric IDs for user:group (472 is typically the grafana user)
    chown 472:0 /etc/grafana/grafana.ini && \
    chown 472:472 /var/lib/grafana/grafana.db

# Switch back to the non-root user (grafana)
USER 472
