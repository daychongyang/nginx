import { serve } from "https://deno.land/std@0.97.0/http/server.ts";

const s = serve({ port: 12138 });

console.log("http://localhost:12138/");

for await (const req of s) {
  console.log(req.headers);
  req.respond({ body: "Hello World\n" });
}
