PORT_SWAGGER_EDITOR=8081
PORT_SWAGGER_UI=8082
PORT_STUB=8000
IMAGE_STUB=api_stub
SWAGGER_DIR_PATH=$(PWD)/swagger
SWAGGER_YAML_PATH=${SWAGGER_DIR_PATH}/swagger.yaml


.PHONY: run_swagger_editor
run_swagger_editor:
	docker run --rm -p ${PORT_SWAGGER_EDITOR}:8080 swaggerapi/swagger-editor

# Swagger UI用サーバーを起動
.PHONY: run_swagger_ui
run_swagger_ui:
	docker run --rm -p ${PORT_SWAGGER_UI}:8080 \
        -v ${SWAGGER_YAML_PATH}:/usr/share/nginx/html/api/swagger.yaml \
        -e API_URL=http://localhost:${PORT_SWAGGER_UI}/api/swagger.yaml \
        swaggerapi/swagger-ui

# swagger.yamlからスタブ用ソース及びスタブコンテナをビルドする
.PHONY: build_stub
build_stub:
	@echo "=== Generating stub file from swagger.yaml is running...==="
	docker run --rm \
		-v ${SWAGGER_DIR_PATH}:/swagger \
		swaggerapi/swagger-codegen-cli generate \
		-l nodejs-server \
        -i /swagger/swagger.yaml \
        -o /swagger/stub
	@echo "=== Generating stub file is completed. ===\n"
	@echo "=== Building new container... ==="
	docker build -f docker/stub/Dockerfile -t ${IMAGE_STUB} .
	@echo "=== Building container is completed. ==="

# stubの起動
.PHONY: run_stub
run_stub:
	docker run --rm -p ${PORT_STUB}:8000 ${IMAGE_STUB}
