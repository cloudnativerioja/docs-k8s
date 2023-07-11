## Manejo de secrets con Sealed Secrets

### Introducción

Sealed Secrets es un controller de Kubernetes que permite cifrar los secrets de forma que solo se puedan descifrar en el cluster. Esto permite que los secrets se puedan almacenar en un repositorio de código sin que se puedan ver los valores de los mismos, añadiendo una capa de seguridad por encima.

Este proceso garantiza que los secretos sensibles estén protegidos y se mantengan seguros tanto en repositorios de control de versiones como durante su despliegue dentro del clúster de Kubernetes. Solo el clúster autorizado, que posee la clave privada, puede desencriptar y acceder a los secretos sellados, lo que minimiza los riesgos de exposición accidental o maliciosa de información confidencial.

### Requisitos

- Tener sealed-secrets instalado en el cluster de kubernetes
- Tener instalado kubeseal en local

### Creación de un secret

Para crear un secret, simplemente hay que crear un fichero con el siguiente contenido:

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: mysecret
  namespace: default
type: Opaque
data:
  username: dXNlcm5hbWU=
  password: cGFzc3dvcmQ=
```

Y ejecutar el siguiente comando:

```bash
kubeseal --controller-namespace core-apps --controller-name sealed-secrets --format=yaml < mysecret.yaml > mysealedsecret.yaml
```

**Output:**

```yaml
apiVersion: bitnami.com/v1alpha1
kind: SealedSecret
metadata:
  creationTimestamp: null
  name: mysecret
  namespace: default
spec:
  encryptedData:
    password: AgByS/wRIdaAJbmZM5uyu133mga6uD2MoOOBcrbK6PQlLRaCPQYNoNvLpX+GyLu/F5OoubPxLKWEUlxQ9SEfgGiTWn8KlkNvcetlhFcvnpyb+Lw/iTPbUt2V6j/s8FSVdnbEOeX/ZFFZGbdUPQ0U2Cp33BICeOsXeOCdoACkbt0asE8Rko3QHCrGJruQC19rvEKW+uYkHnBm7vVhdE7vs98i1DcVYhQLoHRxfisAoRp37awn/VGvbPjDp4/reF7o6V2mu/qJGnU3Qll/6nW7tAFmT8EH5YCI1LNq3PgsnB1ZN8NYGKW8jBuMajpnDT+9siq94QQhbuHjVdx8eRyxWDDbjocrfqXix9Sq5QIQ5mc3cvonrtJL09UgNGE9NhoYR79NVpCO/Ph7OKJJuNdgJ9B8lKFE3fWnx6lxxuFKZNiYShQow4+BvvEvqxdAONJOAecPEN+ijHVj/1Tptq89nBAbaoG4C+erx4O6RNgdzPJAFJdvlpCkki729wGfo9xFguwMqYLRO/1rsQXA+/CPVANEs4cBLjAu0VWSJABVxaSgU+KAi7QON3Jbg7owKLvgFYqCFuMd1plReqYQewa1/saZlAl4BFMtGU64GnnaNzyRMKaNsFu+0v2OSpK/+Z95fPg11knPRIdPOv/4Xlh0Wr4+FsB2E+W0x37sRkRE27hU5GE62BuJhod4dVZ/UDjt4QcO6ShkYdiD6g==
    username: AgAKysmcmLBYR1wM/R+wFUpOuztFHMWYIciLszi1SWsc3jtvbJe1Am3UV9O1KgvtC9CDBPh+0mAD0RTjfmuGU9zBk+mhWLG4e775WTjGzSNHNoEeEOQVtGWH6FaI0FHbp6j4EsvflMSeVdrNw0h5u9pVge7rCHz4xTJldm/7i4/cGtCrUoT+8092V+5ieAZyYPSZU7FngAnH3an7NbtvScUtzN38I9uwjSe/AJDrNrJoG/zQOxwmXq59UU+jJ0U3OtI8Kyn3006YxaXvul4BX4d9UDpPOFeYpRINp503OCQCnb8B3ViY7ogJQeJgcYhCF0VyKfCiN9E5tnbMNYXf57sbiDM/FIkBJSNvckSO/Zt/4vp0RCvjB8JpEmnqrbAz4LfGiJNm0CebDke2WGxt5CEFlmY6tZYTgerJy5FhdNAXn8rWNSjyumMI1H/0yEbLif5IORo+bdmIiKoXfXq6v4aajVlcD7wdD9JY8mkBfAFolGkvmJGH32YAMXYrIHDEQhgiynTYTUzz5fQXdfSJFFjmaIaLdvrUGQxoYT/e9EbFehPRFbMOAXIsi96pi0JvBuQ1H0wGF0YVTdiktFzhP1a/69gUiuHw8IKbeeZDIFY9ZH1GZ3+vDUyKBVKHBZyj7RbOK2hW1w6FlNn/h0mz/5pcdF5Lw0y4sSEd2LU+VdmpOst5whJALNdNJ2hx3zraIhjaP9TgPD+jng==
  template:
    metadata:
      creationTimestamp: null
      name: mysecret
      namespace: default
    type: Opaque
```

Una vez creado el secret, se puede aplicar en el cluster de kubernetes:

```bash
kubectl apply -f mysealedsecret.yaml
```

El controller de sealed-secrets desencriptará el secret y lo creará en el cluster de kubernetes.

### Descifrar un secret

Para descifrar un secret, simplemente hay que ejecutar el siguiente comando:

```bash
kubeseal --controller-namespace core-apps --controller-name sealed-secrets --format=yaml < mysealedsecret.yaml > mysecret.yaml
```
