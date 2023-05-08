ifeq (, $(shell which mkdocs))
$(error "No tienes mkdocs instalado, considera instalarlo")
endif

.PHONY: docs build
.SILENT: docs build



# Desarrollo
dev:
	@echo "Iniciando servidor de desarrollo"
	@mkdocs serve

# Construcción del sitio
build:
	@echo "Construyendo sitio estáticamente"
	@mkdocs build