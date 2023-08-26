ARG FROM=rockylinux
ARG VERSION=8

FROM ${FROM}:${VERSION}

ARG FROM
ARG VERSION

ENV RELEASE=0.0.1

RUN yum install -y gcc gcc-c++ \
    libtool libtool-ltdl \
    make cmake \
    git \
    pkgconfig \
    sudo \
    automake autoconf \
    yum-utils rpm-build && \
    yum clean all

RUN useradd builder -u 1000 -m -G users,wheel -d /srv/pkg && \
    echo "builder ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    echo "# macros"                      >  /srv/pkg/.rpmmacros && \
    echo "%_topdir    /srv/pkg/rpm"      >> /srv/pkg/.rpmmacros && \
    echo "%_sourcedir %{_topdir}"        >> /srv/pkg/.rpmmacros && \
    echo "%_builddir  %{_topdir}"        >> /srv/pkg/.rpmmacros && \
    echo "%_specdir   %{_topdir}"        >> /srv/pkg/.rpmmacros && \
    echo "%_rpmdir    %{_topdir}"        >> /srv/pkg/.rpmmacros && \
    echo "%_srcrpmdir %{_topdir}"        >> /srv/pkg/.rpmmacros && \
    echo "%version    $RELEASE"          >> /srv/pkg/.rpmmacros && \
    mkdir /srv/pkg/rpm && \
    chown -R builder /srv/pkg
USER builder

ENV FLAVOR=rpmbuild
ENV OS=$FROM
ENV DIST=$VERSION

CMD /srv/rpmbuild/pkg
