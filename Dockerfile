# Replace <version> with the desired release version (e.g., 5.1.0)
FROM runpod/worker-comfyui:5.1.0-base

# Install custom nodes using comfy-node-install
# ComfyUI_essentials is available in the Comfy Registry
RUN comfy-node-install comfyui_essentials

# ComfyUI-TeaCache needs to be installed via URL since it might not be in the registry
RUN comfy-node-install https://github.com/welltop-cn/ComfyUI-TeaCache

# Add style_models path to extra_model_paths.yaml after the unet line
RUN if ! grep -q "style_models:" /comfyui/extra_model_paths.yaml; then \
    sed -i '/  unet: models\/unet\//a\  style_models: models\/style_models\/' /comfyui/extra_model_paths.yaml; \
    fi

RUN comfy model download \
    --url http://robertvoy.com/downloads/sigclip_vision_patch14_384.safetensors \
    --relative-path models/clip_vision \
    --filename sigclip_vision_patch14_384.safetensors

RUN comfy model download \
     --url http://robertvoy.com/downloads/4xNomos8kDAT.pth \
     --relative-path models/upscale-models \
     --filename 4xNomos8kDAT.pth

RUN comfy model download \
     --url http://robertvoy.com/downloads/first_person_pov_v1.safetensors \
     --relative-path models/loras \
     --filename first_person_pov_v1.safetensors

RUN comfy model download \
     --url http://robertvoy.com/downloads/flux1-redux-dev.safetensors \
     --relative-path models/style_models \
     --filename flux1-redux-dev.safetensors
