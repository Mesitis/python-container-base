artifact-login:
	@poetry config http-basic.artifact aws $(shell aws codeartifact get-authorization-token --region ap-southeast-1 --domain canopy --domain-owner 221120163160 --query authorizationToken --output text)

build:
	IMAGE_TAG_PREFIX=221120163160.dkr.ecr.ap-southeast-1.amazonaws.com/python ./scripts/build-docker.sh

