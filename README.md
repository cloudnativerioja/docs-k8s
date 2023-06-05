# Documentacion-k8s

Repositorio para documentación de kubernetes y su ecosistema del Community Group Cloud Native Rioja

## Requisitos

Tener mkdocs y mkdocs-material instalado

```bash
pip install mkdocs
pip install mkdocs-material
```

## Uso

Simplemente dentro del directorio docs/ hay varias carpetas con la documentación de cada tema, solo hay que añadir el fichero markdown que se desea y apuntarlo en el manifiesto mkdocs.yml

Ejemplo: _Me gustaría añadir un monográfico de ArgoCD_

- Crear dentro de docs/monograficos/ un fichero argocd.md donde crear la documentación
- Añadir en el fichero mkdocs.yml dentro de la sección nav: el siguiente texto:

```yaml
- Monográficos:
    - ArgoCD: monograficos/argocd.md
```

## Desarrollo

Para ver los cambios en tiempo real y poder ver la documentación que se genera, ejecutar:

```bash
make dev
```

Para generar la documentación en formato html, ejecutar:

```bash
make build
```
