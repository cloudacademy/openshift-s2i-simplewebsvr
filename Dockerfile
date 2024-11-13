# cloudacademydevops/simplewebsvr
FROM quay.io/sclorg/s2i-base-c10s

# Put the maintainer name in the image metadata
LABEL maintainer="Jeremy Cook <jeremy.cook@cloudacademy.com>"

# Rename the builder environment variable to inform users about application you provide them
ENV BUILDER_VERSION 1.0

# Set labels used in OpenShift to describe the builder image
LABEL io.k8s.description="Platform for building simple static website for demos" \
      io.k8s.display-name="builder 1.0.0" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,1.0.0,cloudacademy,devops,openshift"

# Sets io.openshift.s2i.scripts-url label that way, or update that label
COPY ./s2i/bin/ /usr/libexec/s2i

# Drop the root user and make the content of /opt/app-root owned by user 1001
RUN chown -R 1001:1001 /opt/app-root

# Default user is created in the openshift/base-centos7 image
USER 1001

# Set the default port for applications built using this image
EXPOSE 8080

# Set the default CMD for the image
CMD ["/usr/libexec/s2i/usage"]
