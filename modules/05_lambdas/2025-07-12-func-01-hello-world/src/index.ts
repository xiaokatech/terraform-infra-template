import "dotenv/config";
// console.log("process.env in index.ts");
// console.log(process.env);

export const handler = async (event: any, context: any) => {
  console.log("event", event);
  console.log("context", context);
  return {
    statusCode: 200,
    body: JSON.stringify("Hello World from nodejs20"),
  };
};
