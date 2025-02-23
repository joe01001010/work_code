minikube image load ubi9-ee-minimal.tar
ansible-builder build --tag ubi9-3.18.2-ee-python312:latest -f ansible-execution-env.yml -vvv
