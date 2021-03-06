default:
	@echo "Targets:"
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$'

build:
	docker build -t carolynvs/whaleinabox-data data
	docker build -t carolynvs/whaleinabox-jupyter jupyter
	docker build -t carolynvs/whaleinabox-jupyterhub jupyterhub
	docker build -t carolynvs/whaleinabox-letsencrypt letsencrypt
	docker build -t carolynvs/whaleinabox-nginx nginx
	docker build -t carolynvs/whaleinabox-web web

push: build
	docker push carolynvs/whaleinabox-data
	docker push carolynvs/whaleinabox-jupyter
	docker push carolynvs/whaleinabox-jupyterhub
	docker push carolynvs/whaleinabox-letsencrypt
	docker push carolynvs/whaleinabox-nginx
	docker push carolynvs/whaleinabox-web
