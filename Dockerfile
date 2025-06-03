# Start from the Flux.1-dev base image
# Replace <version> with the desired release version (e.g., 5.1.0)
FROM runpod/worker-comfyui:5.1.0-flux1-dev

# Install custom nodes using comfy-node-install
# ComfyUI_essentials is available in the Comfy Registry
RUN comfy-node-install comfyui_essentials

# ComfyUI-TeaCache needs to be installed via URL since it might not be in the registry
RUN comfy-node-install https://github.com/welltop-cn/ComfyUI-TeaCache

# Add style_models path to extra_model_paths.yaml after the unet line
RUN if ! grep -q "style_models:" /comfyui/extra_model_paths.yaml; then \
    sed -i '/  unet: models\/unet\//a\  style_models: models\/style_models\/' /comfyui/extra_model_paths.yaml; \
    fi
