# rpmbuild

This docker image can be used to build RPM packages. It is a copy of what is
made by rpmbuild, but updated to support both Rockylinux and Almalinux 8.

## Images

We publish images in the following format:

- rpmbuild-{operatingsystem}-{version}

This means that we currently support the following images:

- rpmbuild-rockylinux-8
- rpmbuild-almalinux-8

All images can be found on [Docker Hub](https://hub.docker.com/repository/docker/sensson/rpmbuild/).

## Third-Party Repositories

None.

## Installed Software

Aside from the additions to make a baseline kit (sudo, git, etc.), the
following software is loaded:

- autoconf / libtool / devscripts
- pkgconfig
- yum-utils
- rpm-build

## User Account and Root Access

The builder user (UID 1000) is a member of users and wheel, and has
password-less sudo as any user, any group.

## Environment Variables

Build scripts can make use of the following environment variables:

- FLAVOR - will be set to rpmbuild
- OS - will be set to centos
- DIST - will be set to el8

## Hook / Integration

When running this container, you will need to provide a /srv mountpoint, which
must contain, at its root, a pkg script that is executable. The image will
execute this build script to perform the actual packaging (including
installation of dependencies, running of tests, debuild calls, etc.)

RPMs will be built in /home/builder/rpm, which should contain source archives,\
patches and built RPM/SRPM files.
