import { app } from './app.js';
import { loadEnvironment } from '../config/env.js';

const env = loadEnvironment();
const PORT = process.env['PORT'] ? Number(process.env['PORT']) : 3001;

app.listen(PORT, () => {
  console.log(
    `[FOOTBALL_MANAGER_API] Secure Web API Server running on http://localhost:${PORT}`,
  );
  console.log(
    `[FOOTBALL_MANAGER_API] Environment: ${process.env['NODE_ENV'] || 'development'}, Supabase Project: ${env.SUPABASE_PROJECT_ID}`,
  );
});
