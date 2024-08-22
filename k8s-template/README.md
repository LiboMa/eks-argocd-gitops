# Minikube demo

this example also can be use in an online lab env:  such as, [here](https://www.katacoda.com/courses/kubernetes/getting-started-with-kubeadm#)


## required before
1. pull image

*This will pull the image from public image registry hub.docker.io which I created previously*
```
docker pull malibo8407/python36-flask-demo:v1
```

2. Add to minikube local registry(if using minkube env )
```bash 
minikube addons enable registry
```

3. Push to local registry
*this will push local image from docker cache to local registry*
```bash
docker tag malibo8407/python36-flask-demo:v1 $(minikube ip):5000/malibo8407/python36-flask-demo:v1
```


## 1. deploy a service

```
kubectl create deployment hello-demo --image=malibo8407/python36-flask-demo:v1
or 
kubectl create deployment hello-demo --image=malibo8407/python36-flask-demo:v3

```
*Output*


## 2. expose the deployment

```
kubectl expose deployment hello-demo --type=NodePort --port=8080
```
*Output*

## 3. Create ingress resources
**enable nginx-ingress-controller in minikube**

	minikube addons enable ingress

```
kubectl apply -f hello-demo-ingress.yaml
```

```yaml
apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  name: hello-demo-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /$1
spec:
  rules:
    - host: hello-demo.info
      http:
    paths:
      - path: /v1
        backend:
          serviceName: hello-demo
          servicePort: 8080
```

```bash
curl -k  -H"Host: hello-demo.info" https://13.229.176.60/v1
$ curl -H"host: hello-demo.io" "$(minikube ip)/v1"
```
    <h2>Python-flask project. Running on openshift(ocp) </h2>
    <p> //OS: CentOs 7, Openshift 3.11//</p>
    <p>2020-11-30 08:16:04.033285</p>


## update for v3 and Online lab:

```bash
kubectl exec hello-demo-74566b7c97-9dk4j -- curl -s http://10.101.159.90:8080
```
```html

    <body>
    <p><h2>Python-flask project V2. </h2></p>
    <p>#214-Ubuntu SMP Thu Jun 4 10:14:11 UTC 2020 </p>
    <p>2021-08-31 10:57:02.786678</p></body>

```


## How to test it:
curl -k  -H"Host: hello-demo.info" https://(your_ingress_ip)/v1
curl -k  -H"Host: hello-demo.info" https://(your_ingress_ip)/v1

curl -H "Host: hello-demo.info" k8s-ingressn-ingressn-2e09d4b43b-1cddc732efa6b22a.elb.ap-southeast-1.amazonaws.com
curl -H "Host: prod.busybox.io" k8s-ingressn-ingressn-2e09d4b43b-1cddc732efa6b22a.elb.ap-southeast-1.amazonaws.com
