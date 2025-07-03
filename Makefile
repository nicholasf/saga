.PHONY: build deploy

build:
	go build -o service

deploy: build
	scp 
