# all the resource refer to 
# https://aws-quickstart.github.io/cdk-eks-blueprints/getting-started/


## init the cluster argocd and eks
terraform init
terraform apply -target="module.vpc" -auto-approve
terraform apply -target="module.eks" -auto-approve
terraform apply -auto-approve

## init the env

export KUBECONFIG="/tmp/eks-argocd-gitops"
# aws eks --region ap-southeast-1 update-kubeconfig --name eks-argocd-gitops
aws eks --region us-west-2 update-kubeconfig --name eks-argocd-gitops

cat $KUBECONFIG="/tmp/eks-argocd-gitops" >>~/.kube/config

# for testing
kubectl get all

init_steps () {

## init argo password
echo "ArgoCD Password: $(kubectl get secrets argocd-initial-admin-secret -n argocd --template="{{index .data.password | base64decode}}")"

### change password

kubectl port-forward -n argocd svc/argo-cd-argocd-server 8080:80 --address="0.0.0.0"

argocd login localhost:8080
argocd account update-password

}



## install add-ons
kubectl apply -f bootstrap/addons.yaml

## isntall applications
kubectl apply -f bootstrap/codedemos/bootstrap/eks-flask-test-chart.yaml


## destory
destroy () {
    bash destroy.sh

}
