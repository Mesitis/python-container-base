build:
	docker build --target base -t 221120163160.dkr.ecr.ap-southeast-1.amazonaws.com/python:3.9-slim .
	docker build --target builder -t 221120163160.dkr.ecr.ap-southeast-1.amazonaws.com/python:3.9-slim-builder .
	docker push 221120163160.dkr.ecr.ap-southeast-1.amazonaws.com/python:3.9-slim
	docker push 221120163160.dkr.ecr.ap-southeast-1.amazonaws.com/python:3.9-slim-builder
