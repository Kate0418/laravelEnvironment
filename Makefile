.SILENT:
.PHONY: laravel
ifeq (laravel,$(firstword $(MAKECMDGOALS)))
  APP_NAME := $(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))
  $(eval $(APP_NAME):;@:)
endif
ifndef APP_NAME
  $(error アプリ名を設定してください)
endif
laravel:
	@echo APP_NAME=$(APP_NAME) > ./.env
	@chmod +x ./Make.sh
	@./Make.sh