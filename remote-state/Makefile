
run: stop start exec

start:
	docker container run -it -d \
      --env TF_NAMESPACE=$$TF_NAMESPACE \
      --env AWS_PROFILE="kh-labs" \
      --env TF_PLUGIN_CACHE_DIR="/plugin-cache" \
      -v /var/run/docker.sock:/var/run/docker.sock \
      -v $$PWD:/$$(basename $$PWD) \
      -v $$PWD/creds:/root/.aws \
      -v terraform-plugin-cache:/plugin-cache \
      --hostname "$$(basename $$PWD)" \
      --name "$$(basename $$PWD)" \
      -w /$$(basename $$PWD) \
      bryandollery/terraform-packer-aws-alpine

exec:
	docker exec -it $$(basename $$PWD) bash || true

stop:
	docker rm -f $$(basename $$PWD) 2> /dev/null || true

fmt:
	time terraform fmt -recursive

plan:
	time terraform plan -out plan.out -var-file=variables.tfvars

apply:
	time terraform apply plan.out 

up: plan apply

down:
	time terraform destroy -auto-approve 

init:
	time terraform init
