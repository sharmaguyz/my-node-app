const express = require("express");
const app = express();

app.get("/", (_req, res) => res.send("Hello from PM2 + CodeDeploy on Ubuntu 🚀"));
app.get("/health", (_req, res) => res.status(200).send("OK"));

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Listening on ${PORT}`));
