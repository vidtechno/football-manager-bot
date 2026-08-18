import { loadEnvironment } from './config/env.js';

export function main(): void {
  loadEnvironment();
  console.log('Football Manager bot loyihasi ishga tushirish uchun tayyor.');
}

if (process.argv[1] && process.argv[1].endsWith('index.js')) {
  main();
}
