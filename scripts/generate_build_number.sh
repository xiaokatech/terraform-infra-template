#!/bin/bash
# generate_build_number.sh

# 使用时间戳作为构建号
BUILD_NUMBER=$(date +%Y%m%d%H%M%S)

# 或者使用递增数字（需要持久化存储）
BUILD_FILE=".build_number"
if [ -f "$BUILD_FILE" ]; then
    BUILD_NUMBER=$(($(cat $BUILD_FILE) + 1))
else
    BUILD_NUMBER=1
fi
echo $BUILD_NUMBER > $BUILD_FILE

# 输出为 Terraform 可用的格式
echo "{\"build_number\": \"$BUILD_NUMBER\"}"
