#!/bin/bash
set -e

echo "🚀 Setting up ArgoCD ApplicationSet demo..."

# Create directory structure
mkdir -p apps/nginx/{base,overlays/{dev,prod}}
mkdir -p argocd scripts

echo "✅ Directory structure created"
tree argocd-appset-demo