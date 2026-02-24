FROM chatwoot/chatwoot:latest

# Set working directory
WORKDIR /app

# Install additional dependencies if needed
RUN apt-get update && apt-get install -y \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Copy Kanban module files into the image
COPY docker/kanban-module /app/docker/kanban-module
COPY docker/kanban-config.js /app/docker/kanban-config.js
COPY docker/apply-kanban-module.sh /app/docker/apply-kanban-module.sh
COPY docker/with-kanban.sh /app/docker/with-kanban.sh

# Make scripts executable
RUN chmod +x /app/docker/apply-kanban-module.sh \
    && chmod +x /app/docker/with-kanban.sh

# Apply Kanban module during build
RUN bash /app/docker/apply-kanban-module.sh

# Use the custom entrypoint script
ENTRYPOINT ["/app/docker/with-kanban.sh"]
CMD ["bundle", "exec", "rails", "server", "-p", "3000", "-b", "0.0.0.0"]