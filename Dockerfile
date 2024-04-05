# automatically generated from https://github.com/metwork-framework/github_organization_management/blob/master/common_files/docker-mfxxx-yyy-buildimage_Dockerfile)


    
    
    



    
    


FROM rockylinux:9.2

ENV DCO_CRONIE_START=1 \
    S6_KEEP_ENV=1 \
    S6_BEHAVIOUR_IF_STAGE2_FAILS=1

ARG BRANCH
RUN echo -e "[metwork_${BRANCH}]\n\
name=Metwork Continuous Integration Branch ${BRANCH}\n\
baseurl=http://metwork-framework.org/pub/metwork/continuous_integration/rpms/${BRANCH}/centos8/\n\
gpgcheck=0\n\
enabled=1\n\
metadata_expire=0\n" >/etc/yum.repos.d/metwork.repo

RUN yum clean all
RUN yum -y install metwork-mfserv-full langpacks-fr
RUN yum -y install metwork-mfext-layer-python3_scientific_core metwork-mfext-layer-python3_devtools
RUN yum -y install initscripts vim coreutils-common cronie make

COPY root /
RUN /build/s6_overlay.sh && \
    yum clean all && \
    rm -Rf /build

ENTRYPOINT ["/init"]
