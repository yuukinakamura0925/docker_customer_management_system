# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

<!-- docker起動 -->
docker compose up

<!-- webコンテナへのログイン -->
docker compose exec web bash 

<!-- サーバー立ち上げ(コンテナログイン時) -->
bin/rails s -b 0.0.0.0

<!-- DBの確認 -->
bin/rails r "StaffMember.columns.each{|c| p [c.name, c.type]}"

<!-- psqlターミナルを開く -->
psql -U postgres -h db baukis2_development

<!-- 例staff_eventsの情報を見る -->
\d staff_events
