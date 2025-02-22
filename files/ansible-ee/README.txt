ansible-builder build --tag ubi9-ee-minimal:latest -f ansible-execution-env.yml
minikube image load ubi9-ee-minimal.tar
