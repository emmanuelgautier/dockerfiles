FROM emmanuelgautier/hubic

LABEL MAINTAINER Emmanuel Gautier <docker@emmanuelgautier.fr>

ENV HUBIC_BACKUP_NAME=backup
ENV HUBIC_BACKUP_FREQUENCY=daily
ENV HUBIC_BACKUP_KEPT_VERSIONS=5

COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
