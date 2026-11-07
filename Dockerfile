# Crown Asia Projects — static page in nginx
# Serves the exported single-file page (index.html, 62 MB, all assets inlined).
FROM nginx:alpine

# The exported page, copied in as the site root document.
COPY crown-asia-projects.html /usr/share/nginx/html/index.html
COPY robots.txt /usr/share/nginx/html/robots.txt
COPY sitemap.xml /usr/share/nginx/html/sitemap.xml
COPY google68b637d7672cfec2.html /usr/share/nginx/html/google68b637d7672cfec2.html

# nginx:alpine already listens on 80; keep the default config.
# Health check: the page must return HTTP 200.
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD wget -q -O /dev/null http://127.0.0.1/ || exit 1

EXPOSE 80
