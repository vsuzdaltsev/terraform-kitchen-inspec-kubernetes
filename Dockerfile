FROM ruby:2.6-alpine
LABEL maintainer="vsuzdaltsev"

ENV CHEF_LICENSE="accept-silent"

ARG TF_VERSION=0.12.20
ARG KUBE_RELEASE=1.15.1

RUN mkdir -p /root/.kube
ENV KUBECONFIG=/root/.kube/config

COPY Gemfile .

RUN apk add --update build-base libxml2-dev libffi-dev git openssh-client bash curl python python-dev py-pip groff less mailcap jq && \
  bundle install && \
  pip install --upgrade awscli python-magic && apk -v --purge del py-pip && rm /var/cache/apk/* && \
  apk del build-base && bundle exec gem uninstall mixlib-shellout -v 3.0.9

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v${KUBE_RELEASE}/bin/linux/amd64/kubectl
RUN chmod u+x kubectl && mv kubectl /usr/local/bin/kubectl

ADD https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip .

RUN unzip terraform_${TF_VERSION}_linux_amd64.zip && mv terraform /usr/local/bin/ && \
  rm terraform_${TF_VERSION}_linux_amd64.zip && \
  rm -rf /tmp/* /var/tmp/*

RUN bundle exec gem install train-kubernetes
RUN inspec plugin install train-kubernetes

COPY train_kubernetes_plugin.json /root/.inspec/plugins.json

WORKDIR /root
