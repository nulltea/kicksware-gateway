gateway:
	docker-compose down;
	docker-compose build;
	docker-compose push gateway
	docker-compose up -d;