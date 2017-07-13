FROM centos7

LABEL Vendor="RedHat"

RUN yum -y install httpd mod_ssl mod_auth_mellon

ADD openshift.conf /etc/httpd/conf.d/openshift.conf
ADD httpd.conf /etc/httpd/conf/httpd.conf
ADD ssl.conf /etc/httpd/conf.d/ssl.conf
ADD logged_out.html /var/www/html/logged_out.html
RUN rm -fr /etc/httpd/conf.d/welcome.conf && \
    mkdir -p /etc/httpd/conf/ose_certs -m 755 && \
    mkdir -p /etc/httpd/conf/saml -m 755 && \
    mkdir -p /etc/httpd/conf/server_certs -m 755

EXPOSE 8443

ADD run-httpd.sh /run-httpd.sh
RUN chmod -v +x /run-httpd.sh && \
    chmod -v a+rwx /run/httpd && \
    chmod -v a+rwx /var/log/httpd && \
    chmod -Rv a+rwx /etc/pki/ca-trust/extracted/

CMD ["/run-httpd.sh"]

