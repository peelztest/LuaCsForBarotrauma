import fs from "node:fs";

import { parse as parseVdf } from "@node-steam/vdf";

process.stdout.on("error", (err) => {
  if (err.code === "EPIPE") {
    process.exit(0);
  }
});

const data = fs.readFileSync(process.stdin.fd, {
  encoding: "utf8",
});

const vdf = parseVdf(data);
fs.writeSync(process.stdout.fd, JSON.stringify(vdf));
fs.writeSync(process.stdout.fd, "\n");
