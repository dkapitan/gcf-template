ENV_VARIABLES=SOME_DB=${SOME_DB},SOME_USER=${SOME_USER}
REGION=europe-west1
PROJECT=my-project
RUNTIME=python37

all:
	@echo "==============================="
	@echo "This Makefile is used for CI/CD"
	@echo "==============================="

check-env:
	test -n "$(SOME_DB)" # SOME_DB is not set
	test -n "$(SOME_USER)" # SOME_USER is not set

deploy-production: check-env
	gcloud functions deploy api --entry-point api --runtime $(RUNTIME) \
	--project $(PROJECT) --region $(REGION) --trigger-http --set-env-vars $(ENV_VARIABLES)

deploy-staging: export SOME_DB = "DB-staging"
deploy-staging: export SOME_USER = "USER-staging"
deploy-staging:
	gcloud functions deploy api-staging --entry-point api --runtime $(RUNTIME) \
	--project $(PROJECT) --region $(REGION) --trigger-http --set-env-vars $(ENV_VARIABLES)

deploy-test: export SOME_DB = "DB-test"
deploy-test: export SOME_USER = "USER-test"
deploy-test:
	gcloud functions deploy api-test --entry-point api --runtime $(RUNTIME) \
	--project $(PROJECT) --region $(REGION) --trigger-http --set-env-vars $(ENV_VARIABLES)
