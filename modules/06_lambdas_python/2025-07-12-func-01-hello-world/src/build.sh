rm -r venv
python3 -m venv venv
source venv/bin/activate
pip install -r requirement.txt

echo "====== building Python files... ======"
rm -rf layer/
# 创建临时目录结构
mkdir -p layer/python # Terraform 将使用 layer 目录创建 zip 文件
# 复制或移动依赖包到正确位置
cp -r venv/lib/python3.*/site-packages/* layer/python/


