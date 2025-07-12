import "dotenv/config";
// console.log("process.env in index.ts");
// console.log(process.env);

// @ts-ignore: not found awslambda
exports.handler = awslambda.streamifyResponse(
  async (event: any, responseStream: any, _context: any) => {
    try {
      console.log("hit lambdas/index.ts handler");

      responseStream.write("Hello World !");
    } catch (error: any | Error) {
      responseStream.write(JSON.stringify({ error: error.message }));
    }

    responseStream.end();
  }
);
