# Terraform for Cloud ☁️
Terraform to create cloud resources

Run `echo "alias tf=terraform" >> ~/.bashrc` for easy life 😊

## GCP
```bash
# Download credentials.json from google cloud and save in gcp/credentials.json
cd gcp/
# Run following
tf init
tf plan
tf apply
tf output
tf destroy
```

## AWS
```bash
cd aws/
# Run following
tf init
```

# Post Cluster Setup
```bash
# Get kubectl config
gcloud projects list
gcloud container clusters get-credentials <cluster-name> --zone us-central1-c --project <project-id>

# Install Knative Serving
kubectl apply -f https://github.com/knative/serving/releases/download/knative-v1.13.1/serving-crds.yaml
kubectl apply -f https://github.com/knative/serving/releases/download/knative-v1.13.1/serving-core.yaml

# Install Istio
kubectl apply -l knative.dev/crd-install=true -f https://github.com/knative/net-istio/releases/download/knative-v1.13.1/istio.yaml
kubectl apply -f https://github.com/knative/net-istio/releases/download/knative-v1.13.1/istio.yaml
kubectl apply -f https://github.com/knative/net-istio/releases/download/knative-v1.13.1/net-istio.yaml
kubectl --namespace istio-system get service istio-ingressgateway

# DNS
kubectl apply -f https://github.com/knative/serving/releases/download/knative-v1.13.1/serving-default-domain.yaml

# Enable sidecar injection
kubectl label namespace <default> istio-injection=enabled --overwrite

# Install Kiali
helm install \
    --set cr.create=true \
    --set cr.namespace=istio-system \
    --namespace kiali-operator \
    --create-namespace \
    kiali-operator \
    kiali/kiali-operator

# Uninstall Kiali
kubectl delete kiali --all --all-namespaces
helm uninstall --namespace kiali-operator kiali-operator
kubectl delete crd kialis.kiali.io

# Install prometheus for Istio
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.20/samples/addons/prometheus.yaml

# Install grafana for Istio
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.20/samples/addons/grafana.yaml

# Expose Kiali via Loadbalancer
Kiali CR-> spec.deployment.service_type: LoadBalancer

# Create JWT Token
kubectl -n istio-system create token kiali-service-account
```
