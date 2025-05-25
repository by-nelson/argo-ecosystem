COMMAND = treeviewer
BUILDPATH = dist
VERSION = v0.0.0-alpha

.DEFAULT_GOAL := build

linux-%:
	GOOS=linux GOARCH=$* go build -v -o ./${BUILDPATH}/$@/${COMMAND} ./cmd/${COMMAND}

format-pre:
	@gofmt -l .

format:
	@gofmt .

build: linux-amd64 linux-arm64
	@echo version: $(VERSION)

.PHONY: clean
clean:
	rm -rf ./${BUILDPATH}
