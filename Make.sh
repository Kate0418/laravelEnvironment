#!/bin/zsh


# ローカルリポジトリーの削除
rm -rf ./.git


# .envファイルから環境変数を取得
source .env


# Homebrewのインストール
if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi


# brewコマンドのパスを通す
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "/Users/$USER/.zprofile"
source ~/.zprofile


# Homebrewのアップデート
brew update


# PHPのインストール
if ! command -v php &> /dev/null; then
    brew install php
fi
# PHPのアップデート
if [ -n "$(brew outdated php)" ]; then
    brew upgrade php
fi


# dockerのインストール
if ! command -v docker &> /dev/null; then
    brew install --cask docker
fi
# dockerのアップデート
if [ -n "$(brew outdated --cask docker)" ]; then
    brew upgrade --cask docker
fi


# docker-composeのインストール
if ! command -v docker-compose &> /dev/null; then
    brew install docker-compose
fi
# docker-composeのアップデート
if [ -n "$(brew outdated docker-compose)" ]; then
    brew upgrade docker-compose
fi


# コンテナのビルド & 起動
docker-compose up -d --build


#コンテナ内のlaravel-projectをホストにコピー
if [ ! -d "./$APP_NAME" ]; then
    docker cp laravel:/laravel/$APP_NAME $APP_NAME
fi


#.envファイルの削除
rm -f ./.env


#完了ログの表示
printf "\033[32m環境構築完了\033[0m\n"