#!/bin/bash

# --- config ---
GH_USERNAME="your_github_username"
GH_TOKEN="your_personal_access_token_with_read_packages_scope"
IMAGE_URL="your_image_url_in_ghcr"  
# Ví dụ: ghcr.io/your_username/your_image:latest

echo "------------------------------------------"

# 1. Đăng nhập vào GHCR
# Sử dụng --password-stdin để bảo mật hơn
echo "Đang đăng nhập vào GitHub Container Registry..."
echo "$GH_TOKEN" | docker login ghcr.io -u "$GH_USERNAME" --password-stdin

# Kiểm tra xem login có thành công không
if [ $? -eq 0 ]; then
    echo "Đăng nhập GHCR thành công!"
    
    # 2. Pull Image mới nhất
    echo "Đang tải image mới: $IMAGE_URL"
    docker pull "$IMAGE_URL"
    
    if [ $? -eq 0 ]; then
        echo "Đã tải Image thành công!"
    else
        echo "Lỗi: Không thể pull image."
        exit 1
    fi
else
    echo "Lỗi: Đăng nhập thất bại. Vui lòng kiểm tra lại Token hoặc Username."
    exit 1
fi

echo "------------------------------------------"
echo "Hoàn tất!"