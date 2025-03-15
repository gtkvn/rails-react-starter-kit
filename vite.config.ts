import tailwindcss from '@tailwindcss/vite';
import react from '@vitejs/plugin-react';
import { defineConfig } from 'vite';
import Rails from 'vite-plugin-rails';

export default defineConfig({
  plugins: [Rails(), react(), tailwindcss()],
  esbuild: {
    jsx: 'automatic',
  },
});
