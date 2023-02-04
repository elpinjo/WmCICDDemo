FROM redhat/ubi8
RUN groupadd sagadmin -g 1724 && useradd sagadmin -u 1724 -g 1724 && mkdir /opt/softwareag && chown 1724:1724 /opt/softwareag
ENV SAG_HOME=/opt/softwareag
WORKDIR $SAG_HOME
COPY --chown=1724:1724 softwareag.tgz $SAG_HOME
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN tar -xzf $SAG_HOME/softwareag.tgz && chown -R 1724:1724 /opt/softwareag && rm $SAG_HOME/softwareag.tgz && \ 
  mkdir /usr/share/jenkins && curl -sO -o agent.jar http://jenkins.k8s/jnlpJars/agent.jar && \
  mv agent.jar /usr/share/jenkins && chmod 0644 /usr/share/jenkins/agent.jar && chmod 0755 /usr/local/bin/entrypoint.sh
USER 1724
ENV SAG_HOME=/opt/softwareag
ENV PATH=/opt/softwareag/jvm/jvm/bin:/opt/softwareag:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
WORKDIR /
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]