Url to check static web-page: http://34.132.177.142/
Url to check prometheus: http://34.134.227.95:9090

GKE using terraform:
-prerequisite: 1)GCP account (configured-project): compute engine and kubernetes engine api enabled
               2)VS code
               3)Terraform
Steps:
1)mkdir project
2)cd project
3)touch main.tf (check in repo)
4)terraform init
5)terraform apply.

Create a Web_page:
1)touch index.html
2)add the code as in repo
3)touch Dockerfile
4)add the content as per repo
5)build the image:gcloud builds submit --tag gcr.io/project id/static-web-app
6)upload to GCP resitory : gcloud builds submit --tag gcr.io/project id/static-web-app --verbosity=debug

create a deployment files:
1)touch deployment.yaml:
2)add the content as repo
3)kubectl apply -f deployment.yaml
4)Load balancer service: kubectl expose deployment static-web-app --type=LoadBalancer --port=80 --target-port=80
5)check service: kubectl get pods
                 kubectl get svc

Prometheous:
1) touch prometheous-deployment.yaml prometheous-configmap.yaml prometheous-service.yaml
2) add the content as per repo
3) kubectl create namespace monitoring
5)kubectl apply -f prometheus-config.yaml
6)kubectl apply -f prometheus-deployment.yaml
7)kubectl apply -f prometheus-service.yaml
8)kubectl get pods -n monitoring
9)kubectl get svc -n monitoring







