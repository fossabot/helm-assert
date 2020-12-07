MODULE  := github.com/philzon/helm-assert
NAME    := assert
BINDIR  := bin
VERSION := 0.1.0
COMMIT  := $(shell git rev-parse --short HEAD)
DATE    := $(shell date +"%Y-%m-%d %H:%M:%S")

ifeq ($(shell git tag --points-at HEAD),)
    VERSION := $(VERSION)-SNAPSHOT
endif

CFLAGS  := -s \
           -w \
           -X "$(MODULE)/internal/app.Name=$(NAME)" \
           -X "$(MODULE)/internal/app.Version=$(VERSION)" \
           -X "$(MODULE)/internal/app.Commit=$(COMMIT)" \
           -X "$(MODULE)/internal/app.Date=$(DATE)"

.PHONY: all init build vet test package

all: init build

clean:
	@rm -rf $(BINDIR)

init:
	@mkdir --parent $(BINDIR)

build:
	@go build -o $(BINDIR)/$(NAME) -ldflags '$(CFLAGS)' cmd/$(NAME)/*.go

vet:
	@go vet ./...

test:
	@go test ./...
