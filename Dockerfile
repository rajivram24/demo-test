FROM amazonlinux
RUN #!/bin/bash
RUN yum -y update
RUN yum -y install httpd
RUN useradd test
#RUN usermod --password $(openssl passwd -1 KI#h6!V2L)test
RUN mkdir -p /home/test/public_html
COPY . /home/test/public_html
RUN chmod -R 755 /home/test
RUN chown -R test:test /home/test
COPY ./virtual/virtual.conf /etc/httpd/conf.d/virtual.conf
RUN ln -sf /proc/self/fd/1 /var/log/httpd/testnewdomain.ephrontech.com-error_log && \
    ln -sf /proc/self/fd/1 /var/log/httpd/testnewdomain.ephrontech.com-access_log
RUN chmod -R 660 /home/test/public_html/Dockerfile
RUN chmod -R 660 /home/test/public_html/virtual
RUN chmod -R 660 /home/test/public_html/buildspec.yml
RUN chmod -R 660 /home/test/public_html/taskdefinition.json
EXPOSE 80
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
