module.exports = {
  apps: [
    {
      name: "my-node-app",
      script: "app.js",
      instances: "max",
      exec_mode: "cluster",
      env: { NODE_ENV: "development", PORT: 3000 },
      env_production: { NODE_ENV: "production", PORT: 3000 },
      max_memory_restart: "256M",
      merge_logs: true
    }
  ]
};
