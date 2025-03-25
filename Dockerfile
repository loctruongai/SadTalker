FROM nvidia/cuda:11.7.1-cudnn8-runtime-ubuntu20.04

# Set timezone and avoid prompts
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    git ffmpeg wget curl zip unzip \
    python3 python3-pip && \
    apt-get clean

# Install Python packages
COPY requirements.txt /app/requirements.txt
WORKDIR /app
RUN pip3 install --upgrade pip && pip3 install -r requirements.txt

# Copy toàn bộ source vào container
COPY . /app

# Mặc định chạy API (bạn có thể tuỳ biến tuỳ script)
CMD ["python3", "app_sadtalker.py"]
