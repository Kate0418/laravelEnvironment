ifeq (app,$(firstword $(MAKECMDGOALS)))
  APP_NAME := $(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))
  $(eval $(APP_NAME):;@:)
endif
ifndef APP_NAME
  $(error アプリ名を設定してください)
endif
.PHONY: $(APP_NAME)
app:
	@rm -rf .git
	@docker build --build-arg APP_NAME=$(APP_NAME) -t laravel_environment .
	@docker run -d --name laravel_environment laravel_environment
	@docker cp laravel_environment:/workdir/$(APP_NAME) ./$(APP_NAME)
	@docker stop laravel_environment
	@docker rm laravel_environment
	@printf "\033[32m環境構築完了\033[0m\n"