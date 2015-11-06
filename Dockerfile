FROM centos:7

MAINTAINER bdunne

RUN yum -y install \
  curl \
  nano \
  scl-utils \
  https://www.softwarecollections.org/en/scls/rhscl/git19/epel-7-x86_64/download/rhscl-git19-epel-7-x86_64.noarch.rpm

RUN curl -sSf "https://packages.gitlab.com/install/repositories/runner/gitlab-ci-multi-runner/config_file.repo?os=centos&dist=7&source=script" -o /etc/yum.repos.d/runner_gitlab-ci-multi-runner.repo

RUN yum -y install \
  docker \
  gitlab-ci-multi-runner \
  git19-git

ADD entrypoint /
RUN chmod +x /entrypoint

VOLUME ["/etc/gitlab-runner", "/home/gitlab-runner"]
ENTRYPOINT ["/entrypoint"]
CMD ["run", "--user=gitlab-runner", "--working-directory=/home/gitlab-runner"]