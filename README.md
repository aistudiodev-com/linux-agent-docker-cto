# OpenClaw Productivity Agent (Docker CTO Edition)

Este repositorio contiene una imagen de Docker personalizada basada en [OpenClaw](https://github.com/openclaw/openclaw), optimizada con un conjunto de herramientas poderosas para maximizar la productividad diaria, el procesamiento multimedia y la automatización.

## 🚀 Características Principales

Esta imagen no solo ejecuta OpenClaw, sino que viene pre-equipada con:

- **IA y Transcripción**: OpenAI Whisper con el modelo `large-v3-turbo` pre-instalado.
- **Google Cloud SDK**: Herramientas completas (`gcloud`, `gsutil`, `bq`) para integración con la nube.
- **Multimedia**: `ffmpeg` y herramientas de WebP para procesamiento de audio y video.
- **Productividad**: Procesamiento de PDFs (`poppler-utils`), manipulación de JSON (`jq`) y herramientas de red.
- **Acceso Remoto**: Cliente SSH pre-instalado para conectarse al host Ubuntu u otros servidores.
- **Desarrollo**: Python 3, Git y utilidades esenciales de compilación.

## 🛠️ Requisitos

- [Docker](https://docs.docker.com/get-docker/) instalado.
- [Docker Compose](https://docs.docker.com/compose/install/) (opcional, para ejecución simplificada).

## 📦 Instalación y Uso

### 1. Clonar el repositorio
```bash
git clone https://github.com/aistudiodev-com/linux-agent-docker-cto.git
cd linux-agent-docker-cto
```

### 2. Construir la imagen
> [!TIP]
> Si ya tienes el modelo descargado localmente, colócalo en una carpeta llamada `models` en este directorio para que se monte automáticamente vía Docker Compose. Esto evitará la descarga de ~1.5GB durante la ejecución.

```bash
docker build -t openclaw-cto .
```

### 3. Ejecutar el contenedor
Puedes usar el archivo `docker-compose.yml` proporcionado:

```bash
docker-compose up -d
```

O mediante Docker CLI (importante incluir `--add-host` para permitir la comunicación con el host):

```bash
docker run -d \
  --name openclaw-agent \
  -p 3000:3000 \
  --add-host host.docker.internal:host-gateway \
  openclaw-cto
```

#### 🔌 Conectarse al Host mediante SSH
Gracias a la configuración de red incluida, puedes conectarte desde dentro del contenedor a tu máquina host Ubuntu usando:

```bash
ssh tu_usuario@host.docker.internal
```

## 🛠️ Herramientas Incluidas

| Categoría | Herramientas |
| :--- | :--- |
| **Red** | `curl`, `wget`, `ping`, `traceroute`, `net-tools`, `dnsutils`, `ssh-client`, `rsync` |
| **Archivos** | `zip`, `unzip`, `vim`, `jq`, `tree` |
| **Documentos** | `poppler-utils` (PDF) |
| **Multimedia** | `ffmpeg`, `imagemagick`, `webp` |
| **IA** | `openai-whisper` (large-v3-turbo) |
| **Cloud** | `google-cloud-sdk` |

## 📄 Licencia

Este proyecto se distribuye bajo la licencia MIT. Consulta el archivo [LICENSE](LICENSE) para más detalles.

---
Creado con ❤️ por [AI Studio Dev](https://aistudiodev-com).
