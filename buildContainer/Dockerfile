FROM redhat/ubi8
RUN groupadd sagadmin -g 1724 && useradd sagadmin -u 1724 -g 1724 && mkdir /opt/softwareag && chown 1724:1724 /opt/softwareag
USER 1724
ENV SAG_HOME=/opt/softwareag
ENV PATH=/opt/softwareag/jvm/jvm/bin:/opt/softwareag:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
COPY --chown=1724:1724 softwareag.tar $SAG_HOME
WORKDIR $SAG_HOME
RUN tar --group=1724 --owner=1724 -xf $SAG_HOME/softwareag.tar && rm $SAG_HOME/softwareag.tar
WORKDIR /
ENTRYPOINT [ "/opt/softwareag/IntegrationServer/bin/startContainer.sh" ]