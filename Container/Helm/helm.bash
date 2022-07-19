#!/usr/bin/env bash
# @author: payne
# @email: wuzhipeng1289690157@gmail.com
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 && \
    chmod 700 get_helm.sh && \
    ./get_helm.sh
# add Commonly used repo
helm repo add bitnami https://charts.bitnami.com/bitnami/
helm repo add azure https://mirror.azure.cn/kubernetes/charts/
helm repo add stable https://charts.helm.sh/stable
helm repo add aliyuncs https://kubernetes.oss-cn-hangzhou.aliyuncs.com/charts
helm repo add elastic https://helm.elastic.co
helm repo add gitlab 	https://charts.gitlab.io
helm repo add harbor https://helm.goharbor.io
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo add gpu-helm-charts https://nvidia.github.io/gpu-monitoring-tools/helm-charts
# update repo
helm repo update
# check helm version
helm version
