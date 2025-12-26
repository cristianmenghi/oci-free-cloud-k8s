# Guía: Configuración de GitHub OAuth para Teleport

Para habilitar el login con GitHub en Teleport, necesitas crear una **OAuth Application** en GitHub y registrar las credenciales en tu OCI Vault.

## 1. Crear OAuth App en GitHub
No es lo mismo que una GitHub App. Sigue estos pasos:
1. Ve a **Settings** -> **Developer Settings** -> **OAuth Apps** -> **New OAuth App**.
2. **Application name**: `Teleport Menghi`.
3. **Homepage URL**: `https://teleport.menghi.uy`.
4. **Authorization callback URL**: `https://teleport.menghi.uy/v1/webapi/github/callback` (Esto es crítico).
5. Haz clic en **Register application**.

## 2. Obtener Credenciales
1. En la página de tu nueva App, copia el **Client ID**.
2. Haz clic en **Generate a new client secret** y copia el valor (solo se muestra una vez).

## 3. Registrar Secreto en OCI Vault
Para que Kubernetes pueda leer el secreto de forma segura:
1. Ve a tu consola de OCI -> **Identity & Security** -> **Vault**.
2. Selecciona tu Vault.
3. Crea un nuevo secreto:
   - **Name**: `teleport-github-client-secret`
   - **Secret Content**: (Pega aquí el *Client Secret* de GitHub en **texto plano**, SIN base64).

## 4. Actualizar Configuración en el Código
Abre el archivo [github-connector.yaml](file:///Users/cristian/work/oci-free-cloud-k8s/gitops/core/teleport/rbac/github-connector.yaml):
1. Actualiza `client_id` con el valor que copiaste de GitHub.
2. Asegúrate de que `organization` y `team` coincidan con tu estructura en GitHub (ej. si no tienes una organización "menghi-acme", tendrás que poner tu usuario o la org real).

---

## 5. Aplicar Cambios
Una vez editado el archivo y creado el secreto en OCI:
1. Haz `git add`, `commit` y `push` de los cambios en [gitops/](file:///Users/cristian/work/oci-free-cloud-k8s/gitops).
2. FluxCD detectará el cambio y Teleport habilitará el botón de "Login with GitHub" automáticamente.
