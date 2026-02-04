/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./src/**/*.{html,js}",
    "../backend/src/main/webapp/**/*.jsp",
    "../backend/src/main/webapp/**/*.html"
  ],
  theme: {
    extend: {
      colors: {
        'ocean-blue': '#0077be',
        'sand': '#f4e4bc',
      }
    },
  },
  plugins: [],
}
