#!/bin/bash

echo "Start generate kubernetes"
KUBERNETES_TEMPLATE="$TEMPLATE_PATH/kubernetes"

mkdir -p "$OUTPUT/kubernetes"
cp "$KUBERNETES_TEMPLATE/deployment.yaml" "$OUTPUT/kubernetes/deployment.yaml"
cp "$KUBERNETES_TEMPLATE/prometheus.yaml" "$OUTPUT/kubernetes/prometheus.yaml"
cp "$KUBERNETES_TEMPLATE/service.yaml" "$OUTPUT/kubernetes/service.yaml"
