const fs = require("fs");
const path = require("path");

function processDir(dir) {
  const files = fs.readdirSync(dir);

  files.forEach((file) => {
    const filePath = path.join(dir, file);
    const stat = fs.statSync(filePath);

    if (stat.isDirectory()) {
      processDir(filePath);
    } else if (file.endsWith(".js")) {
      let content = fs.readFileSync(filePath, "utf8");
      // 替换 require 语句中的路径
      content = content.replace(
        /require\(["']@05_lambdas\/(.*?)["']\)/g,
        'require("./@05_lambdas/$1")'
      );
      fs.writeFileSync(filePath, content);
    }
  });
}

processDir("./build");
console.log("路径替换完成！");
