fmt:
	terraform fmt
plan: fmt
	terraform plan
app:
	terraform apply -auto-approve
des:
	terraform destroy -auto-approve