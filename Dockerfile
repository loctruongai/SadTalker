FROM nvidia/cuda:11.7.1-cudnn8-runtime-ubuntu20.04

# Thiết lập biến môi trường
ENV DEBIAN_FRONTEND=noninteractive

# Cài các thư viện hệ thống cần thiết
RUN apt-get update && apt-get install -y \
    git ffmpeg wget curl zip unzip \
    python3 python3-pip && \
    apt-get clean

# Tạo thư mục làm việc
WORKDIR /app

# Copy requirements.txt vào image
COPY requirements.txt /app/requirements.txt

# Cài đặt thư viện Python
RUN pip3 install --upgrade pip && pip3 install -r requirements.txt

# Copy toàn bộ mã nguồn vào image
COPY . /app

# Lệnh mặc định khi container chạy
CMD ["python3", "app_sadtalker.py"]
