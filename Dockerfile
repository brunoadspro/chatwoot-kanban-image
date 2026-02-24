# Use EXATAMENTE a mesma versão do seu Chatwoot atual (pinada)
# Ex.: chatwoot/chatwoot:v4.6.1
ARG CHATWOOT_BASE_IMAGE=chatwoot/chatwoot:latest
FROM ${CHATWOOT_BASE_IMAGE}

USER root

# Ferramentas básicas (algumas imagens já têm parte disso)
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl wget ca-certificates tar gzip bash sed grep coreutils \
  && rm -rf /var/lib/apt/lists/*

# Scripts customizados
COPY docker/with-kanban.sh /usr/local/bin/with-kanban.sh
COPY docker/apply-kanban-module.sh /usr/local/bin/apply-kanban-module.sh

RUN chmod +x /usr/local/bin/with-kanban.sh /usr/local/bin/apply-kanban-module.sh

# Volta para usuário padrão da imagem (se a sua imagem usa outro usuário, ajuste)
# Muitas imagens do Chatwoot usam root no runtime; se a sua usa `rails`, troque aqui.
USER root