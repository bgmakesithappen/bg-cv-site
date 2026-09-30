/** @type {import('tailwindcss').Config} */
module.exports = {
  // Every template that can render, plus content/data in case they contain raw HTML classes.
  content: [
    './layouts/**/*.html',
    './themes/hugo-noir/layouts/**/*.html',
    './content/**/*.{md,html}',
    './data/**/*.toml',
  ],
  theme: {
    extend: {
      colors: {
        'bg-primary': '#0d0d1a',
        'bg-secondary': '#161625',
        'bg-tertiary': '#1e1e30',
        'text-primary': '#f3f4f6',
        'text-secondary': '#a0a0b8',
        'text-tertiary': '#6b7280',
        'border-primary': '#2d2d4a',
        'border-secondary': '#3d3d5c',
        'accent': '#00d4ff',
        'accent-pink': '#ff2d7a',
      },
    },
  },
};
