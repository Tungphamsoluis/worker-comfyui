# start from a clean base image (replace <version> with the desired release)
FROM runpod/worker-comfyui:5.1.0-base

# install custom nodes using comfy-cli
RUN comfy-node-install comfyui_controlnet_aux

# download models using comfy-cli
# the "--filename" is what you use in your ComfyUI workflow
RUN comfy model download --url https://huggingface.co/soinov/My_models/resolve/491eb1211acda17c28891c0c1b4c5cade48c2859/ArchModels/architecturerealmix_v11.safetensors --relative-path models/checkpoints --filename architecturerealmix_v11.safetensors
RUN comfy model download --url https://huggingface.co/comfyanonymous/ControlNet-v1-1_fp16_safetensors/resolve/main/control_v11f1p_sd15_depth_fp16.safetensors --relative-path models/controlnet --filename control_v11f1p_sd15_depth_fp16.safetensors

# Copy local static input files into the ComfyUI input directory (delete if not needed)
# Assumes you have an 'input' folder next to your Dockerfile
COPY input/ /comfyui/input/
