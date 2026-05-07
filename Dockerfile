# Imagen base oficial de OpenClaw
FROM ghcr.io/openclaw/openclaw:latest

# Cambiar a root para instalar todo
USER root

# Evitar diálogos interactivos durante la instalación
ENV DEBIAN_FRONTEND=noninteractive

# Instalación masiva de herramientas
RUN apt-get update && apt-get install -y --no-install-recommends \
    # Herramientas de red
    curl wget iputils-ping traceroute net-tools dnsutils \
    # Manipulación de archivos
    zip unzip xz-utils vim nano tree jq \
    # Procesamiento de PDF
    poppler-utils \
    # Multimedia
    ffmpeg libsox-fmt-all \
    # Imagen y WebP
    imagemagick webp \
    # Utilidades de sistema y desarrollo
    git \
    python3 python3-pip \
    gnupg \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

# Instalar Google Cloud SDK de forma moderna (usando keyring)
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg && \
    apt-get update && apt-get install -y google-cloud-sdk && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

# Instalar PyTorch (versión CPU) y Whisper para ahorrar varios GB (evita librerías de NVIDIA/CUDA)
RUN pip3 install --no-cache-dir torch torchaudio --index-url https://download.pytorch.org/whl/cpu --break-system-packages && \
    pip3 install --no-cache-dir openai-whisper --break-system-packages && \
    mkdir -p /home/node/.cache/whisper && \
    chown -R node:node /home/node/.cache

# Configurar el usuario no-root por defecto
USER node

# El comando por defecto para ejecutar OpenClaw
CMD ["node", "/app/dist/index.js", "gateway", "run", "--allow-unconfigured"]
