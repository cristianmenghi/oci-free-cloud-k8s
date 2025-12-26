# Guía de Configuración: GitHub App para FluxCD

Configurar una GitHub App es más seguro que un PAT (token personal) porque tiene permisos finos y no expira. Aquí tienes los pasos exactos para configurar la que necesita tu proyecto.

## 1. Crear la App en GitHub
1. Ve a **Settings** -> **Developer Settings** -> **GitHub Apps** -> **New GitHub App**.
2. **GitHub App name**: Por ejemplo, `flux-oci-menghi`.
3. **Homepage URL**: Puedes poner la URL de tu repositorio.
4. **Webhook**: (Opcional por ahora) Desactiva "Active" si no tienes la URL del webhook todavía.

## 2. Permisos Requeridos (Repository permissions)
Configura los siguientes permisos para que FluxCD pueda operar:
- **Contents**: `Read & Write` (para leer el código y actualizarlo).
- **Metadata**: `Read-only` (se añade automáticamente).
- **Webhooks**: `Read & Write` (para que Terraform cree el webhook automáticamente).

## 3. Generar Clave Privada
Al final de la página de configuración, haz clic en **Generate a private key**. Se descargará un archivo `.pem`. Abre este archivo con un editor de texto; necesitarás su contenido.

## 4. Instalar la App
1. Ve a **Install App** en la barra lateral izquierda.
2. Haz clic en **Install** junto a tu usuario/organización.
3. Elige **Only select repositories** y selecciona `oci-free-cloud-k8s`.

---

## 5. Obtener los IDs para Terraform
Necesitas 3 valores para tu archivo [terraform/config/terraform.tfvars](file:///Users/cristian/work/oci-free-cloud-k8s/terraform/config/terraform.tfvars):

| Variable | Dónde encontrarlo |
| :--- | :--- |
| `github_app_id` | En la página **General** de tu App (**App ID**). |
| `github_app_installation_id` | Ve a la configuración de la App -> **Install App**. Haz clic en el engranaje de tu instalación. El ID está al final de la URL: `.../settings/installations/XXXXXX`. |
| `github_app_pem` | El contenido completo del archivo `.pem` que descargaste. |

### Ejemplo en `terraform.tfvars`:
```hcl
github_app_id              = "123456"
github_app_installation_id = "7891011"
github_app_pem             = <<-EOT
-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEA7...
...
-----END RSA PRIVATE KEY-----
EOT
```

Una vez pongas estos valores, haz `terraform apply` y el sistema cambiará automáticamente de usar tu PAT a usar la GitHub App.
