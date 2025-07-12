#!/bin/bash

echo "====== prepare... ======"

src_dir=$(pwd)
echo "src_dir: $src_dir"
cd ../..
lambda_root=$(pwd)
echo "lambda_root: $lambda_root"

echo "====== start building microservice... ======"

echo "====== installing dependencies... ======"
cd "$lambda_root"
npm install
npm run build:libs

echo "====== building TypeScript files... ======"
cd "$src_dir"
rm -rf layer/
# 创建临时目录结构
mkdir -p layer/nodejs # Terraform 将使用 layer 目录创建 zip 文件

# 复制或移动 node_modules 到正确位置
if [ -d "$lambda_root/node_modules" ]; then
  cp -r "$lambda_root/node_modules" layer/nodejs/
  # mv layer/nodejs/node_modules/@05_lambdas/libs/dist/* layer/nodejs/node_modules/@05_lambdas/libs/
  # rmdir layer/nodejs/node_modules/@05_lambdas/libs/dist
  cp -r layer/nodejs/node_modules/@05_lambdas/libs/dist/* layer/nodejs/node_modules/@05_lambdas/libs/
fi

echo "====== building Lambda layer... ======"
rm -rf build/
npx tsc

# cp "$lambda_root/.env" build/.env

echo "====== build completed successfully. ======"